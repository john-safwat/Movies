import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymoviesapp/Data/Firebase/FirebaseAuthConfig.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseAuthException.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseTimeoutException.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class AuthFirebaseRemoteDataSourceImpl implements AuthFirebaseRemoteDataSource {
  Auth auth;
  AuthFirebaseRemoteDataSourceImpl(this.auth);

  @override
  Future<String> signup(String email, String password) async {
    try {
      var response = await auth.signup(email, password).timeout(
            Duration(seconds: 3),
            onTimeout: () => throw FirebaseTimeoutException(),
          );
      return response;
    } on FirebaseAuthException catch (e) {
      var error;
      switch (e.code) {
        case "error_invalid_email":
          error = "Invalid Email Address";
          break;
        case "error_too_many_requests":
          error = "To Many Requests";
          break;
        case "error_operation_not_allowed":
          error = "Cannot Create Account Now Try Again Later";
          break;
        case "email-already-in-use":
          error = "Email Already In Use";
          break;
        default:
          error = e.toString();
      }
      throw FirebaseAuthDataSourceException(error);
    } catch (e) {
      throw FirebaseAuthDataSourceException(e.toString());
    }
  }

  @override
  Future<String> login(String email, String password) async{
    try{
      var response = await auth.login(email, password).timeout(Duration(seconds: 10) ,  onTimeout: () => throw FirebaseTimeoutException(),);
      return response;
    }on FirebaseAuthException catch (e){
      String error = '';
      switch (e.code) {
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          error = "Wrong email/password combination.";
        break;
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          error = "No user found with this email.";
          break;
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          error =  "User disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          error =  "Too many requests to log into this account.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          error =  "Email address is invalid.";
          break;
        default:
          error =  "Login failed. Please try again.";
          break;
      }
      throw FirebaseAuthDataSourceException(error);
    }catch (e){
      throw FirebaseAuthDataSourceException(e.toString());
    }
  }
}
