import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class GetUserDataUseCase {
  UserRepository repository ;
  GetUserDataUseCase(this.repository);


  Future<Users> invoke(String uid)async{
    var response = await repository.getUser(uid);
    // capitalize the name of the user
    response.name = response.name[0].toUpperCase()+response.name.substring(1).toLowerCase();
    return response;
  }
}