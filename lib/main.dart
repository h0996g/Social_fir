import 'package:bloc/bloc.dart';
import 'package:firbase_app/Login&Register/login.dart';
import 'package:firbase_app/cache/cache_helper.dart';
import 'package:firbase_app/home/homeScreen.dart';
import 'package:firbase_app/shared/constante.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'observer.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();
  Widget widget;
  UID = CachHelper.getData(key: 'uid') ?? '';
  if (UID != '') {
    widget = const Home();
  } else {
    widget = LoginScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  MyApp(this.startWidget);
  Widget startWidget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: startWidget,
    );
  }
}
