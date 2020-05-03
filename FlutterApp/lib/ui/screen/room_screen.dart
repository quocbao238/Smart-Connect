import 'package:bsmart_connect/models/realtimefirebase.dart';
import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/customUI.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:xlive_switch/xlive_switch.dart';

class RoomData extends StatefulWidget {
  final String name;
  RoomData({this.name});
  @override
  _RoomDataState createState() => _RoomDataState();
}

class _RoomDataState extends State<RoomData> {
  bool _value = true;

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Scaffold(
      backgroundColor: Color.fromRGBO(6, 41, 74, 1),
      body: Stack(
        children: <Widget>[buildBackground(), buildPageView()],
      ),
    );
  }

  Widget buildPageView() {
    return Positioned(
      top: ScreenSize.height * 0.3,
      left: 0,
      right: 0,
      child: Container(
        height: ScreenSize.height * 0.7,
        width: ScreenSize.width,
        child: StreamBuilder(
            stream: RealTimeDB.devices.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data.snapshot.value != null) {
                Map data = snapshot.data.snapshot.value;
                List item = new List();
                item.add(data['Device1']);
                item.add(data['Device2']);
                item.add(data['Device3']);
                item.add(data['Device4']);
                return Container(
                    height: ScreenSize.height * 0.65,
                    margin: EdgeInsets.symmetric(
                        horizontal: ScreenSize.marginHorizontal * 1.5),
                    child: Column(
                      children: <Widget>[
                        buildRoomButton(),
                        BoxMargin(isVertical: true, multi: 4.0),
                        buildTempAndHumi(data),
                        buildDevices(data,item)
                      ],
                    ));
              } else
                return Text("No data");
            }),
      ),
    );
  }

  Widget buildTempAndHumi(Map<dynamic, dynamic> data) {
    return Container(
      height: ScreenSize.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          builTempHumi(data['Temp'].toDouble(), true),
          builTempHumi(data['Humi'].toDouble(), false),
        ],
      ),
      // color: Colors.red,
    );
  }

  Widget builTempHumi(double data, bool isTemp) {
    return Container(
      width: ScreenSize.width * 0.4,
      height: ScreenSize.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 2,
          color: Color.fromRGBO(39, 78, 145, 1),
        ),
      ),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            isTemp ? Icons.ac_unit : Icons.cloud_download,
            color: Color.fromRGBO(0, 233, 193, 1),
          ),
          BoxMargin(
            isVertical: false,
          ),
          Text(
            isTemp ? "$data °C" : "$data %",
            style: TxtStyle.deviceNameWhite,
          )
        ],
      ),
    );
  }

  Widget buildDevices(Map<dynamic, dynamic> data, List item) {
    return Container(
      height: ScreenSize.height * 0.35,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        primary: false,
        crossAxisCount: 2,
        mainAxisSpacing: ScreenSize.marginVertical * 3,
        crossAxisSpacing: ScreenSize.marginHorizontal * 1.5,
        // shrinkWrap: true,
        childAspectRatio: 1.6,
        children: List.generate(item.length, (index) {
          return GestureDetector(
            onTap: () {
              // Toast.show("Device $index", homeGlobalKey.currentContext);
            },
            child: Container(
              height: ScreenSize.height * 0.05,
              padding: EdgeInsets.only(
                  top: 8.0, bottom: 8.0, right: 12.0, left: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Color.fromRGBO(39, 78, 145, 1),
                // color: Color.fromRGBO(7, 57, 83, 1),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.ac_unit,
                        size: 30.0 * ScreenSize.szText,
                        color: Color.fromRGBO(0, 233, 193, 1),
                        // color: Color.fromRGBO(72, 143, 207, 1),
                      ),
                      BoxMargin(isVertical: false),
                      Text(
                        "${convertIntdeviceName(index)}",
                        style: TxtStyle.deviceNameWhite,
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: ScreenSize.width * 0.08,
                        height: ScreenSize.width * 0.08,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(16, 50, 93, 1)),
                        child: Center(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 14 * ScreenSize.szText,
                          ),
                        ),
                      ),
                      Spacer(),
                      XlivSwitch(
                        value: item[index] == 0 ? false : true,
                        onChanged: (value) {
                          setState(() {
                            setDBData(databaseReference:RealTimeDB.devices,
                            key: index == 0 ? "Device1" : index == 1 ? "Device2" : index == 2 ? "Device3" : index == 3 ? "Device4" : "Device",
                            data: item[index] == 0 ? 1 : 0);
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildRoomButton() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TypewriterText(
                text: "Living Room",
                textStyle: TxtStyle.deviceNameWhite,
              ),
              BoxMargin(isVertical: true),
              TypewriterText(
                text: "4 devices",
                textStyle: TxtStyle.deviceContent,
              ),
            ],
          ),
          Spacer(),
          XlivSwitch(
            value: _value,
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildBackground() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: ScreenSize.height * 0.35,
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromRGBO(6, 41, 74, 1), Colors.transparent],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: Image.asset(
            ImageApp.livingRoom,
            // height: 400,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
