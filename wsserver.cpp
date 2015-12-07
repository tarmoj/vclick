#include "wsserver.h"
#include "QtWebSockets/qwebsocketserver.h"
#include "QtWebSockets/qwebsocket.h"
#include <QtCore/QDebug>
#include <QDir>


QT_USE_NAMESPACE



WsServer::WsServer(quint16 port, QObject *parent) :
    QObject(parent),
	m_pWebSocketServer(new QWebSocketServer(QStringLiteral("EchoServer"),
                                            QWebSocketServer::NonSecureMode, this)),
    m_clients()
{
    if (m_pWebSocketServer->listen(QHostAddress::Any, port)) {
        qDebug() << "WsServer listening on port" << port;
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection,
                this, &WsServer::onNewConnection);
        connect(m_pWebSocketServer, &QWebSocketServer::closed, this, &WsServer::closed);
    }

	sendOsc = true;  // orig: false
	oscAddresses<<"127.0.0.1"<<"192.168.1.106"; //<<"192.168.11.6"<<"192.168.11.11"<<"192.168.11.4"<<
				  "192.168.11.3";
	foreach (QString address, oscAddresses) {
		lo_address target = lo_address_new(address.toLocal8Bit(), "8008");
		if (target)
			targets<<target;

	}
}



WsServer::~WsServer()
{
    m_pWebSocketServer->close();
    qDeleteAll(m_clients.begin(), m_clients.end());
}


void WsServer::onNewConnection()
{
    QWebSocket *pSocket = m_pWebSocketServer->nextPendingConnection();

    connect(pSocket, &QWebSocket::textMessageReceived, this, &WsServer::processTextMessage);
    //connect(pSocket, &QWebSocket::binaryMessageReceived, this, &WsServer::processBinaryMessage);
    connect(pSocket, &QWebSocket::disconnected, this, &WsServer::socketDisconnected);

    m_clients << pSocket;
    emit newConnection(m_clients.count());
}



void WsServer::processTextMessage(QString message)
{
    QWebSocket *pClient = qobject_cast<QWebSocket *>(sender());
    if (!pClient) {
        return;
    }
    qDebug()<<message;

    QStringList messageParts = message.split(" ");

	// python serverist:

//	if 'channels' in mess_array:
//			channels = int(mess_array[mess_array.index("channels")+1]) #TODO: catch exception if not int
//		else:
//			channels = TUTTI


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
		handleTempo( messageParts[messageParts.indexOf("tempo")+1]);
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
	qDebug()<<"Bar: "<<bar<<" Beat: "<<beat;
	emit newBeatBar(bar, beat); // necessary, since QML reads only signals from wsServer
	QString message;
	message.sprintf("b %d %d", bar, beat); // short form to send out for javascript and app
	send2all(message);

	if (sendOsc) {
		foreach(lo_address target, targets)
			lo_send(target, "/metronome/beatbar", "ii", bar, beat);

	}
}

void WsServer::handleLed(int ledNumber, float duration) {
	qDebug()<<"Led: "<<ledNumber<<" duration: "<<duration;
	emit newLed(ledNumber,duration);
	QString message;
	message.sprintf("l %d %f", ledNumber, duration); // short form to send out for javascript and app
	send2all(message);

	if (sendOsc) {
		foreach(lo_address target, targets)
			lo_send(target, "/metronome/led", "if", ledNumber, 0.05);

	}
}

void WsServer::handleNotification(QString message)
{

	//joke for ending
	QStringList endmessages = QStringList()<<"Uhhh..."<<"Hästi tehtud!"<< "Läbi sai" << "OK!" << "Nu-nuu..." << "Tsss!" << "Löpp" << "Pole hullu!";
	if (message=="end") {
		message = endmessages[qrand()%(endmessages.length()-1)];
	}
	message = "n "+message;
	qDebug()<<"Notification: "<<message;
	send2all(message);
}

void WsServer::handleTempo(QString tempo)
{
	tempo = tempo.left((tempo.indexOf("."))+3); // cut to 2 decimals
	qDebug()<<"Tempo: "<<tempo;
	send2all("t "+tempo);
	emit newTempo(tempo);
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
	foreach (QWebSocket *socket, m_clients) {
		socket->sendTextMessage(message);
	}
}

void WsServer::setSendOsc(bool onOff)
{
	sendOsc  = onOff;
}
