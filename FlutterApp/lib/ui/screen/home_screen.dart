import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/customUI.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey homeGlobalKey = new GlobalKey();

  Future<bool> _onWillPop() async {
    Toast.show("On will Pop", homeGlobalKey.currentContext);
    return false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return buildHomePage();
  }

  Widget buildHomePage() {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: homeGlobalKey,
        body: Stack(
          children: <Widget>[
            buildImageBackground(),
            buildPage(),
            buildPowerEnergy()
          ],
        ),
      ),
    );
  }

  Widget buildPowerEnergy() {
    return Positioned(
      top: ScreenSize.marginVertical * 4,
      right: ScreenSize.marginHorizontal * 0.5,
      child: SafeArea(
        child: PlayAnimation<double>(
            duration: 1000.milliseconds,
            delay: 2000.milliseconds,
            tween: (0.0).tweenTo(ScreenSize.height * 0.08),
            builder: (context, child, height) {
              return GestureDetector(
                onTap: () {
                  Toast.show("Power Energy", homeGlobalKey.currentContext);
                  gotoPowerEnergy(homeGlobalKey.currentContext);
                },
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: Colors.yellowAccent)),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          ImageApp.iconPower,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Text(
                          "Power Energy",
                          style: TxtStyle.normalContentWhite,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildPage() {
    return Positioned.fill(
      child: Padding(
        padding: EdgeInsets.only(
            left: ScreenSize.marginHorizontal, top: ScreenSize.marginVertical),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildNameTime(),
            BoxMargin(isVertical: true, multi: 3.0),
            buildFavorite(),
            BoxMargin(isVertical: true),
            buildFavoriteList(),
            BoxMargin(isVertical: true, multi: 3.0),
            buildRooms(),
            BoxMargin(isVertical: true),
            buildListRoom(),
          ],
        ),
      ),
    );
  }

  Widget buildImageBackground() {
    return Positioned.fill(
        child: Image.asset(
      ScreenSize.dateTimeNow.hour >= 18
          ? ImageApp.homeEvening
          : ImageApp.homeNight,
      fit: BoxFit.fill,
    ));
  }

  Widget buildNameTime() {
    return PlayAnimation<double>(
      duration: 1200.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return Container(
          margin: EdgeInsets.only(
            top: ScreenSize.height * 0.28,
          ),
          width: width,
          child: width > ScreenSize.width * 0.5
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: TypewriterText(
                        text: getMomentDay(),
                        textStyle: TxtStyle.headerStyle18White70,
                      ),
                    ),
                    BoxMargin(
                      isVertical: true,
                    ),
                    Container(
                      child: TypewriterText(
                        text: "Quốc Bảo",
                        textStyle: TxtStyle.headerStyle30White,
                      ),
                    ),
                  ],
                )
              : Container(),
        );
      },
    );
  }

  Widget buildFavorite() {
    return PlayAnimation<double>(
      duration: 1200.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return Container(
          width: width,
          child: width > ScreenSize.width * 0.5
              ? Container(
                  child: TypewriterText(
                    text: "Favourite devices",
                    textStyle: TxtStyle.normalContentGrey,
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget buildFavoriteList() {
    return PlayAnimation<double>(
      duration: 2000.milliseconds,
      delay: 200.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return buildContainerDevices(width);
      },
    );
  }

  Widget buildRooms() {
    return PlayAnimation<double>(
      duration: 1200.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return Container(
          width: width,
          child: width > ScreenSize.width * 0.5
              ? Container(
                  child: TypewriterText(
                    text: "Rooms",
                    textStyle: TxtStyle.normalContentGrey,
                  ),
                )
              : Container(),
        );
      },
    );
  }

  Widget buildListRoom() {
    return PlayAnimation<double>(
      duration: 2000.milliseconds,
      delay: 200.milliseconds,
      tween: (0.0).tweenTo(ScreenSize.width),
      builder: (context, child, width) {
        return buildContainerRoom(width);
      },
    );
  }

  Widget buildContainerRoom(double width) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: ScreenSize.marginVertical),
        height: ScreenSize.height * 0.2,
        width: width,
        child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Toast.show("Room $index", homeGlobalKey.currentContext);
                  gotoRoom(homeGlobalKey.currentContext, "Living Room");
                },
                child: Container(
                  margin: EdgeInsets.only(right: ScreenSize.marginHorizontal),
                  width: ScreenSize.width * 0.4,
                  height: ScreenSize.height * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: ScreenSize.height * 0.14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: AssetImage(ImageApp.livingRoom),
                                fit: BoxFit.cover)),
                      ),
                      BoxMargin(isVertical: true),
                      Container(
                        margin:
                            EdgeInsets.only(left: ScreenSize.marginHorizontal),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Living Room",
                              style: TxtStyle.deviceNameWhite,
                            ),
                            BoxMargin(isVertical: true),
                            Text(
                              "8 devices",
                              style: TxtStyle.deviceContent,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget buildContainerDevices(double width) {
    return GestureDetector(
      onLongPress: () {
        gotoDevices(homeGlobalKey.currentContext);
      },
      child: Container(
        width: width,
        height: ScreenSize.height * 0.22,
        child: width > ScreenSize.width * 0.1
            ? GridView.count(
                scrollDirection: Axis.horizontal,
                primary: false,
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.4,
                children: List.generate(4, (index) {
                  return GestureDetector(
                    onTap: () {
                      Toast.show("Device $index", homeGlobalKey.currentContext);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 12.0, left: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color.fromRGBO(39, 78, 145, 1),
                        // color: Color.fromRGBO(7, 57, 83, 1),
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.ac_unit,
                            size: 30.0 * ScreenSize.szText,
                            color: Color.fromRGBO(0, 233, 193, 1),
                            // color: Color.fromRGBO(72, 143, 207, 1),
                          ),
                          BoxMargin(isVertical: false),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Light",
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
                            width: 4,
                            color: Color.fromRGBO(15, 175, 176, 1),
                          )
                        ],
                      ),
                    ),
                  );
                }),
              )
            : Container(),
      ),
    );
  }

  bool isEnoughForbuildNameTime(double height) =>
      height > ScreenSize.height * 0.11;
}
