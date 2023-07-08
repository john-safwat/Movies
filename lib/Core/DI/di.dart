import 'package:mymoviesapp/Data/API/ApiManager.dart';
import 'package:mymoviesapp/Data/DataSource/Auth_Firebase_Remote_DataSource_Impl.dart';
import 'package:mymoviesapp/Data/DataSource/Movies_Data_Local_DateSource.dart';
import 'package:mymoviesapp/Data/DataSource/Movies_Data_Remote_DataSource_Impl.dart';
import 'package:mymoviesapp/Data/DataSource/Search_Data_Remote_DataSource_Impl.dart';
import 'package:mymoviesapp/Data/DataSource/Users_Remote_DataSource_Impl.dart';
import 'package:mymoviesapp/Data/Firebase/FireStoreConfig.dart';
import 'package:mymoviesapp/Data/Firebase/FirebaseAuthConfig.dart';
import 'package:mymoviesapp/Data/Repository/User_Repository.dart';
import 'package:mymoviesapp/Data/Repository/Movies_Data_Repository_Impl.dart';
import 'package:mymoviesapp/Data/Repository/Search_Data_Repository_Impl.dart';
import 'package:mymoviesapp/Data/SQL/MySqldb.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';
import 'package:mymoviesapp/Domain/Repository/Movies_Data_Contract.dart';
import 'package:mymoviesapp/Domain/Repository/Search_Data_Contract.dart';
import 'package:sqflite_common/sqlite_api.dart';

ApiManager getApiManager (){
  return ApiManager.getApiManager();
}

MySqlDB getSqlDb(){
  return MySqlDB.getMySqlDb();
}

MoviesDataLocalDataSource getLocalDataSource(MySqlDB db){
  return MoviesDataLocalDataSourceImpl(db);
}
MoviesDataRemoteDataSource getMoviesDataRemoteDataSource(ApiManager apiManager){
  return MoviesDataRemoteDataSourceImpl(apiManager);
}

MoviesDataRepository getMoviesDataRepository(MoviesDataRemoteDataSource remoteDataSource , MoviesDataLocalDataSource localDataSource){
  return MoviesDataRepositoryImpl(remoteDataSource  ,  localDataSource);
}

MoviesDataRepository injectMoviesRepository(){
  return getMoviesDataRepository(getMoviesDataRemoteDataSource(getApiManager()), getLocalDataSource(getSqlDb()));
}

SearchDataRemoteDataSource getSearchDataRemoteDataSource(ApiManager apiManager){
  return SearchDataRemoteDataSourceImpl(apiManager);
}

SearchDataRepository getSearchDataRepository( SearchDataRemoteDataSource remoteDataSource){
  return SearchDataRepositoryImpl(remoteDataSource);
}

SearchDataRepository injectSearchRepo(){
  return getSearchDataRepository(getSearchDataRemoteDataSource(getApiManager()));
}

Auth getAuth(){
  return Auth.getAuth();
}

AuthFirebaseRemoteDataSource getAuthFirebaseRemoteDataSource(Auth auth){
  return AuthFirebaseRemoteDataSourceImpl(auth);
}

FirebaseDatabase getFirebaseDatabase(){
  return FirebaseDatabase.getFirebaseDatabaseInstance();
}

UsersRemoteDataSource getUsersRemoteDataSource(FirebaseDatabase database){
  return UsersRemoteDataSourceImpl(database);
}

UserRepository getUserRepository(AuthFirebaseRemoteDataSource remoteDataSource , UsersRemoteDataSource usersRemoteDataSource){
  return UserRepositoryImpl(remoteDataSource , usersRemoteDataSource);
}

UserRepository injectUserRepository(){
  return getUserRepository(getAuthFirebaseRemoteDataSource(getAuth()) , getUsersRemoteDataSource(getFirebaseDatabase()));
}

