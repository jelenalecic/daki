import 'package:daki/customviews/main_button.dart';
import 'package:daki/games/catcher/catcher_game.dart';
import 'package:daki/games/colors/colors_game.dart';
import 'package:daki/games/falling/falling_game.dart';
import 'package:daki/storage/app_persistent_data_provider.dart';
import 'package:daki/turn_on_the_light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(DakiApp());

class DakiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppPersistentDataProvider>(
        create: (_) => AppPersistentDataProvider(),
        child: Consumer<AppPersistentDataProvider>(
          builder: (context, provider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.black,
                  fontFamily: 'Freckles'),
              home: Stack(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                    image: AssetImage("assets/images/pixls.png"),
                    fit: BoxFit.cover,
                  ))),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Builder(
                            builder: (context) => MainButton(() {
                                  openFalling(context);
                                }, 'falling')),
                        Container(
                          height: 50,
                        ),
                        Builder(
                            builder: (context) => MainButton(() {
                                  openColors(context);
                                }, 'colors')),
                        Container(
                          height: 50,
                        ),
                        Builder(
                            builder: (context) => MainButton(() {
                                  openCatcher(context);
                                }, 'catcher')),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40),
                      child: Text(
                        'JayDee',
                        style: TextStyle(
                            letterSpacing: 1,
                            fontSize: 20,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontFamily: 'Lato'),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  void openFalling(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => FallingGame()));
  }

  void openColors(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ColorsGame()));
  }

  void openCatcher(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => CatcherGame()));
  }

  void openLights(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => TurnOnTheLight()));
  }
}
