import QtQuick 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0
import QtQuick.Window 6.0

Window {
    visible: true
    width: 850
    height: 550
    title: "Lottery Game"
    property int playerMoney: 1000
    property var betOptions: ["0", "10", "20", "30", "50", "100"]

    property var imagePaths: {
        "BAU": "qrc:/images/BAU.PNG",
        "CUA": "qrc:/images/CUA.PNG",
        "TOM": "qrc:/images/TOM.PNG",
        "CA": "qrc:/images/CA.PNG"
    }

    property var betOptionsNames: ["BAU", "CUA", "TOM", "CA"]
    property var betOptionsValues: [0, 0, 0, 0]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20

        Text {
            text: "Lottery Game"
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            text: "Your money: $" + playerMoney
            font.pixelSize: 20
            color: "green"
            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout {
            spacing: 10

            Repeater {
                model: betOptionsNames.length
                Rectangle {
                    width: 200
                    height: 200
                    Layout.alignment: Qt.AlignHCenter
                    Image {
                        source: imagePaths[betOptionsNames[index]]
                        width: 200
                        height: 200
                        fillMode: Image.PreserveAspectFit
                    }

                    ComboBox {
                        id: comboBox
                        width: parent.width
                        model: betOptions
                        Layout.alignment: Qt.AlignHCenter
                        onCurrentTextChanged: {
                            handleBetChange(betOptionsNames[index], parseInt(currentText), index)
                        }
                    }
                }
            }
        }

        Button {
            text: "Start"
            width: 150
            Layout.alignment: Qt.AlignHCenter
            onClicked: runLottery()
        }

        Text {
            id: loterryResult
            text: ""
            font.pixelSize: 20
            color: "blue"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: moneyGot
            text: ""
            font.pixelSize: 20
            color: "red"
            Layout.alignment: Qt.AlignHCenter
        }

        Text {
            id: finalMoney
            text: ""
            font.pixelSize: 20
            color: "red"
            Layout.alignment: Qt.AlignHCenter
        }
    }

    function handleBetChange(name, bet, index) {
        if (bet === 0) {
            log("You did not place a bet on " + name);
            return;
        }
        if (playerMoney <= 0 || playerMoney < bet) {
            betOptionsValues[index] = 0;  // Reset to 0 if not enough money
            log("Not enough money to bet on " + name);
            return;
        }
        betOptionsValues[index] = bet;  // Set the current bet
        playerMoney -= bet;  // Deduct from total money
        logBetStatus(name, bet);
    }

    function logBetStatus(name, bet) {
        log("--> You bet $" + bet + " on " + name + " successfully!");
        log("--> Money left: $" + playerMoney);
    }

    function caculate_by_lottery_result(result_index, result_name) {
        if(betOptionsValues[result_index] !== 0) {
            log("You bet on " + result_name + " " + betOptionsValues[result_index] +"$ ")
            log("You win " + betOptionsValues[result_index] + "$")
            playerMoney += (betOptionsValues[result_index] * 2)
            moneyGot.text = "You won " + betOptionsValues[result_index] + "$"
            finalMoney.text = "Your money is "+ playerMoney
        }else{
            moneyGot.text = "You are lose"
            finalMoney.text = "Your money is "+ playerMoney
        }
    }

    function runLottery() {
        var resultIndex = getRandomOption();
        var resultName = betOptionsNames[resultIndex];
        display_lottery_result(resultName)

        caculate_by_lottery_result(resultIndex, resultName)

        log("FINAL MONEY: " + playerMoney);
    }

    function display_lottery_result(r) {
        loterryResult.text = r
        log("======================================");
        log("==== LOTERY RESULT: " + r);
        log("======================================");
    }

    function log(content) {
        console.log("---> " + content);
    }

    function getRandomOption() {
        return Math.floor(Math.random() * betOptionsNames.length);
    }
}
