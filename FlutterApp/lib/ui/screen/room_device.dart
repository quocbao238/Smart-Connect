import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/animation.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:flutter/material.dart';

class Devices extends StatefulWidget {
  final String name;
  Devices({this.name});
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          key: roomglobalKey,
          backgroundColor: Color.fromRGBO(6, 41, 74, 1),
          body: buildPageView()),
    );
  }

  Widget buildPageView() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return buildDeviceInfo(index);
      },
    );
  }

  Widget buildDeviceInfo(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          // alignment: AlignmentDirectional.topCenter,
          padding: EdgeInsets.only(
            // bottom: ScreenSize.marginVertical,
            left: ScreenSize.marginHorizontal,
            // top: ScreenSize.marginVertical
          ),
          margin: EdgeInsets.only(
            bottom: ScreenSize.marginVertical * 2,
            // left: ScreenSize.marginHorizontal,
            // right: ScreenSize.marginHorizontal,
            top: ScreenSize.marginVertical,
          ),
          // height: heightContainerDevice,
          width: ScreenSize.width * 0.9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color.fromRGBO(5, 86, 128, 1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.ac_unit,
                    size: 40.0 * ScreenSize.szText,
                    color: Color.fromRGBO(0, 233, 193, 1),
                  ),
                  BoxMargin(isVertical: false),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Light ${index + 1}",
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
                      color: Color.fromRGBO(39, 77, 144, 1),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSize.marginHorizontal),
                    child: Center(
                      child: Text(
                        "ON 16:10 PM",
                        style: TxtStyle.deviceContent,
                      ),
                    ),
                  ),
                  BoxMargin(isVertical: false, multi: 2.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isShowTime = !isShowTime;
                      });
                    },
                    child: Container(
                      width: ScreenSize.width * 0.15,
                      height: ScreenSize.height * 0.15,
                      child: Center(
                        child: Icon(
                            !isShowTime
                                ? Icons.keyboard_arrow_right
                                : Icons.keyboard_arrow_down,
                            size: 40.0 * ScreenSize.szText,
                            color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
              isShowTime
                  ? Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              right: ScreenSize.marginHorizontal),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Time: $index:46 - 15/4/2020",
                                  style: TxtStyle.deviceContent),
                              Text("Status:  ON",
                                  style: TxtStyle.deviceContent),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: ScreenSize.marginHorizontal),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Time: $index:46 - 15/4/2020",
                                  style: TxtStyle.deviceContent),
                              Text("Status:  ON",
                                  style: TxtStyle.deviceContent),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: ScreenSize.marginHorizontal),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Time: $index:46 - 15/4/2020",
                                  style: TxtStyle.deviceContent),
                              Text("Status:  ON",
                                  style: TxtStyle.deviceContent),
                            ],
                          ),
                        ),
                        BoxMargin(
                          isVertical: true,
                          multi: 2.0,
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ],
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
            text: "${widget.name} Devices",
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
}
