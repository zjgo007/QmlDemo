import QtQuick 2.0
import VLCQt 1.0

Rectangle {
    width: 640
    height: 480
    color: "black"

    VlcVideoPlayer {
        id: vidwidget
        anchors.fill: parent
        url: "http://ivi.bupt.edu.cn/hls/cctv1hd.m3u8"
    }
}
