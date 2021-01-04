import 'package:flutter/material.dart';
import 'package:sac/constant.dart';
import 'package:sac/screens/homescreen/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'locator.dart';
import 'package:sac/services/navigation_service.dart';
import 'package:sac/services/dialog_service.dart';
import 'package:sac/manager/dialog_manager.dart';
import 'package:sac/screens/router.dart';
/*
void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAC',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
        ),
      ),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}*/






























Future main()async {
  runApp(MaterialApp(home: MyApp()));}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }


  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stray Animal Complaint System',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Open Sans',
        ),
      ),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
      /*title: 'Stray Animal Complaint System',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: 'Oswald',
        scaffoldBackgroundColor: Colors.white60,
      ),
      home: StartUpView(),*/
    );
  }
}


/*class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stray Animal Complaint System',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: 'Oswald',
        scaffoldBackgroundColor: Colors.white60,
      ),
      home: HomeScreen(),
    );
  }
}*/

