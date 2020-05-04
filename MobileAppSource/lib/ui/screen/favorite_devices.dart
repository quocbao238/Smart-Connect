import 'package:bsmart_connect/models/realtimefirebase.dart';
import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/animation.dart';
import 'package:bsmart_connect/ui/widget/customUI.dart';
import 'package:bsmart_connect/ui/widget/iconcustome.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Devices extends StatefulWidget {
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  GlobalKey roomglobalKey = new GlobalKey();

  Future<bool> _onWillPop() async {
    Navigator.pop(roomglobalKey.currentContext);
    return false;
  }

  bool isShowTime = false;
  double heightContainerDevice = ScreenSize.height * 0.1;

  Future<void> handelDevices({String key, var data}) async {
    setDBData(databaseReference: RealTimeDB.devices, key: key, data: data);
  }

  final List<bool> boolList = [false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here
            },
            child: Icon(Icons.add, color: Color.fromRGBO(212, 230, 248, 1)),
            backgroundColor: Color.fromRGBO(84, 159, 229, 1),
          ),
          key: roomglobalKey,
          backgroundColor: Color.fromRGBO(6, 41, 74, 1),
          body: buildPageView()),
    );
  }

  Widget buildPageView() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buidAppBar(),
          BoxMargin(isVertical: true, multi: 2.0),
          Expanded(child: FadeIn(delay: 1.5, child: buildListView())),
          // Expanded(child: buildListView()),
          // buildListView()
        ],
      ),
    );
  }

  Widget buildListView() {
    return Container(
      // color: Colors.red,
      child:
       FirebaseAnimatedList(
          query: RealTimeDB.devices,
          sort: (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return SizeTransition(
              sizeFactor: animation,
              child: deviceName(snapshot.key) != ""
                  ? buildDeviceInfo(index, snapshot)
                  : SizedBox(),
            );
          }),
    );
  }

  Widget buildDeviceInfo(int index, DataSnapshot snapshot) {
    print(snapshot.toString());
    return GestureDetector(
      onTap: () {
        handelDevices(
            key: snapshot.key, data: (snapshot.value['value'] == 0) ? 1 : 0);
        setTime(
            databaseReference: RealTimeDB.devices,
            count: snapshot.value['count'].toInt(),
            key: snapshot.key,
            data: (snapshot.value['value'] == 0) ? "ON" : "OFF");
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: ScreenSize.marginHorizontal,
            ),
            margin: EdgeInsets.only(
              left: ScreenSize.marginHorizontal,
              right: ScreenSize.marginHorizontal,
              bottom: ScreenSize.marginVertical * 2,
              top: ScreenSize.marginVertical,
            ),
            width: ScreenSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: (snapshot.value['value'] == 1)
                  ? Color.fromRGBO(39, 78, 145, 1)
                  : Color.fromRGBO(7, 57, 83, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconCustom(
                        color: (snapshot.value['value'] == 1)
                            ? Color.fromRGBO(0, 233, 193, 1)
                            : Color.fromRGBO(72, 143, 207, 1),
                        size: 40.0 * ScreenSize.szText,
                        urlIcon: convertNameIcon(snapshot.key)),
                    BoxMargin(isVertical: false),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          deviceName(snapshot.key),
                          style: TxtStyle.deviceNameWhite,
                        ),
                        BoxMargin(isVertical: true),
                        Text(
                          "Kitchen",
                          style: TxtStyle.deviceContent,
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      height: ScreenSize.height * 0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: (snapshot.value['value'] == 0)
                            ? Color.fromRGBO(39, 78, 145, 1)
                            : Color.fromRGBO(7, 57, 83, 1),
                      ),
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSize.marginHorizontal),
                      child: Center(
                        child: Text(
                          snapshot.value['lasttime'].toString().substring(7,16),
                          style: TxtStyle.deviceContent,
                        ),
                      ),
                    ),
                    BoxMargin(isVertical: false, multi: 1.0),
                    GestureDetector(
                      onTap: () {
                        if (this.mounted) {
                          setState(() {
                            setBoolList(snapshot.key);
                          });
                        }
                      },
                      child: Container(
                        width: ScreenSize.width * 0.15,
                        height: ScreenSize.height * 0.15,
                        child: Center(
                          child: Icon(
                              !convertIndextoBoolList(snapshot.key)
                                  ? Icons.keyboard_arrow_right
                                  : Icons.keyboard_arrow_down,
                              size: 40.0 * ScreenSize.szText,
                              color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
                convertIndextoBoolList(snapshot.key)
                    ? Container(
                        width: ScreenSize.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("History", style: TxtStyle.deviceNameWhite),
                            BoxMargin(isVertical: true),
                            Text("Time 1: ${snapshot.value['time1']}",
                                style: TxtStyle.deviceContent),
                            BoxMargin(isVertical: true),
                            Text("Time 2: ${snapshot.value['time2']}",
                                style: TxtStyle.deviceContent),
                            BoxMargin(isVertical: true),
                            Text("Time 3: ${snapshot.value['time3']}",
                                style: TxtStyle.deviceContent),
                            BoxMargin(isVertical: true),
                            Text("Time 4: ${snapshot.value['time4']}",
                                style: TxtStyle.deviceContent),
                            BoxMargin(
                              isVertical: true,
                              multi: 2.0,
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buidAppBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal),
      height: ScreenSize.height * 0.1,
      width: ScreenSize.width,
      // color: Colors.red,
      child: Row(
        children: <Widget>[
          Icon(Icons.menu, color: Colors.white),
          BoxMargin(isVertical: false, multi: 2.0),
          TypewriterText(
            text: "Favorite Devices",
            textStyle: TxtStyle.deviceNameWhite,
          ),
          Spacer(),
          Icon(Icons.cloud_upload, color: Colors.white),
          BoxMargin(isVertical: false, multi: 1.0),
          Icon(Icons.insert_chart, color: Colors.white),
        ],
      ),
    );
  }

  bool convertIndextoBoolList(String name) {
    return name == "Device1"
        ? boolList[0]
        : name == "Device2"
            ? boolList[1]
            : name == "Device3"
                ? boolList[2]
                : name == "Device4" ? boolList[3] : false;
  }

  void setBoolList(String name) {
    name == "Device1"
        ? boolList[0] = !boolList[0]
        : name == "Device2"
            ? boolList[1] = !boolList[1]
            : name == "Device3"
                ? boolList[2] = !boolList[2]
                : name == "Device4"
                    ? boolList[3] = !boolList[3]
                    : boolList[0] = boolList[0];
  }

  void isFavorite(String name) {
    name == "Device1"
        ? boolList[0] = !boolList[0]
        : name == "Device2"
            ? boolList[1] = !boolList[1]
            : name == "Device3"
                ? boolList[2] = !boolList[2]
                : name == "Device4"
                    ? boolList[3] = !boolList[3]
                    : boolList[0] = boolList[0];
  }
}
