import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.2

Window {
    visible: true
    width: 480
    height: 480
    title: "開源踩地雷"

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#33b5e5"
        radius: 20
    }

    Row {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 8
        anchors.margins: 8
        Button {
            text: "容易"
            onClicked: {
                table.columns = 4
                recalculateMine()
            }
        }

        Button {
            text: "普通"
            onClicked: {
                table.columns = 8
                recalculateMine()
            }
        }

        Button {
            text: "困難"
            onClicked: {
                table.columns = 16
                recalculateMine()
            }
        }
    }

    Grid {
        id: table
        columns: 16
        rows: columns
        anchors.centerIn: parent
        property int numberOfMine

        Repeater {
            model: table.rows *  table.columns
            Button {
                width: 360 / table.columns
                height: 360 / table.columns
                onClicked: {
                    if (text == "") {
                        if (modelData == table.numberOfMine) {
                          text = "X" // 踩到地雷
                            animation.start()
                        }
                        else if (modelData == (table.numberOfMine - 1) && (table.numberOfMine % table.columns != 0)) {
                          text = "1" // 這是地雷左邊
                        }
                        else if (modelData == (table.numberOfMine + 1) && (table.numberOfMine % table.columns != (table.columns - 1))) {
                          text = "1" // 這是地雷右邊
                        }
                        else if (modelData == (table.numberOfMine - table.columns) && (Math.floor(table.numberOfMine / table.columns) != 0)) {
                          text = "1" // 這是地雷上面
                        }
                        else if (modelData == (table.numberOfMine + table.columns) && (Math.ceil(table.numberOfMine / table.columns) != table.columns)) {
                          text = "1" // 這是地雷下面
                        }
                        else {
                          text = " " // 沒有地雷
                          opacity = 0.25
                        }
                    }
                }

                Rectangle {
                    id: highlight
                    anchors.fill: parent
                    color: "red"
                    opacity: 0
                }

                NumberAnimation {
                    id: animation
                    target: highlight
                    property: "opacity"
                    from: 0
                    to: 0.8
                    duration: 1000
                    easing.type: Easing.OutBounce
                }
            }
        }
    }

    function recalculateMine() {
        // 因為尺寸變動了，所以重新計算地雷位置
        table.numberOfMine = Math.round(Math.random() * Math.pow(table.columns, 2))
    }

    Component.onCompleted: {
        recalculateMine()
    }
}
