import QtQuick 2.0
import Sailfish.Silica 1.0
import QtWebKit 3.0
import QtPositioning 5.3
import QtLocation 5.0

import "../components"

Page {
    id: page

    property real longitude: 16.262188168024327
    property real latitude: 48.19780945895088

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
        property var zoneCoords

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
        zoomLevel: 12 // maximumZoomLevel (=18?)
        gesture.enabled: true
        plugin: Plugin {
            name: "osm"
        }

        function getParkZones() {
            getZonesWien("http://data.wien.gv.at/daten/geo?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:KURZPARKZONEOGD&srsName=EPSG:4326&outputFormat=json");
            getZonesWien("http://data.wien.gv.at/daten/geo?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:KURZPARKSTREIFENOGD&srsName=EPSG:4326&outputFormat=json");
        }

        function getZonesWien(jsonurl) {
            //            var jsonurl = "http://data.wien.gv.at/daten/geo?service=WFS&request=GetFeature&version=1.1.0&typeName=ogdwien:KURZPARKZONEOGD&srsName=EPSG:4326&outputFormat=json"
            var doc = new XMLHttpRequest();

            doc.onreadystatechange = function() {
                if (doc.readyState === XMLHttpRequest.DONE && doc.readyState === XMLHttpRequest.DONE) {
                    var arr = JSON.parse(doc.responseText);
                    addWienFeatures(arr.features);
                }
            }
            doc.open("GET", jsonurl);
            doc.send();
        }

        function addWienFeatures(features) {
            //            bla[[1,2,3]]
            //            bla[0][0]
            //            console.log(features.length);
            for (var i = 0; i < features.length; ++i ){
                //                console.log(features[i].id)
                var dauer = features[i].properties.DAUER.replace(",",".")
                dauer = dauer.substring(0,dauer.length-1)
                if (features[i].geometry.type === "MultiPolygon") {
                    var coordArr = features[i].geometry.coordinates;
                    for (var j=0; j < coordArr.length; ++j) {
                        for (var jj=0; jj < coordArr[j].length; ++jj) {
                            var newZone = zoneDelegate.createObject(map);
                            for (var jjj=0; jjj < coordArr[j][jj].length; ++jjj) {
                                //                                for (var jjjj=0; jjjj < coordArr[j][jj][jjj].length; ++jjjj) {
                                var coords = coordArr[j][jj][jjj] //[jjjj]
                                newZone.addCoordinate(QtPositioning.coordinate(coords[1], coords[0]));
                                //                                }
                            }
                            newZone.opacity = newZone.opacity*dauer
                            map.addMapItem(newZone)
                            //                            console.log("MapItems", map.mapItems.length)
                        }
                    }
                }
                if (features[i].geometry.type === "Polygon") {
                    coordArr = features[i].geometry.coordinates;
                    newZone = zoneDelegate.createObject(map);
                    for (j=0; j < coordArr.length; ++j) {
                        for (jj=0; jj < coordArr[j].length; ++jj) {
                            //                            for (var jjj=0; jjj < coordArr[j][jj].length; ++jjj) {
                            //                                for (var jjjj=0; jjjj < coordArr[j][jj][jjj].length; ++jjjj) {
                            coords = coordArr[j][jj]//[jjj] //[jjjj]
                            newZone.addCoordinate(QtPositioning.coordinate(coords[1], coords[0]));
                            //                                }
                            //                            }
                        }
                    }
                    newZone.opacity = newZone.opacity*dauer
                    map.addMapItem(newZone)
                    //                    console.log("MapItems", map.mapItems.length)
                }
                if (features[i].geometry.type === "LineString") {
                    coordArr = features[i].geometry.coordinates;
                    newZone = zoneDelegate.createObject(map);
                    for (j=0; j < coordArr.length; ++j) {
                        //                        for (jj=0; jj < coordArr[j].length; ++jj) {
                        //                            for (var jjj=0; jjj < coordArr[j][jj].length; ++jjj) {
                        //                                for (var jjjj=0; jjjj < coordArr[j][jj][jjj].length; ++jjjj) {
                        coords = coordArr[j]//[jj]//[jjj] //[jjjj]
                        newZone.addCoordinate(QtPositioning.coordinate(coords[1], coords[0]));
                        //                                }
                        //                            }
                        //                        }
                    }
                    newZone.opacity = newZone.opacity*dauer;
                    newZone.color = "red";
                    newZone.border.width = 3;
                    map.addMapItem(newZone);
                    console.log("MapItems", map.mapItems.length);
                }
            }
        }


        Component {
            id: zoneDelegate

            MapPolygon {
                border.width: 1
                border.color: color
                color: "blue"
                opacity: 0.5/3
            }
        }

        Component.onCompleted: {
            console.log(zoomLevel);
            getParkZones();
        }
    }
    Row {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        Button {
            width: page.width/4
            text: qsTr("nix")
            id: updtBtn
            onClicked: {
                //            getZonesWien();
            }
        }
        Button {
            //        width: page.width/2
            width: page.width/4
            text: qsTr("+")
            id: plusBtn
            enabled: map.zoomLevel < map.maximumZoomLevel
            onClicked: map.zoomLevel = map.zoomLevel + 1
        }
        Button {
            //        width: page.width/2
            width: page.width/4
            text: qsTr("-")
            id: minusButton
            enabled: map.zoomLevel > map.minimumZoomLevel
            onClicked: map.zoomLevel = map.zoomLevel - 1
        }
    }

}
