/*
	Copyright (C) 2016-2019 Tarmo Johannes
	trmjhnns@gmail.com

	This file is part of vClick.

	vClick is free software; you can redistribute it and/or modify it under
	the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
	Free Software Foundation, Inc. <http://fsf.org/>

	vClick is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with vClick; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/
#include "wsserver.h"
#include "QtWebSockets/qwebsocketserver.h"
#include "QtWebSockets/qwebsocket.h"
#include <QtCore/QDebug>
#include <QDir>
#include <QNetworkInterface>


QT_USE_NAMESPACE



WsServer::WsServer(quint16 port, QString userScoreFiles, bool noOsc, QObject *parent) :
    QObject(parent),
    m_pWebSocketServer(new QWebSocketServer(QStringLiteral("vClickServer"),
                                            QWebSocketServer::NonSecureMode, this)),
    m_clients(),
    m_oscClients(),
    userScoreFiles(userScoreFiles),
    useOsc(!noOsc)
{
    if (m_pWebSocketServer->listen(QHostAddress::Any, port)) {
        qDebug() << "WsServer listening on port" << port;
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection,
                this, &WsServer::onNewConnection);
        connect(m_pWebSocketServer, &QWebSocketServer::closed, this, &WsServer::closed);
	}

	settings = new QSettings("vclick","server"); // TODO platform independent
	sendOsc = settings->value("sendOsc", false).toBool(); //false; // might be necessary to set to true only if driven by external ws-messages or sent from jack client
	// if used as no-gui server application, always send ws out, too
#ifdef CONSOLE_APP
	sendWs = true;
#else
	sendWs = settings->value("sendWs", false).toBool();
#endif
    if (useOsc) {
        createOscClientsList(getOscAddresses());
        oscPort = settings->value("oscPort", 57878).toInt();
    }
    updateScoreFiles();
    scoreIndex = 0; // or should it come from UI or settings?
    useTime = false;
    startSecond = 0;
    countDown = true; // in case of useTime
}



WsServer::~WsServer()
{
    m_pWebSocketServer->close();
    qDeleteAll(m_clients.begin(), m_clients.end());
}

void WsServer::updateScoreFiles()
{
    if (userScoreFiles.isEmpty()) {
        scoreFiles = settings->value("scoreFiles", "").toString().split(";");
    } else {
        scoreFiles = userScoreFiles.split(";");
    }
    qDebug() << Q_FUNC_INFO << scoreFiles;

}

QString WsServer::getScoreList()
{
    QString scoreList = QString("scoreFiles:");
    for (QString scoreFile: scoreFiles) {
        QString fileName = scoreFile.trimmed().split('/').last(); // get only the filename;
        if (fileName.endsWith(".sco", Qt::CaseInsensitive)) {
            fileName = fileName.chopped(4);
        }
        if (!fileName.isEmpty()) {
            scoreList += fileName + ";";
        }
    }
    if (scoreList.right(1) == ";") {
        scoreList.chop(1); // remove last semicolon
    }
    qDebug() << Q_FUNC_INFO << scoreList;
    return scoreList;

}

void WsServer::onNewConnection()
{
    QWebSocket *pSocket = m_pWebSocketServer->nextPendingConnection();

    connect(pSocket, &QWebSocket::textMessageReceived, this, &WsServer::processTextMessage);
    //connect(pSocket, &QWebSocket::binaryMessageReceived, this, &WsServer::processBinaryMessage);
    connect(pSocket, &QWebSocket::disconnected, this, &WsServer::socketDisconnected);

    m_clients << pSocket;
	emit newConnection(m_clients.count()); //TODO: kui enamus OSC-ga, siis näita pigem, mitu OSC aadressi reas
}



void WsServer::processTextMessage(QString message)
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (!pClient) {
        return;
    }
    qDebug()<<message;

    QStringList messageParts = message.split(" ");

	if (messageParts[0]=="hello") { // comes as "hello <instrumentnumber>"

        int instrument = 0;
        if (messageParts.length()>1) {
            instrument = messageParts[1].toInt(); // for future, check if instrument number has changed
            qDebug()<<"Instrument no "<<instrument;
		}
		QString senderUrl = pClient->peerAddress().toString();
		senderUrl.remove("::ffff:"); // if connected via websocket, this is added to beginning

        // send the score list to client
        pClient->sendTextMessage(getScoreList());

        if (useOsc) {
            QOscClient * target = nullptr;
            if (!senderUrl.isEmpty()) { // append to oscAddresses and send confirmation

                target = new QOscClient(pClient->peerAddress(),oscPort,this); // what if localhost, does it work then?
                if (target) {
                    if (!oscAddresses.contains(senderUrl)) {
                        oscAddresses<<senderUrl; // probably not necessary to keep that variable.
                        //emit updateOscAddresses(oscAddresses.join(","));
                        m_oscClients << target;
                        //target->sendData("/metronome/notification", "Got you!" );
                    } else {
                        qDebug()<<"Adress already registered: "<<senderUrl;
                        //target->sendData("/metronome/notification", "All fine" );
                    }
                } else {
                    qDebug()<<"Could not create OSC address to "<<senderUrl;
                }
            }

            if (m_clientsHash.contains(senderUrl) && m_clientsHash[senderUrl]==instrument  ) {
                qDebug()<<"The IP address " << senderUrl << " is already connected" ;
                if (target) {
                    target->sendData("/metronome/notification", "All fine!" );
                }
            } else {
                qDebug()<<"Something new (either IP, instrument no or both): "<< senderUrl << instrument ;
                if (!senderUrl.isEmpty()) {
                    m_clientsHash[senderUrl] = instrument; // overwrites, if new instrument, otherwise inserts
                    createOscClientsList();
                } else {
                    qDebug()<<"SenderUrl empty.";
                }
                if (target) {
                    target->sendData("/metronome/notification", "Got you!" );
                }
            }
        }
		// pClient->close(QWebSocketProtocol::CloseCodeNormal); // do not close for remote control
	}


	if (messageParts[0]=="start") {
		qDebug()<<"Remote call to start vClick";
        updateScoreFiles();
		QString scoreFile;
		if (messageParts.length()>1) {
            scoreFile = messageParts[1].trimmed(); // for future
		} else if ( scoreFiles.count()>=0 ) {
            scoreFile = scoreFiles[scoreIndex].trimmed();
		}
        qDebug() << "scoreFile: " << scoreFile << scoreIndex;

#ifdef CONSOLE_APP
        if (useOsc) {
            emit newOscPort(oscPort);
            createOscClientsList(); // this should update te oscaddresses in CsEngine. Which order? Need sleep?
        }
#endif
        // TODO: the start problem is here: sometimes there is no scoreFile
        if (!useTime) {
            // Something wrong here: ....
            emit start(scoreFile); // message to QML to set the scorename and start Csound // NB! Was QString before
        } else {
#ifdef CONSOLE_APP
            emit startTime(startSecond, countDown, ""); // no soundfile support for now -  forwarded to CsEnginge
#else
            emit start(""); // forwarded to QML
#endif
        }
	}

	if (messageParts[0]=="stop") {
		qDebug()<<"Remote call to stop vClick";
		emit stop();
		bool oldSendOsc = sendOsc;
		sendOsc = true;
		handleNotification("Stop", 2);
		sendOsc = oldSendOsc;

	}

	if (messageParts[0]=="scoreIndex") {
		int index = messageParts[1].toInt();
		qDebug()<<"Remote set score index " << index;
		emit newScoreIndex(index); // message to QML to set the active score if there are several
		setScoreIndex(index);
		bool oldSendOsc = sendOsc;
		sendOsc = true;
		handleNotification(QString("Score %1").arg(index + 1), 2);
		sendOsc = oldSendOsc;

	}

	if (messageParts[0]=="startBar") {
		int startBar = messageParts[1].toInt();
		qDebug()<<"Remote set startbar" << startBar;
		emit newStartBar(startBar);
		bool oldSendOsc = sendOsc;
		sendOsc = true;
		handleNotification(QString("Bar %1").arg(startBar), 2);
		sendOsc = oldSendOsc;
	}

    if (messageParts[0]=="useScore") {
        qDebug()<<"Remote useScore";
        useTime = false;
        emit newUseScore(true);
        bool oldSendOsc = sendOsc;
        sendOsc = true;
        handleNotification("Use score", 2);
        sendOsc = oldSendOsc;
    }

    if (messageParts[0]=="useTime") {
        qDebug()<<"Remote useTime";
        useTime = true;
        emit newUseScore(false);
        bool oldSendOsc = sendOsc;
        sendOsc = true;
        handleNotification("Use time", 2);
        sendOsc = oldSendOsc;
    }

    if (messageParts[0]=="startTime") {
        int startSecond = messageParts[1].toInt();
        qDebug()<<"Remote set startbar" << startSecond;
        this->startSecond = startSecond;
        emit newStartTime(startSecond);
        bool oldSendOsc = sendOsc;
        sendOsc = true;
        handleNotification(QString("Start %1").arg(startSecond), 2);
        sendOsc = oldSendOsc;
    }

    if (messageParts[0]=="countdown") {
        bool checked = static_cast<bool>( messageParts[1].toInt());
        qDebug()<<"Remote set countdown" << checked;
        countDown = checked;
        emit newCountdown(checked);
        bool oldSendOsc = sendOsc;
        sendOsc = true;
        handleNotification(QString("Countdown %1").arg(checked), 2);
        sendOsc = oldSendOsc;
    }

    if (messageParts[0]=="useSoundFile") {
        bool checked = static_cast<bool>( messageParts[1].toInt());
        qDebug()<<"Remote set useSoundFile" << checked;
        emit newUseSoundFile(checked);
        // no support for playing sound file in CONSOLE_APP mode yet...
        bool oldSendOsc = sendOsc;
        sendOsc = true;
        handleNotification(QString("SoundFile %1").arg(checked), 2);
        sendOsc = oldSendOsc;
    }


	int bar = -1, beat = -1, led = -1;
	float duration = 0;
	if (messageParts.contains("bar")) {
		bar = messageParts[messageParts.indexOf("bar")+1].toInt();
	}

	if (messageParts.contains("beat")) {
		beat = messageParts[messageParts.indexOf("beat")+1].toInt();
	}

	if (messageParts.contains("duration")) {
		duration = messageParts[messageParts.indexOf("duration")+1].toFloat();
	}

	if (messageParts.contains("led")) {
		led = messageParts[messageParts.indexOf("led")+1].toInt();
	}

	if (messageParts.contains("notification")) { //NB! maybe there should be also a slot and later csound string channel
		QString notification = message.split("notification")[1]; // get the message
		handleNotification(notification.simplified());
	}

	if (messageParts.contains("tempo")) {
		handleTempo( messageParts[messageParts.indexOf("tempo")+1].toDouble());
	}

	if (bar>=0 && beat>=0)  // format message shorter for javascript
		handleBeatBar(bar,beat);

	if (led >= 0)
		handleLed(led,duration);


}

//void WsServer::processBinaryMessage(QByteArray message)
//{
//    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
//    if (pClient) {
//        pClient->sendBinaryMessage(message);
//    }
//}

void WsServer::socketDisconnected()
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (pClient) {
        m_clients.removeAll(pClient);
        emit newConnection(m_clients.count());
        pClient->deleteLater();
	}
}

void WsServer::handleBeatBar(int bar, int beat)
{
	//qDebug()<<"Bar: "<<bar<<" Beat: "<<beat;
	emit newBeatBar(bar, beat); // necessary, since QML reads only signals from wsServer
	// for testing:
//	int now, difference=0;
	if (sendOsc) {
        for(QOscClient * target: m_oscClients) {
			QList<QVariant> data;
			data << bar << beat;
			target->sendData("/metronome/beatbar", data);
		}
	}
	if (sendWs) {
		QString message;
		message.sprintf("b %d %d", bar, beat); // short form to send out for javascript and app
		send2all(message);
	}


}

void WsServer::handleLed(int ledNumber, float duration) {
	qDebug()<<"Led: "<<ledNumber<<" duration: "<<duration;
	emit newLed(ledNumber,duration);
	if (sendOsc) {
        for (QOscClient * target: m_oscClients) {
			QList<QVariant> data;
			data << ledNumber << (double)duration; // QOsc types does not recognise float...
			target->sendData("/metronome/led", data);
		}
	}

	if (sendWs) {
		QString message;
		message.sprintf("l %d %f", ledNumber, duration); // short form to send out for javascript and app
		send2all(message);
	}


}

void WsServer::handleNotification(QString message, float duration)
{
	qDebug()<<"Notification: "<<message <<" for " << duration << "seconds.";
    if (useOsc && sendOsc) {
        for (QOscClient * target: m_oscClients) {
			QList<QVariant> data;
			data << message << (double)duration; // QOsc types does not recognise float...
			target->sendData("/metronome/notification", data);
		}
	}

	if (sendWs) {
        message = "n "+message; // no duration sent to client over ws, use default
		send2all(message);
	}

}

void WsServer::handleTempo(double tempo) // TODO: change to double, not string
{
	//tempo = tempo.left((tempo.indexOf("."))+3); // cut to 2 decimals
	//qDebug()<<"Tempo: "<<tempo;
    if (useOsc && sendOsc) {
        for (QOscClient * target: m_oscClients) {
			target->sendData("/metronome/tempo", tempo);
		}
	}
	QString tempoString = QString::number(tempo, 'f',2);
	emit newTempo(tempoString); // construct string here!
	if (sendWs) {
		send2all("t "+tempoString);

	}
}

void WsServer::setScoreIndex(int index)
{
	if (index>=0 && index<scoreFiles.count()) {
		scoreIndex = index;
	} else {
		qDebug() << "Cannot set score index: " << index;
	}
}


void WsServer::setOscPort(int port) {
	oscPort = port;
	qDebug() << Q_FUNC_INFO << port;
#ifdef CONSOLE_APP
    if (settings) {
		settings->setValue("oscPort", oscPort);
	}
#endif
	emit newOscPort(oscPort);
}

void WsServer::createOscClientsList(QString addresses) // info from string to hash
{
    m_clientsHash.clear();
    int instrument = 0;

    for (QString address: addresses.split(",")) {
        address = address.simplified();
        int index = -1;
        index = QRegExp("(^[0-9]{1,2}):").indexIn(address); // should I check for port at all?
        if (index>=0) {

            instrument = address.split(":")[0].toInt();
            address = address.split(":")[1];
            address = (address=="localhost") ? "127.0.0.1" : address;
            qDebug()<<"Found instreument " << instrument << "for: " << address;
        } else  {
            instrument = 0;
        }
        if (!address.isEmpty())
            m_clientsHash[address]=instrument;
        else
            qDebug()<<"Address is empty";
    }
    createOscClientsList(); // and create OSC clients (for now) and update on UI
}

void WsServer::createOscClientsList()
{
    oscAddresses.clear();
    m_oscClients.clear();

    QString joinedString;

    for (QString address: m_clientsHash.keys()) {
        address = address.simplified();
        address = (address=="localhost") ? "127.0.0.1" : address; // does not like "localhost" as string
        if (m_clientsHash[address]==0) {
            joinedString += address+",";
        } else {
            joinedString += QString::number(m_clientsHash[address])+":"+address+",";
        }


        if (!address.isEmpty()) { // for any case
			QOscClient * client = new QOscClient(QHostAddress(address), (quint16) oscPort, this); // leve it for now -  create addresses but do not send if sendOsc==false
            if (client) {
                m_oscClients<<client; // muuda target oscClient vms
                oscAddresses<<address;
                //testing
                client->sendData("/test", address);
            } else {
                qDebug()<<"Could not create OSC address to "<<address;
            }
        }
    }
    if (joinedString.right(1) == "," ) {
        joinedString.chop(1);
    }


	if (settings) { // store in settings with port numbers
		if (joinedString.isEmpty()  ) // allow also stroring empty addresses line, but avoid invalid value.
			settings->setValue("oscaddresses", "");
		else
			settings->setValue("oscaddresses", joinedString);
	}

    emit updateOscAddresses(joinedString);
    qDebug()<<"OSC targets count: " << m_oscClients.count();
}


void WsServer::sendMessage(QWebSocket *socket, QString message )
{
    if (socket == 0)
    {
        return;
    }
    socket->sendTextMessage(message);

}


void WsServer::send2all(QString message)
{

    for (QWebSocket *socket: m_clients) {
		socket->sendTextMessage(message);
	}
}


void WsServer::setSendOsc(bool onOff)
{
	sendOsc  = onOff;
}

void WsServer::setSendWs(bool onOff)
{
	sendWs = onOff;
}

void WsServer::setOscAddresses(QString addresses)
{
	bool oldvalue = sendOsc;
	sendOsc = false; // as kind of mutex not to send any osc messages during that time

	createOscClientsList(addresses);
	sendOsc = oldvalue;
}

QString WsServer::getOscAddresses()
{
	if (settings) {
		QVariant value = settings->value("oscaddresses");
		if (value.type()==QMetaType::QString)
			return value.toString();
		else if (value.type()==QMetaType::QStringList)
			return value.toStringList().join(",");
		else
			return QString();
	}
    return QString();
}

QString WsServer::getLocalAddress()
{
	QString address = QString();
	QList <QHostAddress> localAddresses = QNetworkInterface::allAddresses();
	for(int i = 0; i < localAddresses.count(); i++) {

		if(!localAddresses[i].isLoopback())
			if (localAddresses[i].protocol() == QAbstractSocket::IPv4Protocol ) {
				address = localAddresses[i].toString();
				qDebug() << "YOUR IP: " << address;
				break; // get the first address
		}

	}
	return address;
}

void WsServer::runSystemCommand(QString command)
{
	system(command.toLocal8Bit());
}

