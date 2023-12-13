class CommentModel {
  String? userId;
  String? userName;
  String? userImage;
  String? commentText;
  DateTime? date;

  CommentModel(
      {this.userId,
      this.userName,
      this.userImage,
      this.commentText,
      this.date});
}
