TEMPLATE = app

QT += qml quick multimedia multimediawidgets
CONFIG += c++11

SOURCES += main.cpp \
    playerhelper.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    Tank.qml \
    Lock.qml \
    Bullet.qml \
    Oppressor.qml \
    shanbay.js
macx {
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.7
}
  static {
      QTPLUGIN += qtvirtualkeyboardplugin
  }
HEADERS += \
    playerhelper.h
