TEMPLATE = app

QT += qml quick multimedia multimediawidgets
CONFIG += c++11

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    Tank.qml \
    Lock.qml \
    Bullet.qml
macx {
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7
}
