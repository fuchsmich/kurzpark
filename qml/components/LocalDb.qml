import QtQuick 2.0
import QtQuick.LocalStorage 2.0 as Sql

QtObject {
    property string dbName: "JollaDockingDB"
    property string dbDesc: "JollaDockingDB"

    ListModel {
         id: plateList
//         ListElement { number: "MD287IM"; desc:"Meins" }
     }

     ListModel {
         id: cityList
         ListElement {
             name: "Wien";
             phoneNumbers: [
                 ListElement{number: "+436646600990"},
                 ListElement{number: "+436646606000"}
             ]
             text: "Wien";
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
 //        ListElement { name: "Amstetten"; time: "1"  }
 //        ListElement { name: "Bregenz"; time: "1"   }
 //        ListElement { name: "Eisenstadt"; time: "1"   }
 //        ListElement { name: "Gleisdorf"; time: "1"   }
 //        ListElement { name: "Graz"; time: "1"   }
 //        ListElement { name: "Klagenfurt"; time: "1"   }
 //        ListElement { name: "Korneuburg"; time: "1"   }
 //        ListElement { name: "Linz"; time: "1" }
 //        ListElement { name: "Mödling"; time: "1" }
 //        ListElement { name: "Neusiedl am See"; time: "1" }
 //        ListElement { name: "Perchtoldsdorf"; time: "1" }
 //        ListElement { name: "Salzburg"; time: "1" }
 //        ListElement { name: "Schwechat"; time: "1" }
 //        ListElement { name: "Spittal a. d. Drau"; time: "1" }
 //        ListElement { name: "St. Pölten"; time: "1" }
 //        ListElement { name: "Stockerau"; time: "1" }
 //        ListElement { name: "Villach"; time: "1" }
 //        ListElement { name: "Villach"; time: "1" }
 //        ListElement { name: "Weiz"; time: "1" }
 //        ListElement { name: "Wels"; time: "1" }
 //        ListElement { name: "Wolfsberg"; time: "1" }
     }
    Component.onCompleted: {
        var db = Sql.openDatabaseSync(dbName, "1.0", dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS NumberPlates(number TEXT, desc TEXT)');
                        var res = tx.executeSql('SELECT * FROM NumberPlates')
                        for(var i = 0; i < res.rows.length; i++) {
                            plateList.append()
                        }
                    }
                    )
    }
}
