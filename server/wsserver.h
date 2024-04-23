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


/*
	Copyright (C) 2016 Tarmo Johannes
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
#include "qosc/qoscclient.h"

QT_FORWARD_DECLARE_CLASS(QWebSocketServer)
QT_FORWARD_DECLARE_CLASS(QWebSocket)


#define OSCPORT 57878

class WsServer : public QObject
{
    Q_OBJECT
public:
    explicit WsServer(quint16 port, QString userScoreFiles=QString(), QObject *parent = NULL);
    ~WsServer();

	void sendMessage(QWebSocket *socket, QString message);
	void send2all(QString message);
	Q_INVOKABLE void setSendOsc(bool onOff);
	Q_INVOKABLE void setSendWs(bool onOff);
	Q_INVOKABLE void setOscAddresses(QString addresses);
	Q_INVOKABLE QString getOscAddresses();
	Q_INVOKABLE QString getLocalAddress();
	Q_INVOKABLE void runSystemCommand(QString command);

    void updateScoreFiles();
Q_SIGNALS:
    void closed();
    void newConnection(int connectionsCount);
	void newLed(int ledNumber, float duration);
	void newBeatBar(int bar, int beat);
	void newNotification(QString notification); // for future, if text to send
	void newTempo(QString tempo);
	void updateOscAddresses(QString adresses);
	void csoundMessage(QString message); // since qml and sending object must live in the same thread
	void newOscPort(int port);

	void start(QString scoreFile); // if started by remote
    void startTime(int startSecond, bool countDown, QString soundFile=""); // if started by remote and useTime
	void stop();
	void newScoreIndex(int index);
	void newStartBar(int startBar);
    void newUseScore(bool score);
    void newStartTime(int startSecond);
    void newCountdown(bool checked);
    void newUseSoundFile(bool checked);

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
	void setScoreIndex(int index);
    void sendDawStartCommand();
    void sendDawStopCommand();
    void sendDawSeekCommand(int bar);

    void setOscPort(quint16 port);
    void setDawAddress(QString ip, quint16 port);

private:
    QWebSocketServer *m_pWebSocketServer;
    QList<QWebSocket *> m_clients;
	bool sendOsc, sendWs;
	//QList <lo_address> targets;
    QStringList oscAddresses;
    QHash <QString, int> m_clientsHash;
	QSettings * settings;
	QList <QOscClient *> m_oscClients;
    QOscClient * m_dawClient;
	void createOscClientsList(QString addresses);
    void createOscClientsList(); // takes data from m_clientsHash
	QStringList scoreFiles;
    QString userScoreFiles; // set by command line option

	QFile logFile;
	QTime time;
	int oscPort;
	int scoreIndex;
    bool useTime;
    int startSecond;
    bool countDown;


};



#endif // WSSERVER_H
