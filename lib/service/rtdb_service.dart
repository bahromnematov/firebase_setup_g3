import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_setup_g3/model/post_model.dart';

class RTDBService {
  static final _databse = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async {
    final newRef = _databse.child("posts").push();
    post.postId = newRef.key!;
    newRef.set(post.toJson());
    return _databse.onChildAdded;
  }

  static Future<List<Post>> getPost() async {
    List<Post> posts = [];
    Query query = _databse.ref.child("posts");
    DatabaseEvent event = await query.once();
    var snapshot = event.snapshot;

    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        name: map['name'],
        jobs: map['jobs'],
        image: map['image'] ?? "",
        postId: map['postId'],
      );
      posts.add(post);
    }
    return posts;
  }

  static Future<void> deletePost(String id) async {
    await _databse
        .child("posts")
        .child(id)
        .remove()
        .then((value) => print("Elment O'chirildi"));
  }
}
