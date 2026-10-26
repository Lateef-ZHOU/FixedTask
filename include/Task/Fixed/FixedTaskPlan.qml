pragma ComponentBehavior: Bound
import QtQuick
import Lidar.UI
import QtQuick.Layouts

Section {
    id: section
    required property var task
    property list<real> azimuths: [0]
    property real elevation: 60

    function setAzimuth(index: int, value: real): void {
        if (azimuths[index] === value) return
        azimuths[index] = value
        task.logMessage(qsTr("世界方位角 %1：%2°").arg(index + 1).arg(value.toFixed(2)))
    }
    function setElevation(value: real): void {
        if (elevation === value) return
        elevation = value
        task.logMessage(qsTr("世界高度角：%1°").arg(value.toFixed(2)))
    }

    title: qsTr("波束计划")
    component PlanRow: FieldRow { labelWidth: 160 }
    PlanRow {
        label: qsTr("世界高度角（°）")
        RealField {
            Layout.fillWidth: true
            minimum: -180; maximum: 180
            value: section.elevation
            onCommitted: function (v) { section.setElevation(v) }
        }
    }
    PlanRow {
        label: qsTr("世界方位角（°）")
        RealField {
            Layout.fillWidth: true
            minimum: 0; maximum: 360
            value: section.azimuths[0]
            onCommitted: function (v) { section.setAzimuth(0, v) }
        }
    }
}
