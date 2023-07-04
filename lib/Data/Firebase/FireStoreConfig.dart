import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mymoviesapp/Data/Models/User/UserDTO.dart';

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
    await getCollectionReference().doc().set(user);
  }

}