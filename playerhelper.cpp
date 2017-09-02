#include "playerhelper.h"
#include <QAudio>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QFile>
PlayerHelper::PlayerHelper(QQuickItem *parent) : QQuickItem(parent)
{
    player = new QMediaPlayer;

}

void PlayerHelper::play(const QString &mp3_path)
{
    qDebug() << "PlayerHelper::play(" << mp3_path<<")"<< QDir::current().absoluteFilePath(mp3_path);

    QString path = mp3_path;
    if (!mp3_path.contains("http")){
        path = QDir::current().absoluteFilePath(mp3_path);
    }
//    connect(player, SIGNAL(positionChanged(qint64)), this, SLOT(positionChanged(qint64)));
#ifdef Q_OS_WIN
//    player->setMedia(QUrl::fromLocalFile(mp3_path));
//    player->setVolume(50);
//    player->play();

    QString command = QString("C:/Program\ Files\ (x86)/VideoLAN/VLC/vlc.exe  %1").arg(path);
    bool s = QProcess::startDetached(command);
    qDebug() << "play" << command << s;
#else
    QString command = QString("/usr/bin/mplayer -really-quiet %1").arg(mp3_path);
    bool s = QProcess::startDetached(command);
    qDebug() << "play" << mp3_path << s;

#endif

//    bool s = QProcess::startDetached(QString("/usr/bin/mplayer"), QStringList() <<QString(" -really-quiet ") << mp3_path);

}
