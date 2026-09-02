class Comment {
  final int postId, id;
  final String name, email, body;

  Comment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });
factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
    
  }

  List<Comment> listFromJson(List<dynamic> jsonlist){
   return jsonlist.map((item)=>Comment.fromJson(item)).toList();
  }
}