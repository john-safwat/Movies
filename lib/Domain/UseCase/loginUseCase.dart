import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class LoginUseCase {
  UserRepository repository;
  LoginUseCase(this.repository);

  Future<String> invoke(String email , String password)async{
    var response = await repository.login(email, password);
    return response;
  }

}
