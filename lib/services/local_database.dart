import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

const String tableSavedLocation = 'location';
const String columnId = 'id';
const String columnAddress = 'address';

class LocalDB {
  static Database? _database;
  static LocalDB? _localHelper;

  LocalDB._createInstance();

  factory LocalDB() {
    // ignore: prefer_conditional_assignment
    if (_localHelper == null) {
      _localHelper = LocalDB._createInstance();
    }
    return _localHelper!;
  }

  Future<Database> get database async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}alarm.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          create table $tableSavedLocation ( 
          $columnId integer primary key autoincrement, 
          $columnAddress text not null)
        ''');
      },
    );
    return database;
  }

  void insertSavedLocation(LocationInfo locationInfo) async {
    // ignore: unnecessary_this
    var db = await this.database;
    var result = await db.insert(tableSavedLocation, locationInfo.toMap());
    debugPrint('result IN Location HELPER : $result');
  }

  Future<List<LocationInfo>> getSavedLocations() async {
    List<LocationInfo> savedlocations = [];

    // ignore: unnecessary_this
    var db = await this.database;
    var result = await db.query(tableSavedLocation);
    // ignore: avoid_function_literals_in_foreach_calls
    result.forEach((element) {
      var locationInfo = LocationInfo.fromMap(element);
      savedlocations.add(locationInfo);
    });

    return savedlocations;
  }
}

class LocationInfo {
  int? id;
  String? address;

  LocationInfo({
    this.id,
    this.address,
  });

  factory LocationInfo.fromMap(Map<String, dynamic> json) => LocationInfo(
        id: json["id"],
        address: json["address"],
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "address": address,
      };
}
