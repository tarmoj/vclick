#ifndef WSSERVER_H
#define WSSERVER_H

#include <QObject>
#include <QtCore/QList>
#include <QtCore/QByteArray>
#include <QtCore/QHash>
#include <QStringList>
#include <QSettings>

#include <QFile>
#include <QTime>
#include <QtMultimedia/QSoundEffect>


/*
	Copyright (C) 2016 Tarmo Johannes
	trmjhnns@gmail.com

	This file is part of eClick.

	eClick is free software; you can redistribute it and/or modify it under
	the terms of the GNU GENERAL PUBLIC LICENSE Version 3, published by
	Free Software Foundation, Inc. <http://fsf.org/>

	eClick is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with eClick; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
	02111-1307 USA
*/
#include "qosc/qoscclient.h"

QT_FORWARD_DECLARE_CLASS(QWebSocketServer)
QT_FORWARD_DECLARE_CLASS(QWebSocket)


#define OSCPORT 87878

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
	Q_INVOKABLE void runSystemCommand(QString command);

Q_SIGNALS:
    void closed();
    void newConnection(int connectionsCount);
	void newLed(int ledNumber, float duration);
	void newBeatBar(int bar, int beat);
	void newNotification(QString notification); // for future, if text to send
	void newTempo(QString tempo);
	void updateOscAddresses(QString adresses);
	void csoundMessage(QString message); // since qml and sending object must live in the same thread

	void start(QString scoreFile); // if started by remote
	void stop();

private Q_SLOTS:
    void onNewConnection();
    void processTextMessage(QString message);
    //void processBinaryMessage(QByteArray message);

public Q_SLOTS:
	void socketDisconnected();
	void handleBeatBar(int bar, int beat);
	void handleLed(int ledNumber, float duration); // to double everywhere?
	void handleNotification(QString message, float duration=4);
	void handleTempo(double tempo); // TODO: change to double/float

	void setTesting(bool testing);

private:
    QWebSocketServer *m_pWebSocketServer;
    QList<QWebSocket *> m_clients;
	bool sendOsc, sendWs;
	//QList <lo_address> targets;
	QStringList oscAddresses;
	QSettings * settings;
	QList <QOscClient *> m_oscClients;
	void createOscClientsList(QString addresses);

	QFile logFile;
	QTime time;
	QSoundEffect sound;
	bool testing;


};



#endif // WSSERVER_H
