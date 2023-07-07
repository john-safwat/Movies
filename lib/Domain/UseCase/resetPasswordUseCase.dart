import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class ResetPasswordUseCase{

  UserRepository repository ;
  ResetPasswordUseCase(this.repository);

  Future<String> invoke(String email) async{
    var response = await repository.resetPassword(email);
    return response;
  }

}