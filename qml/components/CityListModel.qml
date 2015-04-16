/*
  Copyright (C) 2015 Michael Fuchs
  Contact: Michael Fuchs <michfu@gmx.at>
  All rights reserved.
*/

import QtQuick 2.0
import QtQuick.LocalStorage 2.0

ListModel {
    //    id: cityListModel
    property int currentIndex: 0
    property int currentTimeZoneIndex: 0
    property int currentTimeIndex: 0

    property var currentCity: get(currentIndex)
    property var currentZone: currentCity.timeZoneList.get(currentTimeZoneIndex)
    property var currentTime: currentZone.timeList.get(currentTimeIndex)

    property string dbName: "KurzParkDB"
    property string dbDesc: "KurzParkDB"
    property string dbVersion: "1.0"

    function load() {
        var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS CityList(currentIndex INTEGER, currentTimeIndex INTEGER)');
                        var res = tx.executeSql('SELECT * FROM CityList')
                        if (res.rows.length > 0) {
                            currentIndex = res.rows.item(0).currentIndex
                            currentTimeIndex = res.rows.item(0).currentTimeIndex
                        }
                    }
                    )
        console.log("Time loaded.")
    }

    function save() {
        var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS CityList(currentIndex INTEGER, currentTimeIndex INTEGER)');
                        var res = tx.executeSql('SELECT * FROM CityList')
                        if (res.rows.length > 0) {
                            tx.executeSql('UPDATE CityList SET currentIndex=?, currentTimeIndex=?',
                                          [currentIndex, currentTimeIndex])
                        }
                        else tx.executeSql('INSERT INTO CityList (currentIndex, currentTimeIndex) VALUES (?, ?)',
                                           [currentIndex, currentTimeIndex])
                    }
                    )
        console.log("Time saved.")
    }

    Component.onCompleted: load();
    onCurrentIndexChanged: save();
    onCurrentTimeIndexChanged: save();


    ListElement {
        // Zeit Stadt*KZ
        name: "Wien";
        phoneNumbers: [
            ListElement{number: "+436646600990"},
            ListElement{number: "+436646606000"}
        ]
        text: "Wien";
        timeModel: "discrete";
        timeZoneList: [
            ListElement{zone: " ";
                timeList: [
                    ListElement{time: 15; costs: 0},
                    ListElement{time: 30; costs: 1},
                    ListElement{time: 60; costs: 2},
                    ListElement{time: 90; costs: 3},
                    ListElement{time: 120; costs: 4},
                    ListElement{time: 180; costs: 6}
                ]
            }
        ]
    }

    ListElement {
        // Zeit Stadt*KZ
        name: "Amstetten";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Amstetten";
        timeModel: "discrete";
        timeZoneList: [
            ListElement{zone: " ";
                timeList: [
                    ListElement{time: 10; costs: 0},
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5},
                    ListElement{time: 120; costs: 2},
                    ListElement{time: 150; costs: 2.5},
                    ListElement{time: 180; costs: 3.0}
                ]
            }
        ]
    }

    ListElement {
        // Zeit Zone Stadt*KZ
        name: "Baden";
        phoneNumbers:[
            ListElement{number: "+438006644242"}
        ]
        text: "Baden";
        timeModel: "discrete";
        timeZoneList: [
            ListElement{zone: "Z1";
                timeList: [
                    ListElement{time: 15; costs: 0},
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5}
                ]
            },
            ListElement{zone: "Z2";
                timeList: [
                    ListElement{time: 15; costs: 0},
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5},
                    ListElement{time: 120; costs: 2},
                    ListElement{time: 150; costs: 2.5},
                    ListElement{time: 180; costs: 3.0}
                ]
            }
        ]
    }

    ListElement {
        // Start Zone Stadt*KZ
        name: "Bludenz";
        phoneNumbers:[
            ListElement{number: "+438006644242"}
        ]
        text: "Bludenz";
        timeModel: "startstop";
        timeZoneList: [
            ListElement{zone: " Z1";
                timeList: [
                    ListElement{time: 0; costs: 0},
                    ListElement{time: 1; costs: 0}
                ]
            },
            ListElement{zone: " Z2";
                timeList: [
                    ListElement{time: 0; costs: 0},
                    ListElement{time: 1; costs: 0}
                ]
            },
            ListElement{zone: " Z2a";
                timeList: [
                    ListElement{time: 0; costs: 0},
                    ListElement{time: 1; costs: 0}
                ]
            },
            ListElement{zone: " Z3";
                timeList: [
                    ListElement{time: 0; costs: 0},
                    ListElement{time: 1; costs: 0}
                ]
            }
        ]
    }

    ListElement {
        // ZeitZone Stadt*KZ
        name: "Bregenz";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Bregenz";
        timeModel: "discrete";
        timeZoneList: [
            ListElement{zone: "A";
                timeList: [
                    ListElement{time: 17; costs: 0},
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5}
                ]
            },
            ListElement{zone: "AA";
                timeList: [
                    ListElement{time: 17; costs: 0},
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5}
                ]
            }
        ]
    }

    ListElement {
        name: "Mödling";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Moedling";
        timeModel: "discrete";
        timeZoneList: [
            ListElement{zone: " ";
                timeList: [
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5},
                    ListElement{time: 120; costs: 2},
                    ListElement{time: 150; costs: 2.5},
                    ListElement{time: 180; costs: 3.0}
                ]
            }
        ]
    }

    ListElement {
        name: "Perchtoldsdorf";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Perchtoldsdorf";
        timeModel: "discrete";
        timeZoneList: [
            ListElement{zone: " ";
                timeList: [
                    ListElement{time: 15; costs: 0},
                    ListElement{time: 30; costs: 0.5},
                    ListElement{time: 60; costs: 1},
                    ListElement{time: 90; costs: 1.5},
                    ListElement{time: 120; costs: 2},
                    ListElement{time: 150; costs: 2.5},
                    ListElement{time: 180; costs: 3.0}
                ]
            }
        ]
    }
    ListElement {
        name: "Gleisdorf";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Gleisdorf";
        timeModel: "floating";
        timeZoneList: [
            ListElement{zone: " ";
                timeList: [
                    ListElement{time: 30; costs: 0},
                    ListElement{time: 180; costs: 2.5},
                    ListElement{time: 10; costs: 2.5}
                ]
            }
        ]
    }

}
