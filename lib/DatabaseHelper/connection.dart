import 'package:login_project/DatabaseHelper/tables.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  final databaseName = 'auth.db';

  //Database connection
  Future<Database> initDB()async{
    final databasePath = await getApplicationDocumentsDirectory();
    final path = join(databasePath.path, databaseName);
    return openDatabase(path, version: 1, onCreate: (db,version)async{
      //I forgot to execute the table
      await db.execute(Tables.userTable);
    });
  }

}