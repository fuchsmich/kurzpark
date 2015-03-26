import QtQuick 2.0
import QtQuick.LocalStorage 2.0

QtObject {
    property ListModel plates: ListModel {}
    property string dbName: "JollaDockingDB"
    property string dbDesc: "JollaDockingDB"

    function load() {
        var db = LocalStorage.openDatabaseSync(dbName, "1.0", dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS NumberPlates(number TEXT, desc TEXT)');
                        var res = tx.executeSql('SELECT * FROM NumberPlates')
                        if (res.rows.length > 0) {
                            for(var i = 0; i < res.rows.length; i++) {
                                plates.append({"number": res.rows.item(i).number, "desc":res.rows.item(i).desc})
                            }}
                        else {
                            plates.append({"number": "MD287IM", "desc":"meins"})
                        }
                    }
                    )
    }

    function save() {
        var db = LocalStorage.openDatabaseSync(dbName, "1.0", dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        for(var i=0; i < plates.count; i++) {
                            tx.executeSql('INSERT INTO NumberPlates VALUES(?, ?)', [ plates.get(i).number, plates.get(i).desc])
                        }
                    }
                    )
    }

    function clear() {
        var db = LocalStorage.openDatabaseSync(dbName, "1.0", dbDesc, 1000000);
        db.transaction(
                    function(tx) {
                        tx.executeSql('DROP TABLE NumberPlates');
                        tx.executeSql('CREATE TABLE IF NOT EXISTS NumberPlates(number TEXT, desc TEXT)')
                        plates.clear()
                    }
                    )

    }
}
