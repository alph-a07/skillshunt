import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:skillshunt/models/user.dart' as MyUser;

Future<MyUser.User?> fetchUser() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return null;
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
  final userData = Map<String, dynamic>.from(snapshot.value as Map);

  final user = MyUser.User(
    nickName: userData['nickName'],
    name: userData['name'],
    avatar: userData['avatar'],
  );

  return user;
}
