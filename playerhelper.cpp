#include "playerhelper.h"
#include <QAudio>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QFileInfo>
PlayerHelper::PlayerHelper(QQuickItem *parent) : QQuickItem(parent)
{
    player = new QMediaPlayer;

}
bool  PlayerHelper::exists(const QString& file_path)
{
    return QFileInfo::exists(file_path);
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

    qDebug()<<"Exists?" << QFile::exists("D:/softwore/VLC/vlc.exe");
//    QString command = QString("D:/softwore/VLC/vlc.exe --no-dummy-quiet  %1").arg(path);
//    bool s = QProcess::startDetached(command);
//    qDebug() << "play" << command << s;
#else
    QString command = QString("/usr/bin/mplayer -really-quiet %1").arg(mp3_path);
    bool s = QProcess::startDetached(command);
    qDebug() << "play" << mp3_path << s;

#endif

//    bool s = QProcess::startDetached(QString("/usr/bin/mplayer"), QStringList() <<QString(" -really-quiet ") << mp3_path);

}
