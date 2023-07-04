import 'package:mymoviesapp/Domain/Models/User/User.dart';
import 'package:mymoviesapp/Domain/Repository/User_Data_Contract.dart';

class SignupUseCase{

  UserRepository repository;
  SignupUseCase(this.repository);

  Future<String> invoke({required String name ,required  String email ,required  String password ,required  String image ,required  String phone})async{
    var response = await repository.signup(email, password);
    Users user = Users(name: name, email: email, phone: phone, image: image, uid: response);
    var userResponse = await repository.createUser(user);
    return userResponse;
  }

}