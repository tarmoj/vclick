#ifndef SERVERBROADCASTER_H
#define SERVERBROADCASTER_H

#include <QObject>
#include <QUdpSocket>
#include <QTimer>

#define BROADCAST_PORT 16006

class ServerBroadcaster : public QObject
{
    Q_OBJECT
public:
    explicit ServerBroadcaster(quint16 websocketPort, QObject *parent = nullptr);

private slots:
    void sendBroadcast();

private:
    QUdpSocket m_udpSocket;
    QTimer m_timer;
    quint16 m_websocketPort;
};

#endif // SERVERBROADCASTER_H
