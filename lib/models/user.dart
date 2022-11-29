import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  late String? uid;
  late String? name;
  late String? email;
  late String? phone;
  late String? address;
  late String? imageUrl;
  late bool? isAdmin;

  MyUser(
      {this.uid,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.imageUrl,
      this.isAdmin});

  Map<String, dynamic> toMap() => {
        'uid': uid,
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
        'phone': phone,
        'address': address,
        'isAdmin': isAdmin,
      };

  MyUser.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    uid = snapshot['uid'];
    name = snapshot['name'];
    email = snapshot['email'];
    imageUrl = snapshot['imageUrl'];
    phone = snapshot['phone'];
    address = snapshot['address'];
    isAdmin = snapshot['isAdmin'];
  }
}
