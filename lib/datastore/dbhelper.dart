import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DbHelper {
  static final DbHelper _dbHelper = DbHelper._internal();
  static final String DB_DIR = "demo";
  static final String DB_FILE = "demo.db";
  static Database _db;
  /*
     * Named Constructor
     */
  DbHelper._internal();
  /*
     * Factory Constructor
     */
  factory DbHelper() {
    return _dbHelper;
  }

  static DbHelper getInstance() {
    return _dbHelper;
  }

  /*
     * Fetch the db instance. if it is null initialize it
     */
  Future<Database> getDatabase() async {
    if(_db == null) {
      _db = await initDB();
    }
    return _db;
  }



  Future<Database> initDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    Directory dbDir = new Directory(appDocDir.path + "/" + DB_DIR);
    await dbDir.create(recursive: true);
    return await databaseFactoryIo.openDatabase(dbDir.path + "/" + DB_FILE);
  }
}