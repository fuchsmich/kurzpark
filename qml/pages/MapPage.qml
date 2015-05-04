import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtPositioning 5.3
import QtLocation 5.0

import "../components"

Page {
    id: page

    property real longitude: 16.376323
    property real latitude: 48.199284

    PositionSource {
        id: src
        updateInterval: 1000
        active: true
        onPositionChanged: {
            var coord = src.position.coordinate;
            console.log("Coordinate:", coord.longitude, coord.latitude);
        }
    }

    Map {
     id: map
//     anchors {
//         top: parent.top
//         left: parent.left
//         right: parent.right
//         bottom: updtBtn.top
//     }
     anchors.fill: parent

     center {
         latitude: page.latitude
         longitude: page.longitude
     }

//     zoomLevel: (map.minimumZoomLevel + map.maximumZoomLevel)/6
     zoomLevel: 15 // maximumZoomLevel
     gesture.enabled: true
     plugin: Plugin {
         name: "osm"
     }
     Component.onCompleted: {
         console.log(zoomLevel)
     }
    }

//    SilicaWebView {
////        anchors.fill: parent
//        id:mapView
//        anchors {
//            top: parent.top
//            left: parent.left
//            right: parent.right
//            bottom: updtBtn.top
//        }
//        header: PageHeader { title: qsTr("Karte für ") + cityLM.currentCity.name }
//        PullDownMenu {
//            MenuItem {
//                text: "Test"
//            }
//        }

//        url: "http://m.wien.gv.at/stadtplan/#zoom=18&lat=" + latitude + "&lon=" + longitude + "&layer=kurzparkzonen"
//        Component.onCompleted: console.log(url)

//    }
    Button {
        width: page.width/2
        text: qsTr("Karte positionieren")
        id: updtBtn
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

}
