import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/models/notation_model.dart';
import 'package:decouvrir/models/post_model.dart';

class PostController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<List<PostModel>> getPost() async {
    QuerySnapshot post = await db
        .collection("posts")
        .orderBy("date_post", descending: true)
        .get();
    return post.docs.map((e) => PostModel.fromDatabase(e)).toList();
  }

  Future<List<PostModel>> getCategorie(String categorie) async {
    QuerySnapshot post = await db
        .collection("posts")
        .where("type", isEqualTo: categorie)
        .orderBy("date_post", descending: true)
        .get();
    return post.docs.map((e) => PostModel.fromDatabase(e)).toList();
  }

  Future setVisite(String postId, String userId) async {
    db
        .collection("posts")
        .doc(postId)
        .collection("visites")
        .doc(userId)
        .set({"user_id": userId, "date_visite": DateTime.now()});
  }

  Future setNotation(String postId, NotationModel notationModel) async {
    db
        .collection("posts")
        .doc(postId)
        .collection("notations")
        .doc(notationModel.userId)
        .set({
      "user_id": notationModel.userId,
      "note": notationModel.note,
      "date_note": DateTime.now()
    });
  }
}
