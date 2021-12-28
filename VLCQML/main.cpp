/*
* VLC-Qt QML Player
* Copyright (C) 2015 Tadej Novak <tadej@tano.si>
*/

#include <QtCore/QCoreApplication>
#include <QtGui/QGuiApplication>
#include <QtQuick/QQuickView>

#include <VLCQtCore/Common.h>
#include <VLCQtQml/QmlVideoPlayer.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setApplicationName("VLC-QML播放器");
    QCoreApplication::setAttribute(Qt::AA_X11InitThreads);

    QGuiApplication app(argc, argv);
    VlcCommon::setPluginPath("E:/VLC/VLC/bin/plugins");
    VlcQmlVideoPlayer::registerPlugin();

    QQuickView quickView;
    quickView.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    quickView.setResizeMode(QQuickView::SizeRootObjectToView);
    quickView.show();

    return app.exec();
}
