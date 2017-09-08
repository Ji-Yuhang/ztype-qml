#ifndef PLAYERHELPER_H
#define PLAYERHELPER_H

#include <QObject>
#include <QQuickItem>
#include <QMediaPlayer>

class PlayerHelper : public QQuickItem
{
    Q_OBJECT
public:
    explicit PlayerHelper(QQuickItem *parent = 0);
    Q_INVOKABLE void play(const QString& mp3_path);
    Q_INVOKABLE bool exists(const QString& file_path);

    QMediaPlayer* player ;
signals:

public slots:
};

#endif // PLAYERHELPER_H
