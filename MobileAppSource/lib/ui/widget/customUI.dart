import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/screen/favorite_devices.dart';
import 'package:bsmart_connect/ui/screen/home_screen.dart';
import 'package:bsmart_connect/ui/screen/power_screen.dart';
import 'package:bsmart_connect/ui/screen/room_screen.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

void getScreenSize(BuildContext context) {
  ScreenSize.width = MediaQuery.of(context).size.width;
  ScreenSize.height = MediaQuery.of(context).size.height;
  ScreenSize.szText = MediaQuery.of(context).textScaleFactor;
  ScreenSize.marginHorizontal = ScreenSize.width * 0.03;
  ScreenSize.marginVertical = ScreenSize.height * 0.01;
  ScreenSize.dateTimeNow = new DateTime.now();
}

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LoadingFlipping.circle(
          borderColor: Colors.cyan,
          borderSize: 3.0,
          size: 30.0,
          backgroundColor: Colors.cyanAccent,
          duration: Duration(milliseconds: 100),
        ),
        BoxMargin(isVertical: false),
        LoadingFlipping.circle(
          borderColor: Colors.cyan,
          borderSize: 3.0,
          size: 30.0,
          backgroundColor: Colors.cyanAccent,
          duration: Duration(milliseconds: 100),
        ),
        BoxMargin(isVertical: false),
        LoadingFlipping.circle(
          borderColor: Colors.cyan,
          borderSize: 3.0,
          size: 30.0,
          backgroundColor: Colors.cyanAccent,
          duration: Duration(milliseconds: 100),
        ),
      ],
    );
  }
}

goToHome(BuildContext context) async {
  await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

gotoDevices(BuildContext context) async {
  await Navigator.push(
      context, MaterialPageRoute(builder: (context) => Devices()));
}

gotoRoom(BuildContext context, String name, String imageUrl) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RoomData(
                name: name,
                imageUrl: imageUrl,
              )));
}

gotoPowerEnergy(BuildContext context) async {
  await Navigator.push(
      context, MaterialPageRoute(builder: (context) => PowerEnergy()));
}

String deviceName(String name) {
  return name == "Device1"
      ? "Celing Light"
      : name == "Device2"
          ? "Air Condition"
          : name == "Device3"
              ? "Ceiling Fans"
              : name == "Device4" ? "RGB Light" : "";
}

String convertNameIcon(String name) {
  return name == "Device1"
      ? ImageApp.lampIcon
      : name == "Device2"
          ? ImageApp.airconditionIcon
          : name == "Device3"
              ? ImageApp.fanIcon
              : name == "Device4" ? ImageApp.rgbIcon : "";
}

String convertIntdeviceName(int index) {
  return index == 0
      ? "Celing Light"
      : index == 1
          ? "Air Condition"
          : index == 2 ? "Ceiling Fans" : index == 3 ? "RGB Light" : "";
}

String convertIndexIcon(int index) {
  return index == 0
      ? ImageApp.lampIcon
      : index == 1
          ? ImageApp.airconditionIcon
          : index == 2 ? ImageApp.fanIcon : index == 3 ? ImageApp.rgbIcon : "";
}

String converIndextoDevice(int index) {
  return index == 0
      ? "Device1"
      : index == 1
          ? "Device2"
          : index == 2 ? "Device3" : index == 3 ? "Device4" : "";
}

String convertUnitParam(String name) {
  return name == "Power"
      ? "W"
      : name == "Voltage"
          ? "V"
          : name == "Current"
              ? "A"
              : name == "Energy" ? "Wh" : name == "Frequecy" ? "Hz" : "";
}
