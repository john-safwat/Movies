import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';

abstract class AuthFirebaseRemoteDataSource{
  Future<String> signup(String email , String password);
}

abstract class UserRepository{
  Future<String> signup(String email , String password);
  Future<String> createUser(Users user);
}

abstract class UsersRemoteDataSource{
  Future<String> createUser(UserDTO user);
}