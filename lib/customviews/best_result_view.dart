import 'package:daki/storage/game_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BestResult extends StatelessWidget {
  const BestResult(this.record);

  final GameRecord record;

  @override
  Widget build(BuildContext context) {
    return record != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${record.personName}',
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[500]),
              ),
              SvgPicture.asset('assets/images/reward.svg',
                  fit: BoxFit.cover, width: 30, height: 30),
              Text(
                '${record.maxPoints}',
                style: TextStyle(
                    fontSize: 20, color: Colors.grey[500]),
              )
            ],
          )
        : Container();
  }
}
