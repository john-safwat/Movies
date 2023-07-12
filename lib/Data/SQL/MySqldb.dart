import 'package:mymoviesapp/Data/Models/MovieResponse/MoviesDTO.dart';
import 'package:mymoviesapp/Domain/Models/Movies/Movies.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class MySqlDB {
  Database? _db;
  static MySqlDB? _instance ;

  MySqlDB._() {getDB();}
  static getMySqlDb(){
    _instance??= MySqlDB._();
    return _instance;
  }

  Future<Database?> getDB() async{
    if(_db == null) {
      _db = await _initiateDB();
      return _db;
    }else {
      return _db;
    }
  }

  _initiateDB() async {
    String dataBasePath = await getDatabasesPath() ;
    String path = join( dataBasePath , 'Movies.db') ;
    Database myDb = await openDatabase(path , onCreate: _onCreate , version: 2 ) ;
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
    ''');
    await db.execute('''
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
  Future<String>insertMovieToHistory(Movies movies , String uid) async{
    Database? myDb = _db;
    var sql = "INSERT INTO `History` (`uid`, `id`, `medium_cover_image`, `large_cover_image`, `rating`) VALUES ('$uid', '${movies.id}', '${movies.mediumCoverImage}', '${movies.largeCoverImage}', '${movies.rating}');";
    var response =  await myDb!.rawInsert(sql);
    return "Movie Added";
  }

  Future<String>deleteMovieFromHistory(num? id , String uid) async{
    Database? myDb = _db;
    var sql = "DELETE FROM `History` WHERE `uid` = '$uid' AND `id` = '$id';";
    var response =  await myDb!.rawDelete(sql);
    return "Movie Delete";
  }

  Future<bool>isInWatchHistory(num? id , String uid) async{
    Database? myDb = _db;
    var sql = "SELECT COUNT(*) as count FROM `History` WHERE `uid` = '$uid' AND `id` = '$id';";
    var response =  await myDb!.rawQuery(sql);
    return response.first['count'] as int > 0 ;
  }

  selectWatchHistory(String uid) async{
    Database? myDb = _db;
    var sql = "SELECT * FROM `History` WHERE `uid` = '$uid';";
    var response =  await myDb!.rawQuery(sql);
    return response;
  }

  Future<String>insertMovieToWishList(Movies movies , String uid) async{
    Database? myDb = _db;
    var sql = "INSERT INTO `WishList` (`uid`, `id`, `medium_cover_image`, `large_cover_image`, `rating`) VALUES ('$uid', '${movies.id}', '${movies.mediumCoverImage}', '${movies.largeCoverImage}', '${movies.rating}');";
    var response =  await myDb!.rawInsert(sql);
    return "Movie Added";
  }

  Future<String>deleteMovieFromWishList(num? id , String uid) async{
    Database? myDb = _db;
    var sql = "DELETE FROM `WishList` WHERE `uid` = '$uid' AND `id` = '$id';";
    var response =  await myDb!.rawDelete(sql);
    return "Movie Delete";
  }

  Future<bool>isInWishList(num? id , String uid) async{
    Database? myDb = _db;
    var sql = "SELECT COUNT(*) as count FROM `WishList` WHERE `uid` = '$uid' AND `id` = '$id';";
    var response =  await myDb!.rawQuery(sql);
    return response.first['count'] as int > 0 ;
  }

  selectWishList(String uid) async{
    Database? myDb = _db;
    var sql = "SELECT * FROM `WishList` WHERE `uid` = '$uid';";
    var response =  await myDb!.rawQuery(sql);
    return response;
  }

}