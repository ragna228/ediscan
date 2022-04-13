

import 'package:EdiScan/core/dao/database_helper.dart';
import 'package:EdiScan/core/dao/entity/code.dart';

import '../daos/dao_code.dart';
import 'dao_service.dart';

class DaoCodeServiceFloor extends DaoCodeService{
  DaoCode codes;

  DaoCodeServiceFloor(this.codes);

  @override
  Future<List<Code>> getAll() async {
    return await codes.getAll();
  }

  @override
  Future<void> insert(Code code) async{
    await codes.insertCode(code);
  }

}