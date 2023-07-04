import 'package:mymoviesapp/Data/Firebase/FireStoreConfig.dart';
import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class UsersRemoteDataSourceImpl implements UsersRemoteDataSource{
  FirebaseDatabase database;
  UsersRemoteDataSourceImpl(this.database);

  @override
  Future<String> createUser(UserDTO user) async {
    try {
      await database.createUser(user);
      return "User Created Successfully";
    }catch (e){
      return e.toString();
    }
  }

}