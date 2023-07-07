import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';

abstract class AuthFirebaseRemoteDataSource{
  Future<String> signup(String email , String password);
  Future<String> login(String email , String password);
  Future<String> resetPassword(String email);
}

abstract class UserRepository{
  Future<String> signup(String email , String password);
  Future<String> login(String email , String password);
  Future<String> resetPassword(String email);
  Future<String> createUser(Users user);
  Future<Users> getUser(String uid);
}

abstract class UsersRemoteDataSource{
  Future<String> createUser(UserDTO user);
  Future<Users> getUser(String uid);
}