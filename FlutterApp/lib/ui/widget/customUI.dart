import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/screen/favorite_devices.dart';
import 'package:bsmart_connect/ui/screen/home_screen.dart';
import 'package:bsmart_connect/ui/screen/power_screen.dart';
import 'package:bsmart_connect/ui/screen/room_screen.dart';
import 'package:flutter/material.dart';

void getScreenSize(BuildContext context) {
  ScreenSize.width = MediaQuery.of(context).size.width;
  ScreenSize.height = MediaQuery.of(context).size.height;
  ScreenSize.szText = MediaQuery.of(context).textScaleFactor;
  ScreenSize.marginHorizontal = ScreenSize.width * 0.03;
  ScreenSize.marginVertical = ScreenSize.height * 0.01;
  ScreenSize.dateTimeNow = new DateTime.now();
}

goToHome(BuildContext context) async {
  await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
}

gotoDevices(BuildContext context) async {
  await Navigator.push(
      context, MaterialPageRoute(builder: (context) => Devices()));
}

gotoRoom(BuildContext context, var object) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => RoomData(
                name: object,
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

String convertIntdeviceName(int index) {
  return index == 0
      ? "Celing Light"
      : index == 1
          ? "Air Condition"
          : index == 2
              ? "Ceiling Fans"
              : index == 3 ? "RGB Light" : 0;
}
