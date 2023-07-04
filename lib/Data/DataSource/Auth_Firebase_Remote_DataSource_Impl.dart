import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymoviesapp/Data/Firebase/FirebaseAuthConfig.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseAuthException.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource{
  Auth auth ;
  AuthFirebaseRemoteDataSourceImpl(this.auth);

  @override
  Future<String> signup(String email, String password) async{
    try {
      var response = await auth.signup(email, password);
      return response;
    }on FirebaseAuthException catch(e){
      var error ;
      print(e.code);
      switch (e.code) {
        case "ERROR_INVALID_EMAIL":
          error = "Invalid Email Address";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          error = "To Many Requests";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          error = "Cannot Create Account Now Try Again Later";
          break;
        case "email-already-in-use":
          error = "Email Already In Use";
          break;
        default:
          error = e.toString();
      }
      throw FirebaseAuthDataSourceException(error);
    }catch (e){
      throw Exception(e.toString());
    }
  }

}