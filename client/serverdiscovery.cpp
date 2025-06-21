#include "serverdiscovery.h"
#include <QDebug>

ServerDiscovery::ServerDiscovery(QObject* parent)
    : QObject(parent)
{
}

bool ServerDiscovery::isDiscovering() const
{
    return m_discovering;
}

void ServerDiscovery::startDiscovery()
{
    if (m_discovering)
        return;

    bool success = m_udpSocket.bind(BROADCAST_PORT, QUdpSocket::ShareAddress | QUdpSocket::ReuseAddressHint);
    if (!success) {
        qWarning() << "Failed to bind UDP socket for discovery";
        return;
    }

    connect(&m_udpSocket, &QUdpSocket::readyRead, this, &ServerDiscovery::processPendingDatagrams);
    m_discovering = true; // TODO: add timeout and message
    emit discoveringChanged();
}


void ServerDiscovery::processPendingDatagrams()
{
    while (m_udpSocket.hasPendingDatagrams()) {
        QByteArray datagram;
        datagram.resize(m_udpSocket.pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        m_udpSocket.readDatagram(datagram.data(), datagram.size(), &sender, &senderPort);
        QString message = QString::fromUtf8(datagram);

        if (message.startsWith("vClickServer:")) {
            bool ok;
            quint16 wsPort = message.section(':', 1).toUShort(&ok);
            if (ok) {
                QString address = sender.toString().remove("::ffff:");
                qDebug() << "Discovered server at" << address << ":" << wsPort;
                emit serverDiscovered(address, wsPort);
                m_discovering = true;
                emit discoveringChanged();
            }
        }
    }
}


void ServerDiscovery::stopDiscovery()
{
    if (!m_discovering)
        return;

    m_udpSocket.close();
    disconnect(&m_udpSocket, &QUdpSocket::readyRead, this, &ServerDiscovery::processPendingDatagrams);
    m_discovering = false;
    emit discoveringChanged();
}
