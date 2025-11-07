class Post {
  String name;
  String jobs;
  String image;
  String? postId;

  Post({
    required this.name,
    required this.jobs,
    required this.image,
     this.postId,
  });

  Post.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      jobs = json['jobs'],
      image = json['image'],
      postId = json['postId'] ?? "";

  Map<String, dynamic> toJson() => {
    "name": name,
    "jobs": jobs,
    "image": image,
    'postId': postId,
  };
}
