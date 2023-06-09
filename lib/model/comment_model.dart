class Comment {
  final String userId;
  final String userName;
  final String userImage;
  final String comment;

  Comment({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.comment,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'userImage': userImage,
      'comment': comment,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'],
      userName: map['userName'],
      userImage: map['userImage'],
      comment: map['comment'],
    );
  }
}
