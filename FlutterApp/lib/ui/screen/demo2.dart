import 'package:bsmart_connect/models/realtimefirebase.dart';
import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/customUI.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class FirebaseDemo2 extends StatefulWidget {
  @override
  _FirebaseDemo2State createState() => _FirebaseDemo2State();
}

class _FirebaseDemo2State extends State<FirebaseDemo2> {
  bool _anchorToBottom = false;
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    getScreenSize(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: ScreenSize.marginHorizontal),
              height: ScreenSize.height * 0.3,
              width: ScreenSize.width,
              child: FirebaseAnimatedList(
                // key: ValueKey<bool>(),
                query: RealTimeDB.devices,
                // query: _messagesRef,
                reverse: _anchorToBottom,
                sort: _anchorToBottom
                    ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                    : null,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Text("$index: ${snapshot.key.toString()} ${snapshot.value.toString()}"),
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenSize.marginHorizontal),
              height: ScreenSize.height * 0.3,
              width: ScreenSize.width,
              child: FirebaseAnimatedList(
                // key: ValueKey<bool>(_anchorToBottom),
                query: RealTimeDB.power,
                sort:  (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Text("$index: ${snapshot.key.toString()} ${snapshot.value.toString()}"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
