#pragma once

#include <QObject>
#include <QUdpSocket>

#define BROADCAST_PORT 16006


class ServerDiscovery : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool discovering READ isDiscovering NOTIFY discoveringChanged)
public:
    explicit ServerDiscovery(QObject* parent = nullptr);

    Q_INVOKABLE void startDiscovery();
    Q_INVOKABLE void stopDiscovery();
    bool isDiscovering() const;
signals:
    void serverDiscovered(const QString& address, quint16 port);
    void discoveringChanged();

private slots:
    void processPendingDatagrams();

private:
    QUdpSocket m_udpSocket;
    bool m_discovering = false;
};
