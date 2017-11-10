import QtQuick 2.0
//import QtQuick.LocalStorage 2.0

ListModel {
    property int currentIndex: 0
    property string currentPlate: get(currentIndex).number


    Component.onCompleted: {
        var plates = config.plates
        for (var p in plates) {
//            console.log(plates[p])
            append(plates[p])
        }
    }
}
