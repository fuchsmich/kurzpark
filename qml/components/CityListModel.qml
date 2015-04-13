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
    property int currentTimeIndex: 0

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
        name: "Wien";
        phoneNumbers: [
            ListElement{number: "+436646600990"},
            ListElement{number: "+436646606000"}
        ]
        text: "Wien";
        timeModel: "discrete";
        timeList: [
            ListElement{time: 15; costs: 0},
            ListElement{time: 30; costs: 1},
            ListElement{time: 60; costs: 2},
            ListElement{time: 90; costs: 3},
            ListElement{time: 120; costs: 4},
            ListElement{time: 180; costs: 6}
        ]
    }
    ListElement {
        name: "Mödling";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Moedling";
        timeModel: "discrete";
        timeList: [
            ListElement{time: 30; costs: 0.5},
            ListElement{time: 60; costs: 1},
            ListElement{time: 90; costs: 1.5},
            ListElement{time: 120; costs: 2},
            ListElement{time: 150; costs: 2.5},
            ListElement{time: 180; costs: 3.0}
        ]
    }
    ListElement {
        name: "Perchtoldsdorf";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Perchtoldsdorf";
        timeModel: "discrete";
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
    ListElement {
        name: "Amstetten";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Amstetten";
        timeModel: "discrete";
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
    ListElement {
        name: "Gleisdorf";
        phoneNumbers:[
            ListElement{number: "+436646606000"}
        ]
        text: "Gleisdorf";
        timeModel: "floating";
        timeList: [
            ListElement{time: 30; costs: 0},
            ListElement{time: 180; costs: 2.5}
        ]
    }

}
