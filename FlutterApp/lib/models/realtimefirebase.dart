import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

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
  static DatabaseReference timeDevice;
  static DatabaseReference monthPower;
}

Future innitDB() async {
  RealTimeDB.setupDB = await innitFirebase();
  RealTimeDB.realtimeDB = FirebaseDatabase(app: RealTimeDB.setupDB);
  RealTimeDB.devices = RealTimeDB.realtimeDB.reference().child("Devices");
  RealTimeDB.power = RealTimeDB.realtimeDB.reference().child("Power");
  RealTimeDB.timeDevice = RealTimeDB.realtimeDB.reference().child("Time");
  RealTimeDB.monthPower = RealTimeDB.realtimeDB.reference().child("MonthPower");
}

Future<void> setDBData(
    {DatabaseReference databaseReference, String key, var data}) async {
  databaseReference.child(key).set(data);
}


