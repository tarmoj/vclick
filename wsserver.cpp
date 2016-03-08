#include "wsserver.h"
#include "QtWebSockets/qwebsocketserver.h"
#include "QtWebSockets/qwebsocket.h"
#include <QtCore/QDebug>
#include <QDir>
#include <QNetworkInterface>


QT_USE_NAMESPACE



WsServer::WsServer(quint16 port, QObject *parent) :
    QObject(parent),
	m_pWebSocketServer(new QWebSocketServer(QStringLiteral("eClickServer"),
                                            QWebSocketServer::NonSecureMode, this)),
    m_clients()
{
    if (m_pWebSocketServer->listen(QHostAddress::Any, port)) {
        qDebug() << "WsServer listening on port" << port;
        connect(m_pWebSocketServer, &QWebSocketServer::newConnection,
                this, &WsServer::onNewConnection);
        connect(m_pWebSocketServer, &QWebSocketServer::closed, this, &WsServer::closed);
	}

	sendOsc = true;
	sendWs = false;
	settings = new QSettings("eclick","server-settings"); // TODO platform independent
	oscAddresses =  getOscAddresses().split(",");
	foreach (QString address, oscAddresses) { // what happens if oscAddresse s empty?
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

	// python serverist:

//	if 'channels' in mess_array:
//			channels = int(mess_array[mess_array.index("channels")+1]) #TODO: catch exception if not int
//		else:
//			channels = TUTTI

	if (messageParts[0]=="hello") { // comes as "hello <instrument>"
		if (messageParts.length()>1)
			QString instrument = messageParts[1];
		QString senderUrl = pClient->peerAddress().toString();
		qDebug()<<"Hello from: "<<senderUrl;
		if (!senderUrl.isEmpty()) { // append to oscAddresses and send confirmation
			lo_address target = lo_address_new(senderUrl.toLocal8Bit(), "8008");
			if (target && !oscAddresses.contains(senderUrl)) {
				oscAddresses<<senderUrl;
				targets<<target;
				emit updateOscAddresses(oscAddresses.join(","));
				lo_send(target, "/metronome/notification", "s", "Got you!");
			} else {
				qDebug()<<"Adress already registered / could not create OSC address to "<<senderUrl;
			}

		}
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
	if (sendOsc) {
		foreach(lo_address target, targets)
			lo_send(target, "/metronome/beatbar", "ii", bar, beat);
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
		foreach(lo_address target, targets)
			lo_send(target, "/metronome/led", "if", ledNumber, duration); // TODO: vana oscMetronoom ootab kestusena vist 0.05...

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
	if (sendOsc) {
		foreach(lo_address target, targets)
			lo_send(target, "/metronome/notification", "sf", message.toLocal8Bit().data(),duration);
	}


	//joke for ending
//	QStringList endmessages = QStringList()<<"Uhhh..."<<"Hästi tehtud!"<< "Läbi sai" << "OK!" << "Nu-nuu..." << "Tsss!" << "Löpp" << "Pole hullu!";
//	if (message=="end") {
//		message = endmessages[qrand()%(endmessages.length()-1)];
//	}
	if (sendWs) {
		message = "n "+message;
		send2all(message);
	}

}

void WsServer::handleTempo(QString tempo)
{
	tempo = tempo.left((tempo.indexOf("."))+3); // cut to 2 decimals
	qDebug()<<"Tempo: "<<tempo;
	if (sendOsc) {
		foreach(lo_address target, targets)
			lo_send(target, "/metronome/tempo", "f", tempo.toFloat()); // TODO: vana oscMetronoom ootab kestusena vist 0.05...

	}
	emit newTempo(tempo); // for UI
	if (sendWs) {
		send2all("t "+tempo);

	}
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

void WsServer::setSendWs(bool onOff)
{
	sendWs = onOff;
}

void WsServer::setOscAddresses(QString addresses)
{
	QStringList hosts = addresses.split(",");
	// delete lists and build up again set sendOsc to false so far.
	//TODO:
	bool oldvalue = sendOsc;
	sendOsc = false;
	oscAddresses.clear();
	targets.clear();
	foreach (QString host, hosts) {
		host = host.simplified();
		if (!host.isEmpty()) { // append to oscAddresses and send confirmation
			qDebug()<<host;
			lo_address target = lo_address_new(host.toLocal8Bit(), "8008");
			if (target) {
				if (!targets.contains(target)) {
					oscAddresses<<host;
					targets<<target;
					emit updateOscAddresses(oscAddresses.join(",")); // send back valid addresses
				}
			} else {
				qDebug()<<"Could not create OSC address to "<<host;
			}

		}

	}
	if (settings) { // store in settings
		if (addresses=="none" ||  oscAddresses.isEmpty()  ) // allow also stroring empty addresses line, but avoid invalid value.
			settings->setValue("oscaddresses", "");
		else
			settings->setValue("oscaddresses", oscAddresses);
	}
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

		}

	}
	return address;
}

