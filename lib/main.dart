import 'package:flutter/material.dart';
import 'package:gameaiupdate/shared/splash.dart';
import 'package:gameaiupdate/screens/wrapper.dart';
import 'package:provider/provider.dart';
import "package:gameaiupdate/services/auth.dart";
import 'package:gameaiupdate/models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

//void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blue.shade300,
          dividerColor: Colors.black,
        ),
        home: AnimatedSplashScreen(
          splash: Splash(),
          duration: 3000,
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.purple[100],
          nextScreen: Wrapper(),
        ), //Wrapper(),
      ),
    );
  }
}
