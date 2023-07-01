import 'package:mymoviesapp/Domain/Repository/Auth_Contract.dart';

class SignupUseCase{

  AuthRepository repository;
  SignupUseCase(this.repository);

  Future<String> invoke(String email , String password)async{
    var response = await repository.signup(email, password);
    return response;
  }

}