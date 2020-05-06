import 'package:bsmart_connect/models/realtimefirebase.dart';
import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/customUI.dart';
import 'package:bsmart_connect/ui/widget/iconcustome.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:flutter/material.dart';
import 'package:xlive_switch/xlive_switch.dart';

class RoomData extends StatefulWidget {
  final String name;
  final String imageUrl;
  RoomData({this.name, this.imageUrl});
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
      top: ScreenSize.height * 0.25,
      left: 0,
      right: 0,
      child: Container(
        height: ScreenSize.height * 0.75,
        width: ScreenSize.width,
        child: StreamBuilder(
            stream: RealTimeDB.devices.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData && !snapshot.hasError && snapshot.data.snapshot.value != null) {
                Map data = snapshot.data.snapshot.value;
                List<List> itemList = mapData(data);
                return Container(
                    height: ScreenSize.height * 0.7,
                    margin: EdgeInsets.symmetric(horizontal: ScreenSize.marginHorizontal * 1.5),
                    child: Column(
                      children: <Widget>[
                        buildRoomButton(),
                        BoxMargin(isVertical: true, multi: 4.0),
                        buildTempAndHumi(data),
                        BoxMargin(isVertical: true),
                        buildDevices(data, itemList)
                      ],
                    ));
              } else
                return LoadingWidget();
            }),
      ),
    );
  }

  List<List> mapData(Map data) {
    List<List> itemList = new List();
    List item = new List();
    for (int i = 1; i < 5; i++) {
      for (int k = 0; k < 1; k++) {
        item.add(data['Device$i']['value']);
        item.add(data['Device$i']['isFavorite']);
        item.add(data['Device$i']['time1']);
        item.add(data['Device$i']['time2']);
        item.add(data['Device$i']['time3']);
        item.add(data['Device$i']['time4']);
        item.add(data['Device$i']['count']);
      }
      itemList.add(item);
      item = [];
    }
    return itemList;
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
          IconCustom(
              color: Color.fromRGBO(0, 233, 193, 1),
              size: 30.0 * ScreenSize.szText,
              urlIcon: isTemp ? ImageApp.temperIcon : ImageApp.humididtyIcon),
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

  Widget buildDevices(Map<dynamic, dynamic> data, List<List> item) {
    return Container(
      height: ScreenSize.height * 0.50,
      // color: Colors.green,
      child: GridView.count(
        scrollDirection: Axis.vertical,
        primary: false,
        crossAxisCount: 2,
        mainAxisSpacing: ScreenSize.marginVertical * 2,
        crossAxisSpacing: ScreenSize.marginHorizontal * 1.5,
        // shrinkWrap: true,
        childAspectRatio: 1.5,
        children: List.generate(item.length, (index) {
          return Container(
            // height: ScreenSize.height * 0.1,
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 8.0),
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
                    IconCustom(
                        color: Color.fromRGBO(0, 233, 193, 1),
                        size: 30.0 * ScreenSize.szText,
                        urlIcon: convertIndexIcon(index)),
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
                    GestureDetector(
                      onTap: () {
                        if (this.mounted) {
                          setState(() {
                            setFavorite(
                                databaseReference: RealTimeDB.devices,
                                key: index == 0
                                    ? "Device1"
                                    : index == 1
                                        ? "Device2"
                                        : index == 2 ? "Device3" : index == 3 ? "Device4" : "Device",
                                data: item[index][1] == 0 ? 1 : 0);
                          });
                        }
                      },
                      child: Container(
                        width: ScreenSize.width * 0.08,
                        height: ScreenSize.width * 0.08,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Color.fromRGBO(16, 50, 93, 1)),
                        child: Center(
                          child: Icon(
                            item[index][1] == 0 ? Icons.favorite_border : Icons.favorite,
                            color: item[index][1] == 0 ? Colors.grey : Colors.red,
                            size: 14 * ScreenSize.szText,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    XlivSwitch(
                      value: item[index][0] == 0 ? false : true,
                      onChanged: (value) {
                        if (this.mounted) {
                          setState(
                            () {
                              setDBData(
                                  databaseReference: RealTimeDB.devices,
                                  key: index == 0
                                      ? "Device1"
                                      : index == 1
                                          ? "Device2"
                                          : index == 2 ? "Device3" : index == 3 ? "Device4" : "Device",
                                  data: item[index][0] == 0 ? 1 : 0);

                              setTime(
                                  databaseReference: RealTimeDB.devices,
                                  count: item[index][6].toInt(),
                                  key: index == 0
                                      ? "Device1"
                                      : index == 1
                                          ? "Device2"
                                          : index == 2 ? "Device3" : index == 3 ? "Device4" : "Device",
                                  data: (item[index][0] == 0) ? "ON" : "OFF");
                            },
                          );
                        }
                      },
                    ),
                  ],
                )
              ],
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
                text: widget.name,
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
              if (this.mounted) {
                setState(() {
                  setAllDevice(_value);
                  _value = value;
                });
              }
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
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
