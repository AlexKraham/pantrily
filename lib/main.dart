import 'package:flutter/material.dart';
import 'package:pantrily/screens/authenticate/authenticate.dart';
import 'package:pantrily/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pantrily/services/auth.dart';
import 'package:provider/provider.dart';

import 'package:pantrily/models/user.dart';

import 'models/NavItem.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser>.value(
      value: AuthService().user,
      child: ChangeNotifierProvider(
        create: (context) => NavItems(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Pantrily",
          theme: ThemeData(
            backgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              elevation: 0,
            ),
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Wrapper(),
          routes: <String, WidgetBuilder>{
            '/authenticate': (BuildContext context) => new Authenticate()
          },
        ),
      ),
    );
  }
}
