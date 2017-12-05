import QtQuick 2.0
import Sailfish.Silica 1.0
//import QtWebKit 3.0
import QtPositioning 5.0
import QtLocation 5.0

import "../components"

Page {
    id: page

    Map {
        id: map
        anchors.fill: parent
        plugin: Plugin {
            name: "osm"
            required.mapping: Plugin.AnyMappingFeatures
            required.geocoding: Plugin.AnyGeocodingFeatures
        }

        Component.onCompleted: {
            console.log(zoomLevel, QtPositioning.coordinate(48.19, 16.26).toString());
            vienna()
            zoomLevel = 15
        }

        onZoomLevelChanged: console.debug(zoomLevel, minimumZoomLevel, maximumZoomLevel)

        function vienna() {
            center = QtPositioning.coordinate(48.1983994,16.3555348)
        }
    }

    Row {
        id: row
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        Button {
            width: height
            text: qsTr("P")
            id: updtBtn
            onClicked: {
                map.vienna()
            }
            color: Theme.secondaryHighlightColor
        }
        Button {
            //        width: page.width/2
            width: height
            text: qsTr("+")
            id: plusBtn
            enabled: map.zoomLevel < map.maximumZoomLevel
            onClicked: map.zoomLevel = map.zoomLevel + 1
            color: Theme.secondaryHighlightColor
        }
        Button {
            //        width: page.width/2
            width: height
            text: qsTr("-")
            id: minusButton
            enabled: map.zoomLevel > map.minimumZoomLevel
            onClicked: map.zoomLevel = map.zoomLevel - 1
            color: Qt.darker(Theme.secondaryHighlightColor)
        }
        Label {
            text: map.center.toString()
            color: Theme.secondaryHighlightColor
        }
    }
}
