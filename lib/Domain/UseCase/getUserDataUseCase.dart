import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class GetUserDataUseCase {
  UserRepository repository ;
  GetUserDataUseCase(this.repository);


  Future<Users> invoke(String uid)async{
    var response = await repository.getUser(uid);
    return response;
  }
}