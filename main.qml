import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

Window {
    visible: true
    width: 480
    height: 480

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#33b5e5"
        radius: 20
    }

    Grid {
        id: table
        columns: 4
        rows: columns
        anchors.centerIn: parent
        property int numberOfMine

        Repeater {
            model: table.rows *  table.columns
            Button {
                width: 25
                height: 25
                onClicked: {
                    if (text == "") {
                        if (modelData == table.numberOfMine) {
                          text = "X" // 踩到地雷
                        } else if (modelData == (table.numberOfMine - 1) && (table.numberOfMine % table.columns != 0)) {
                          text = "1" // 這是地雷左邊
                        } else if (modelData == (table.numberOfMine + 1) && (table.numberOfMine % table.columns != (table.columns - 1))) {
                          text = "1" // 這是地雷右邊
                        } else if (modelData == (table.numberOfMine - table.columns) && (Math.floor(table.numberOfMine / table.columns) != 0)) {
                          text = "1" // 這是地雷上面
                        } else if (modelData == (table.numberOfMine + table.columns) && (Math.ceil(table.numberOfMine / table.columns) != table.columns)) {
                          text = "1" // 這是地雷下面
                        } else {
                          text = " " // 沒有地雷
                          opacity = 0.25
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        table.numberOfMine = Math.round(Math.random() * Math.pow(table.columns, 2))
    }
}
