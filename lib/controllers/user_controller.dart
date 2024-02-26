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

  Future setUserInfo(String userId, String userPhone, String userName,
      String userParrain, int birthday, String userPhoto) async {
    db.collection('users').doc(userId).set({
      'userId': userId,
      'phone': userPhone,
      'nom': userName,
      'birthday': birthday,
      'parrain': userParrain,
      'photo': userPhoto
    });
  }

}
