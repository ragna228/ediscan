import 'dart:async';

import 'package:floor/floor.dart';
import 'entity/code.dart';
import 'daos/dao_code.dart';
import 'package:sqflite/sqflite.dart' as sql_lite;

part 'db.g.dart';
@Database(version : 3, entities : [Code])
abstract class AppDatabase extends FloorDatabase{
  DaoCode get codeDao;
}