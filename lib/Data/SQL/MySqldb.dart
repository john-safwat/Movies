import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class MySqlDB {
  static Database? _db;

  Future<Database?> getDB() async{
    if(_db == null) {
      _db = await initiateDB();
      return _db;
    }else {
      return _db;
    }
  }

  initiateDB() async {
    String dataBasePath = await getDatabasesPath() ;
    String path = join( dataBasePath , 'Movies.db') ;
    Database myDb = await openDatabase(path , onCreate: _onCreate , version: 1 ) ;
    return myDb ;
  }

  void _onCreate(Database db , int version) async {
    await db.execute('''
      CREATE TABLE `History` (
        `uid` text NOT NULL,
        `id` text NOT NULL,
        `medium_cover_image` text,
        `large_cover_image` text,
        `rating` double(4,2)
      );
      CREATE TABLE `WishList` (
        `uid` text NOT NULL,
        `id` text NOT NULL,
        `medium_cover_image` text,
        `large_cover_image` text,
        `rating` double(4,2)
      );
    ''');
    print('data base created');
  }
  Future<String>insertData(String sql) async{
    Database? myDb = _db;
    var response =  await myDb!.rawInsert(sql);
    return "Movie Added";
  }

  Future<String>deleteData(String sql) async{
    Database? myDb = _db;
    var response =  await myDb!.rawDelete(sql);
    return "Movie Delete";
  }
}