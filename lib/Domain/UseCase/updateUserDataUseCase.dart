import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class UpdateUserDataUseCase {

  UserRepository repository ;
  UpdateUserDataUseCase(this.repository);

  Future<String> invoke(Users user)async{
    var response = await repository.updateUserData(user);
    return response;
  }

}