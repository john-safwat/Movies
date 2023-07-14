import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';
import 'package:mymoviesapp/Domain/Exceptions/FirebaseTimeoutException.dart';

class FirebaseDatabase{

  static FirebaseDatabase? _instance ;

  FirebaseDatabase._();

  static FirebaseDatabase getFirebaseDatabaseInstance(){
    _instance ??= FirebaseDatabase._();
    return _instance!;
  }

  CollectionReference<UserDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Users").withConverter(
        fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<void> createUser(UserDTO user)async{
    var ref =  getCollectionReference() ;
    return ref.doc(user.uid).set(user).timeout(Duration(seconds: 5) , onTimeout: () =>throw FirebaseTimeoutException(),);
  }

  Future<UserDTO> getUser(String uid)async{
    var response =  await FirebaseFirestore.instance.collection('Users').where('uid' , isEqualTo: uid).get();
    UserDTO? user;
    response.docs.forEach((element) {user = UserDTO.fromFireStore(element.data());});
    return user!;
  }
  
  Future<void> updateUserData(UserDTO user)async{
    var ref = getCollectionReference().doc(user.uid);
    return ref.update(user.toFireStore()).timeout(Duration(seconds: 5));
  }

}