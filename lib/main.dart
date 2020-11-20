import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantrily/models/PantryItem.dart';
import 'package:pantrily/models/RecipeBuilder.dart';
import 'package:pantrily/screens/add/add_screen.dart';
import 'package:pantrily/screens/authenticate/authenticate.dart';
import 'package:pantrily/screens/profile/profile_screen.dart';
import 'package:pantrily/screens/recipes/components/add_recipe_form.dart';
import 'package:pantrily/screens/recipes/recipe_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: RecipeBuilder(),
        ),
      ],
      child: StreamProvider<AppUser>.value(
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
              '/authenticate': (BuildContext context) => new Authenticate(),
              '/profile': (BuildContext context) => new ProfileScreen(),
              '/home': (BuildContext context) => new Wrapper(),
              '/add': (BuildContext context) => new AddScreen(),
              '/recipes': (BuildContext context) => new RecipeScreen(),
              '/addrecipe': (BuildContext context) => new AddRecipeForm(),
              // '/recipe': (BuildContext context) => new RecipeDetailsScreen(),
            },
          ),
        ),
      ),
    );
  }
}
