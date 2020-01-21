import 'package:daki/customviews/main_button.dart';
import 'package:daki/games/catcher/catcher_game.dart';
import 'package:daki/games/colors/colors_game.dart';
import 'package:daki/games/falling/falling_game.dart';
import 'package:daki/storage/app_persistent_data_provider.dart';
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
                    primaryColor: Colors.pink[800],
                    fontFamily: 'Freckles'),
                home: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.pink,
                    ),
                    Container(
                      width: double.infinity,
//            color: Colors.blue.withOpacity(0.5),
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
                                  }, 'catcher'))
                        ],
                      ),
                    )
                  ],
                ));
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
}
