import QtQuick 2.0

Rectangle {
    width: 100
    height: 62
            //   DBusInterface {
            //        // send SMS directly
            ////        dbus-send --system --print-reply --dest=org.ofono /ril_0
            ////        org.ofono.MessageManager.SendMessage
            ////        string:"+358500000000" string:"test sms"
            //        id: dbusInterface1
            ////        bus: system
            //        service: "org.ofono"
            //        iface: "org.ofono.MessageManager.SendMessage"
            //        path: "/org/ofono/MessageManager/ril_0"
            //    }

            //    DBusInterface {
            //// Allowed in Harbour
            ////        dbus-send --type=method_call --dest=org.nemomobile.qmlmessages /
            ////        org.nemomobile.qmlmessages.startSMS array:string:"+358123456" string:"Hello world"
            ////        method call sender=:1.41 -> dest=org.nemomobile.qmlmessages serial=2
            ////        path=/; interface=org.nemomobile.qmlmessages; member=startSMS
            ////           array [
            ////              string "+358123456"
            ////           ]
            ////           string "Hello world"
            //        id: smsIf

            //        service: "org.nemomobile.qmlmessages"
            //        iface: "org.nemomobile.qmlmessages"
            //        path: "/"
            //    }

    //    ListModel {
    //        id: platesModel
    //        ListElement { number: "W12345X"; comment:"Meins" }
    //        ListElement { number: "MD234AS"; comment:"Deins" }
    //        ListElement { number: "S2345X"; commment:"Unsers" }
    //    }

//    Component.onCompleted: {
//        platesModel.append({ "number": qsTr("Neu"), "comment":""})
//    }

//    Component.onDestruction: {
//        platesModel.remove(platesModel.count-1, 1)
//    }





}
