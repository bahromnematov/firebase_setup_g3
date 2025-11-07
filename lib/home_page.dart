import 'package:firebase_setup_g3/details_page.dart';
import 'package:firebase_setup_g3/model/post_model.dart';
import 'package:firebase_setup_g3/service/auth_service.dart';
import 'package:firebase_setup_g3/service/rtdb_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Post> posts = [];

  void _apiGetPosts() async {
    setState(() {
      isLoading = true;
    });
    var list = await RTDBService.getPost();

    setState(() {
      posts = list;
      isLoading = false;
    });
  }

  void deletePost(String id) async {
    await RTDBService.deletePost(id);
    setState(() {
      posts.removeWhere((post) => post.postId == id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _apiGetPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text(
          "Restaurants Near You",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.location_pin))],
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 300,
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // Shadow color with transparency
                          spreadRadius: 3,
                          // Extends the shadow
                          blurRadius: 7,
                          // Blurs the shadow
                          offset: Offset(0, 3), // Shifts the shadow down
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 220,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            image: DecorationImage(
                              image: NetworkImage(posts[index].image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      posts[index].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      posts[index].jobs,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                kIsWeb
                                    ? SizedBox()
                                    : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          deletePost(
                                            posts[index].postId ?? "asda",
                                          );
                                          print(posts[index].postId.toString());
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      floatingActionButton:
          kIsWeb
              ? SizedBox()
              : FloatingActionButton(
                onPressed: () async {
                  Map result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) {
                        return DetailsPage();
                      },
                    ),
                  );
                  if (result.containsKey("date")) {
                    print("Ha Keldi");
                  }
                },
                child: Icon(Icons.add),
              ),
    );
  }

  void dialog() {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              "Accountdan Chiqmoqchimisz",
              style: TextStyle(fontSize: 20),
            ),
            content: Text("Accountdan chiqish uchun Confirm bosing"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () {
                  AuthService.logOut(context);
                },
                child: Text("Confirm", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }
}
