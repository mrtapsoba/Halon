import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserConnect(String userId) {
    return db
        .collection('users')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        Map<String, dynamic> data = e.data(); // as Map<String, dynamic>;
        return data;
      }).toList();
    });
  }

  Future setUserInfo(String userId, String userIdentifiant, String userName,
      String userParrain, DateTime birthday, String userPhoto) async {
    db.collection('users').doc(userId).update({
      'userId': userId,
      'identifiant': userIdentifiant,
      'nom': userName,
      'birthday': birthday,
      'parrain': userParrain,
      'photo': userPhoto,
      'last_connect': DateTime.now()
    });
  }

  Future updateUserInfo(String userId, String variable, dynamic data) async {
    db.collection('users').doc(userId).update({variable: data});
  }
}
