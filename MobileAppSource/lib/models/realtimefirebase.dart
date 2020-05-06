import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

Future<FirebaseApp> innitFirebase() async {
  final FirebaseApp setupDB = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS
        ? const FirebaseOptions(
            googleAppID: '1:275003158765:android:15843a90648a63194c1ce4',
            gcmSenderID: '275003158765',
            databaseURL: 'https://smart-connect-b2f56.firebaseio.com',
          )
        : const FirebaseOptions(
            googleAppID: '1:275003158765:android:15843a90648a63194c1ce4',
            apiKey: 'AIzaSyCLUa8CB05PTYtd0u7dn89jE2mRl6XqmIE',
            databaseURL: 'https://smart-connect-b2f56.firebaseio.com',
          ),
  );
  return setupDB;
}

class RealTimeDB {
  RealTimeDB._();
  static FirebaseApp setupDB;
  static FirebaseDatabase realtimeDB;
  static DatabaseReference devices;
  static DatabaseReference power;
  static DatabaseReference device1;
  static DatabaseReference device2;
  static DatabaseReference device3;
  static DatabaseReference device4;
  static DatabaseReference room;
  static DatabaseReference monthPower;
}

Future innitDB() async {
  RealTimeDB.setupDB = await innitFirebase();
  RealTimeDB.realtimeDB = FirebaseDatabase(app: RealTimeDB.setupDB);
  RealTimeDB.devices = RealTimeDB.realtimeDB.reference().child("Devices");
  RealTimeDB.power = RealTimeDB.realtimeDB.reference().child("Power");
  RealTimeDB.room = RealTimeDB.realtimeDB.reference().child("Room");
  RealTimeDB.monthPower = RealTimeDB.realtimeDB.reference().child("MonthPower");
}

Future<void> setDBData({DatabaseReference databaseReference, String key, var data}) async {
  await databaseReference.child(key).child("value").set(data);
}

Future<void> setAllDevice(bool isOn) async {
  int value = isOn ? 0 : 1;
  await RealTimeDB.devices.child("Device1").child("value").set(value);
  await RealTimeDB.devices.child("Device2").child("value").set(value);
  await RealTimeDB.devices.child("Device3").child("value").set(value);
  await RealTimeDB.devices.child("Device4").child("value").set(value);
}

Future<void> setFavorite({DatabaseReference databaseReference, String key, var data}) async {
  await databaseReference.child(key).child("isFavorite").set(data);
}

Future<void> setTime({DatabaseReference databaseReference, String key, var data, int count}) async {
  String spcaer = (data.toString() == "ON") ? " " : "";

  await databaseReference
      .child(key)
      .child("time$count")
      .set("Status $data " + spcaer + DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()).toString());
  count++;
  if (count > 4) {
    count = 1;
  }
  await databaseReference
      .child(key)
      .child('lasttime')
      .set("Status $data " + spcaer + DateFormat('HH:mm dd-MM-yyyy').format(DateTime.now()).toString());
  await databaseReference.child(key).child("count").set(count);
}
