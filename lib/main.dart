import 'package:firbase_app/Login&Register/cubit/login_cubit.dart';
import 'package:firbase_app/Login&Register/login.dart';
import 'package:firbase_app/cache/cache_helper.dart';
import 'package:firbase_app/home/cubit_home/home_cubit.dart';
import 'package:firbase_app/home/homeScreen.dart';
import 'package:firbase_app/shared/constante.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'observer.dart';

Future<void> main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CachHelper.init();
  // await CachHelper.remove(key: 'uid');
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: ((context) => HomeCubit()..getUserInfo()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme: const TextTheme(
                bodyText1: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                headline5:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w500))),
        home: startWidget,
      ),
    );
  }
}
