import 'package:mymoviesapp/Domain/Repository/Auth_Contract.dart';

class AuthRepositoryImpl implements AuthRepository{

  AuthFirebaseRemoteDataSource dataSource ;
  AuthRepositoryImpl(this.dataSource);

  @override
  Future<String> signup(String email, String password) async{
    var response  = await dataSource.signup(email, password);
    return response;
  }

}