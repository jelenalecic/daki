import 'package:daki/storage/game_record.dart';

class Records {
  Records({this.records});

  factory Records.fromJson(Map<String, dynamic> json) {
    final List<dynamic> records = json['records'];

    return Records(
        records: records.map((dynamic dynamicEntry) {
      final GameRecord record = GameRecord.fromJson(dynamicEntry);
      return record;
    }).toList());
  }

  List<GameRecord> records;

  Map<String, dynamic> toJson() =>
      {"records": records.map((singleEntry) => singleEntry.toJson()).toList()};
}
