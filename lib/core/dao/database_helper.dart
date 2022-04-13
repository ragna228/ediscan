import 'package:EdiScan/core/dao/db.dart';
import 'dao_interface/dao_code_service_floor.dart';
import 'dao_interface/dao_service.dart';

class DbHelper {
  static late AppDatabase _appDatabase;
  static late DaoCodeService _codeService;

  static DaoCodeService daoCodeService() {
    return _codeService;
  }

  static Future<void> init() async {
    _appDatabase =
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    _codeService = DaoCodeServiceFloor(_appDatabase.codeDao);
  }
}
