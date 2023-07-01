abstract class AuthFirebaseRemoteDataSource{
  Future<String> signup(String email , String password);
}

abstract class AuthRepository{
  Future<String> signup(String email , String password);
}