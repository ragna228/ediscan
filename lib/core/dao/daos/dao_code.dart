
import 'package:floor/floor.dart';

import '../entity/code.dart';



@dao
abstract class DaoCode{
  @Query("SELECT * from Code")
  Future<List<Code>> getAll();

  @insert
  Future<void> insertCode(Code code);
}