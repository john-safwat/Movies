import 'package:mymoviesapp/Data/Firebase/FirebaseAuthConfig.dart';
import 'package:mymoviesapp/Domain/Repository/Auth_Contract.dart';

class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource{
  Auth auth ;
  AuthFirebaseRemoteDataSourceImpl(this.auth);

  @override
  Future<String> signup(String email, String password) async{
    var response = await auth.signup(email, password);
    return response;
  }

}