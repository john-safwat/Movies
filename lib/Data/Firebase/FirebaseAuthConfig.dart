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
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => firebaseAuth.currentUser;

  Future<String> signup(String email , String password)async{
    try {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return firebaseAuth.currentUser!.uid;
    }on FirebaseAuthException catch(e){
      return e.toString();
    }catch (e){
      return e.toString();
    }
  }


}