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

  Future<String> signup(String email , String password)async{
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return firebaseAuth.currentUser!.uid;
  }

  Future<String> login(String email , String password)async{
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return firebaseAuth.currentUser!.uid;
  }

  Future<void> forgetPassword(String email)async{
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }


}