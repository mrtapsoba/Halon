import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decouvrir/models/comment_model.dart';

class CommentController {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<List<CommentModel>> getCommentByPost(String postId) {
    return db
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CommentModel.fromDatabase(e)).toList());
  }

  Future setComment(String postId, CommentModel commentModel) async {
    db
        .collection("posts")
        .doc(postId)
        .collection("comments")
        .doc(commentModel.userId)
        .set({
      "user_id": commentModel.userId,
      "user_name": commentModel.userName,
      "user_image": commentModel.userImage,
      "comment_text": commentModel.commentText,
      "date_comment": DateTime.now()
    });
  }
}
