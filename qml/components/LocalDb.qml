import QtQuick 2.0
import QtQuick.LocalStorage 2.0

QtObject {
    property string dbName: "JollaDockingDB"
    property string dbDesc: "JollaDockingDB"

    function loadSettings(plateList) {
        var db = LocalStorage.openDatabaseSync(dbName, "1.0", dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS NumberPlates(number TEXT, desc TEXT)');
                        var res = tx.executeSql('SELECT * FROM NumberPlates')
                        if (res.rows.length > 0) {
                            for(var i = 0; i < res.rows.length; i++) {
                                plateList.append({"number": res.rows.item(i).number, "desc":res.rows.item(i).desc})
                            }}
                        else {
                            plateList.append({"number": "MD287IM", "desc":"meins"})
                            plateList.append({"number": "ASDASD", "desc":"deins"})
                        }
                    }
                    )
    }

    function saveSettings(plateList) {
        var db = LocalStorage.openDatabaseSync(dbName, "1.0", dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        for(var i=0; i < plateList.count; i++) {
                            tx.executeSql('INSERT INTO NumberPlates VALUES(?, ?)', [ plateList.get(i).number, plateList.get(i).desc]);
                        }
                    }
                    )
    }
}
