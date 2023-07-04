class UserDTO {
  String uid ;
  String email ;
  String image ;
  String phone ;
  String name ;


  UserDTO({
   required this.name ,
   required this.email ,
   required this.phone,
   required this.image ,
   required this.uid
  });

  UserDTO.fromFireStore(Map<String , dynamic> json):this(
   uid: json['uid'],
   name: json['name'],
   email: json['email'],
   phone: json['phone'],
   image: json['image'],
  );

  Map<String , dynamic> toFireStore(){
    return {
      'uid' : uid,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'image' : image
    };
  }

}