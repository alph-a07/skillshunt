import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:skillshunt/models/user.dart' as my_user;

Future<my_user.User?> fetchUser() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return null;
  }

  final uid = FirebaseAuth.instance.currentUser!.uid;
  final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
  final userData = Map<String, dynamic>.from(snapshot.value as Map);

  final user = my_user.User(
    nickName: userData['nickName'],
    name: userData['name'],
    avatar: userData['avatar'],
  );

  user.skills = userData['skills'];

  return user;
}
