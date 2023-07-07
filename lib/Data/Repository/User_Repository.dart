import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class UserRepositoryImpl implements UserRepository {
  AuthFirebaseRemoteDataSource dataSource;
  UsersRemoteDataSource remoteDataSource;
  UserRepositoryImpl(this.dataSource, this.remoteDataSource);

  @override
  Future<String> signup(String email, String password) async {
    var response = await dataSource.signup(email, password);
    return response;
  }

  @override
  Future<String> createUser(Users user) async {
    var response = await remoteDataSource.createUser(UserDTO(
        name: user.name,
        email: user.email,
        phone: user.phone,
        image: user.image,
        uid: user.uid));
    return response;
  }

  @override
  Future<String> login(String email, String password) async{
    var response = await dataSource.login(email, password);
    return response;
  }

  @override
  Future<String> resetPassword(String email) async{
    var response = await dataSource.resetPassword(email);
    return response;
  }

  @override
  Future<Users> getUser(String uid) async{
    var response = await remoteDataSource.getUser(uid);
    return response;
  }
}
