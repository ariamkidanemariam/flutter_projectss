class Post {
  final int postId, id;
  final String name, email, body;

  Post({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['postId'],
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
    );
    
  }

  static List<Post> listFromJson(List<dynamic> jsonlist){
   return jsonlist.map((item)=>Post.fromJson(item)).toList();
  }
}
