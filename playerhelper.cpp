#include "playerhelper.h"
#include <QAudio>
#include <QProcess>
#include <QDebug>
PlayerHelper::PlayerHelper(QQuickItem *parent) : QQuickItem(parent)
{
    player = new QMediaPlayer;

}

void PlayerHelper::play(const QString &mp3_path)
{
//    connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
//    player->setMedia(QUrl::fromLocalFile(mp3_path));
//    player->setVolume(50);
//    player->play();
    QString command = QString("/usr/bin/mplayer -really-quiet %1").arg(mp3_path);
    bool s = QProcess::startDetached(command);

//    bool s = QProcess::startDetached(QString("/usr/bin/mplayer"), QStringList() <<QString(" -really-quiet ") << mp3_path);
    qDebug() << "play" << mp3_path << s;

}
