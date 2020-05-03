
import 'package:bsmart_connect/ui/screen/home_screen.dart';
import 'package:bsmart_connect/ui/screen/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/realtimefirebase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await innitDB();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarDividerColor: Colors.black,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BSmart Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InTroPage(),
    );
  }
}
