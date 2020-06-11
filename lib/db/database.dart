import 'dart:async';

import 'package:floor/floor.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'favourite.dart';
import 'favourite_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [SavedCountry])
abstract class AppDatabase extends FloorDatabase {
  SavedCountryDao get savedCountryDao;
}