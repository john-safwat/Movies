import 'package:mymoviesapp/Data/Firebase/FirebaseAuthConfig.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource{
  Auth auth ;
  AuthFirebaseRemoteDataSourceImpl(this.auth);

  @override
  Future<String> signup(String email, String password) async{
    var response = await auth.signup(email, password);
    return response;
  }

}