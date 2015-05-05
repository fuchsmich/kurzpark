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

    function getZonesWien() {
        var url = "http://data.wien.gv.at/daten/geo?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:KURZPARKZONEOGD&srsName=EPSG:4326";
        var jsonurl = "http://data.wien.gv.at/daten/geo?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:KURZPARKZONEOGD&srsName=EPSG:4326&outputFormat=json"
        var doc = new XMLHttpRequest();

        doc.onreadystatechange = function() {
            console.log(doc.readyState)
            //            if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
            //                console.log("Headers -->");
            //                console.log(doc.getAllResponseHeaders ());
            //                console.log("Last modified -->");
            //                console.log(doc.getResponseHeader ("Last-Modified"));

            //            } else
            if (doc.readyState == XMLHttpRequest.DONE) {
                //                var a = doc.responseXML.documentElement;
                //                for (var ii = 0; ii < a.childNodes.length; ++ii) {
                //                    console.log(a.childNodes[ii].nodeName);
                //                }
                //                console.log("Headers -->");
                //                console.log(doc.getAllResponseHeaders ());
                //                console.log("Last modified -->");
                //                console.log(doc.getResponseHeader ("Last-Modified"));
                console.log(doc.responseText)
                var arr = JSON.parse(doc.responseText)
                for (var i =0; i < arr.length; i++) {
                    console.log(i, arr[i]);
                }
            }
        }

        doc.open("GET", jsonurl);
        doc.send();
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
            console.log(zoomLevel);
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
        onClicked: {
            getZonesWien();
        }
    }

}
