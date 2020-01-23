import 'dart:convert';
import 'dart:io';

import 'package:daki/storage/game_record.dart';
import 'package:daki/storage/records.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const String recordsFileName = '/results.json';

const String gameColorsName = 'colors';
const String gameFallingGame = 'falling';
const String gameCatcherName = 'catcher';

class AppPersistentDataProvider with ChangeNotifier {
  AppPersistentDataProvider() {
    loadRecords();
  }

  Records listOfRecords;

  void loadRecords() async {
    File recordsFile = await getFile(recordsFileName);
    if (recordsFile.existsSync()) {
      listOfRecords =
          Records.fromJson(json.decode(recordsFile.readAsStringSync()));
    }
  }

  Future<File> getFile(String name) async {
    final path = await _localPath;
    return File('$path' + name);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<bool> updateStorageRecords() async {
    File recordsFile = await getFile(recordsFileName);

    if (!recordsFile.existsSync()) {
      recordsFile.createSync();
    }
    recordsFile.writeAsStringSync(json.encode(listOfRecords.toJson()));
    return true;
  }

  bool isBestResult(String gameName, int newResult) {
    listOfRecords ??= Records();
    listOfRecords.records ??= [];

    if (newResult == 0) {
      return false;
    }

    if (listOfRecords.records.isEmpty) {
      return true;
    }

    GameRecord record = listOfRecords.records.firstWhere(
        (GameRecord temp) => temp.gameName == gameName,
        orElse: () => null);

    if (record != null) {
      if (record.maxPoints <= newResult) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  void addNewBestResult(String gameName, int noOfPoints, String personName) {
    GameRecord record = listOfRecords.records.firstWhere(
        (GameRecord temp) => temp.gameName == gameName,
        orElse: () => null);

    if (record != null) {
      record.maxPoints = noOfPoints;
      record.personName = personName;
    } else {
      listOfRecords.records.add(GameRecord(
          gameName: gameName, maxPoints: noOfPoints, personName: personName));
    }
    updateStorageRecords();
  }

  GameRecord getMaxForGame(String gameName) {
    listOfRecords ??= Records();
    listOfRecords.records ??= [];

    if (listOfRecords.records.isEmpty) {
      return null;
    }

    GameRecord record = listOfRecords.records.firstWhere(
        (GameRecord temp) => temp.gameName == gameName,
        orElse: () => null);

    if (record != null) {
      return record;
    } else {
      return null;
    }
  }
}
