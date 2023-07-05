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
      throw Exception(e.toString());
    }
  }
}
