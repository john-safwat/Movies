import 'package:firebase_auth/firebase_auth.dart';

class Auth {

  // singleton pattern to use one instance in all app
  static Auth? _instance ;
  Auth._();

  static Auth getAuth(){
    _instance ??= Auth._();
    return _instance!;
  }

  // firebase auth configuration
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  

  Future<String> signup(String email , String password)async{
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Account Created Successfully";
    }on FirebaseAuthException catch(e){
      if(e.toString() == ''){
        return "";
      }else if(e.toString() == ''){
        return "";
      }else{
        return "";
      }
    }catch (e){
      return e.toString();
    }
  }


}