import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymoviesapp/Data/Firebase/FireStoreConfig.dart';
import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseDatabaseExeption.dart';
import 'package:mymoviesapp/Domain/Models/User/User.dart';
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

  @override
  Future<Users> getUser(String uid) async{
    try{
      var response = await database.getUser(uid);
      return response.toDomain();
    }on FirebaseException catch(e){
      throw FirebaseDatabaseException(e.toString());
    }catch (e){
      throw FirebaseDatabaseException(e.toString());
    }
  }

}