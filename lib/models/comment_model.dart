import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? userId;
  String? userName;
  String? userImage;
  String? commentText;
  DateTime? date;

  CommentModel(
      {this.userId,
      this.id,
      this.userName,
      this.userImage,
      this.commentText,
      this.date});

  factory CommentModel.fromDatabase(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CommentModel(
      id: snapshot.id,
      userId: data['user_id'],
      userName: data['user_name'],
      userImage: data['user_image'],
      commentText: data['comment_text'],
      date: data['date_comment'],
    );
  }
}
