#include "serverbroadcaster.h"
#include <QNetworkInterface>
#include <QHostAddress>

ServerBroadcaster::ServerBroadcaster(quint16 websocketPort, QObject *parent)
    :  QObject{parent}, m_websocketPort(websocketPort)
{
    connect(&m_timer, &QTimer::timeout, this, &ServerBroadcaster::sendBroadcast);
    m_timer.start(2000); // Broadcast every 2 seconds
}

void ServerBroadcaster::sendBroadcast()
{
    QString message = QString("vClickServer:%1").arg(m_websocketPort);
    QByteArray datagram = message.toUtf8();

    QHostAddress broadcastAddress = QHostAddress::Broadcast;
    quint16 broadcastPort = BROADCAST_PORT;

    m_udpSocket.writeDatagram(datagram, broadcastAddress, broadcastPort);
}
