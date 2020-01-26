import 'package:daki/storage/game_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BestResult extends StatelessWidget {
  const BestResult(this.record);

  final GameRecord record;

  @override
  Widget build(BuildContext context) {
    return record != null
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/images/reward.svg',
                  fit: BoxFit.cover, width: 70, height: 70),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  '${record.maxPoints}',
                  style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 35),
                child: Text(
                  '${record.personName}',
                  style: TextStyle(
                      fontSize: 22, color: Colors.grey[600]),
                ),
              )
            ],
          )
        : Container();
  }
}
