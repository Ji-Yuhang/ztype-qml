#include "playerhelper.h"
#include <QAudio>
#include <QProcess>
#include <QDebug>
#include <QDir>
#include <QFile>
#include <QFileInfo>
PlayerHelper::PlayerHelper(QQuickItem *parent) : QQuickItem(parent)
{
//    player = new QMediaPlayer;
    for (int i = 0; i < 10; i++){
        players_.push_back(new QMediaPlayer);
    }
    QFile file(":/bgl_java_output.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "can not open file qrc:/bgl_java_output.txt ";
        return;

    }

    while (!file.atEnd()) {
        QString line = file.readLine();
        QStringList parts = line.split("!@#$");
        QString head_word = parts.at(0);
        QString word = parts.at(1);
        QString definition = parts.at(2);
        QString phonetics = parts.at(3);
        if (!bgls_.contains(word))
            bgls_.insert(word, parts );
    }
    qDebug() << "bgls_ insert "<< bgls_.size();

}

bool  PlayerHelper::exists(const QString& file_path)
{
    return QFileInfo::exists(file_path);
}
QStringList PlayerHelper::bgl(const QString& word){
    qDebug() << "PlayerHelper get bgl"<<word<< bgls_.size();

    return bgls_.value(word);
}

void PlayerHelper::play(const QString &mp3_path)
{
    qDebug() << "PlayerHelper::play(" << mp3_path<<")"<< QDir::current().absoluteFilePath(mp3_path);

    QString path = mp3_path;
    if (!mp3_path.contains("http")){
        path = QDir::current().absoluteFilePath(mp3_path);
    }
    if (mp3_path.contains("qrc:")){
        path = mp3_path;
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

#define TEST_QMediaPlayer
#ifdef TEST_QMediaPlayer
     QMediaPlayer* player = NULL;
     for (QList<QMediaPlayer*>::Iterator it = players_.begin(); it != players_.end(); it++){
          QMediaPlayer* temp = *it;
         if (temp->state() == QMediaPlayer::StoppedState){
             player = temp;
             break;
         }
     }
     if (!player) {
         player = new QMediaPlayer;
         players_.push_back(player);
         for (int i = 0; i < 10; i++){
             players_.push_back(new QMediaPlayer);
         }
     }
     if (mp3_path.contains("qrc:")) {
             qDebug() << "play qrc" << path << QUrl(path);

         player->setMedia(QUrl(path));
     } else if (mp3_path.contains("http:")){
         qDebug() << "play http" << path << QUrl(path);

         player->setMedia(QUrl(path));
     } else {
         player->setMedia(QUrl::fromLocalFile(path));
     }
//        player->setMedia()
        player->setVolume(100);
        player->play();

#else
    QString command = QString("/usr/bin/mplayer -really-quiet %1").arg(mp3_path);
    bool s = QProcess::startDetached(command);
    qDebug() << "play" << mp3_path << s;
#endif


#endif

//    bool s = QProcess::startDetached(QString("/usr/bin/mplayer"), QStringList() <<QString(" -really-quiet ") << mp3_path);

}
