

import 'package:EdiScan/core/dao/entity/code.dart';

abstract class DaoCodeService{

  Future<List<Code>> getAll();

  Future<void> insert(Code code);
}