class GameRecord {
  GameRecord({this.gameName, this.personName, this.maxPoints});

  String gameName;
  String personName;
  int maxPoints;

  factory GameRecord.fromJson(Map<String, dynamic> json) {
    return GameRecord(
        gameName: json['gameName'],
        personName: json['personName'],
        maxPoints: json['maxPoints']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'gameName': gameName,
        'personName': personName,
        'maxPoints': maxPoints,
      };
}
