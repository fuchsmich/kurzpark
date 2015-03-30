import QtQuick 2.0
import QtQuick.LocalStorage 2.0

ListModel {
    property string dbName: "JollaDockingDB"
    property string dbDesc: "JollaDockingDB"
    property string dbVersion: "1.0"
    property int currentIndex: 0

    function load() {
        clear()
        var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS NumberPlates(number TEXT, desc TEXT, current INTEGER)');
                        var res = tx.executeSql('SELECT * FROM NumberPlates')
                        if (res.rows.length > 0) {
                            for(var i = 0; i < res.rows.length; i++) {
                                console.log("Loaded: ", res.rows.item(i).number, res.rows.item(i).desc, res.rows.item(i).current)
                                append({"number": res.rows.item(i).number, "desc":res.rows.item(i).desc})
                                if (res.rows.item(i).current) currentIndex = i
                            }}
                        else {
                            append({"number": "MD287IM", "desc":"meins"})
                        }
                    }
                    )
    }

    function save() {
//        clearDB()
        var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        tx.executeSql('DELETE FROM NumberPlates');
                        for(var i=0; i < count; i++) {
                            tx.executeSql('INSERT INTO NumberPlates VALUES(?, ?, ?)', [ get(i).number, get(i).desc, (i===currentIndex)])
                            console.log("Added to table: ", get(i).number, get(i).desc, (i===currentIndex))
                        }
                    }
                    )
    }

    function clearDB() {
        var db = LocalStorage.openDatabaseSync(dbName, dbVersion, dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        tx.executeSql('DROP TABLE NumberPlates');
                        tx.executeSql('CREATE TABLE IF NOT EXISTS NumberPlates(number TEXT, desc TEXT, current INTEGER)')
                        clear()
                    }
                    )

    }
    Component.onCompleted: {
//        clearDB()
        load()}
//    onDataChanged: save()
//    onRowsInserted: save()
//    onDestroyed: save()
}
