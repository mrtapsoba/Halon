import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/controllers/notification_controller.dart';
import 'package:decouvrir/models/constantes.dart';

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
    db.collection('users').doc(userId).set({
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

  Future setLike(String postId, String userId, bool isLiked) async {
    db
        .collection("users")
        .doc(userId)
        .collection("likes")
        .doc(postId)
        .set({"postId": postId, "isLiked": isLiked});
  }

  Stream<List<Map<String, dynamic>>> getlike(String userId) {
    if (Constantes().appName != userId) {
      initUser(userId);
    }
    return db
        .collection("users")
        .doc(userId)
        .collection("likes")
        .where("isLiked", isEqualTo: true)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        Map<String, dynamic> data = e.data(); // as Map<String, dynamic>;
        return data;
      }).toList();
    });
  }

  void initUser(String userId) async {
    //if (user == null) return;
    NotificationController.getToken().then((value) {
      UserController().setToken(userId, value);
    });
  }

  Future<void> setToken(String userId, String? token) async {
    return await db.collection("users").doc(userId).update({
      'token': token,
    });
  }

  Future<void> setLink(String userId, String? link) async {
    return await db.collection("users").doc(userId).update({
      'link': link,
    });
  }
}
