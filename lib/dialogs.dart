import 'package:daki/storage/app_persistent_data_provider.dart';
import 'package:daki/transparent_slide_in_dialog_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

void showEndDialog(BuildContext context) {
  Navigator.of(context).push(TransparentSlideInDialogRoute(Center(
    child: Container(
      width: 200,
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Try again :(',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
          ),
          Container(
            height: 20,
          ),
          RaisedButton(
            color: Colors.pink,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text('OK',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      ),
    ),
  )));
}

void showCongratulationsDialog(
    BuildContext context, int points, String game, bool hasWon) {
  final inputController = TextEditingController();
  Navigator.of(context).push(TransparentSlideInDialogRoute(
    Center(
      child: Container(
        width:  300,
        height: 350,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/reward.svg',
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 23),
                  child: Text(
                    '$points',
                    style: TextStyle(fontSize: 35),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              child: Text(
                hasWon ? 'You have won!' : "You've set a new record!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              width: 150,
              child: TextField(
                textAlign: TextAlign.center,
                controller: inputController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    hintText: 'Your name'),
              ),
            ),
            Container(
              height: 20,
            ),
            RaisedButton(
              color: Colors.pink,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Save',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              onPressed: () {
                Provider.of<AppPersistentDataProvider>(context, listen: false)
                    .addNewBestResult(game, points, inputController.text);

                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    ),
  ));
}
