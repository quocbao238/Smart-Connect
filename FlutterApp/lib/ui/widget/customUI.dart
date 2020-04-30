import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/screen/home_screen.dart';
import 'package:bsmart_connect/ui/screen/room_device.dart';
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

gotoDevices(BuildContext context, var object) async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Devices(name: object)),
  );
}
