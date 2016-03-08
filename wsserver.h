#ifndef WSSERVER_H
#define WSSERVER_H

#include <QObject>
#include <QtCore/QList>
#include <QtCore/QByteArray>
#include <QtCore/QHash>
#include <QStringList>
#include <QSettings>


#include <lo/lo.h> // for osc // perhaps native OSC class from GoOSC
//#include "qosc/qoscclient.h"

QT_FORWARD_DECLARE_CLASS(QWebSocketServer)
QT_FORWARD_DECLARE_CLASS(QWebSocket)


class WsServer : public QObject
{
    Q_OBJECT
public:
    explicit WsServer(quint16 port, QObject *parent = NULL);
    ~WsServer();

	void sendMessage(QWebSocket *socket, QString message);
	void send2all(QString message);
	Q_INVOKABLE void setSendOsc(bool onOff);
	Q_INVOKABLE void setSendWs(bool onOff);
	Q_INVOKABLE void setOscAddresses(QString addresses);
	Q_INVOKABLE QString getOscAddresses();
	Q_INVOKABLE QString getLocalAddress();

Q_SIGNALS:
    void closed();
    void newConnection(int connectionsCount);
	void newLed(int ledNumber, float duration);
	void newBeatBar(int bar, int beat);
	void newNotification(QString notification); // for future, if text to send
	void newTempo(QString tempo);
	void updateOscAddresses(QString adresses);

private Q_SLOTS:
    void onNewConnection();
    void processTextMessage(QString message);
    //void processBinaryMessage(QByteArray message);

public Q_SLOTS:
	void socketDisconnected();
	void handleBeatBar(int bar, int beat);
	void handleLed(int ledNumber, float duration);
	void handleNotification(QString message, float duration=4);
	void handleTempo(QString tempo); // TODO: change to double/float

private:
    QWebSocketServer *m_pWebSocketServer;
    QList<QWebSocket *> m_clients;
	bool sendOsc, sendWs;
	QList <lo_address> targets;
	QStringList oscAddresses;
	QSettings * settings;
	// TODO: QOscClient * oscClient;


};



#endif // WSSERVER_H
