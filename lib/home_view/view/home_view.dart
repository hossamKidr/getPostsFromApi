import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<PostsModel>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              var posts = snapshot.data;
              return ListView.builder(
                  itemCount: posts?.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('${posts![index].title}'),
                      trailing: Text('${posts[index].id}'),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}

Future<List<PostsModel>> getPosts() async {
  Dio dio = Dio();
  List<PostsModel> posts = [];
  try {
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    var list = response.data as List;
  posts = list.map((post) => PostsModel.fromJson(post)).toList();
  } catch (error) {
    print(error.toString());
  }
  print(posts);
  return posts;
}

class PostsModel {
  int? userid;
  int? id;
  String? title;
  String? body;

  PostsModel({
    this.userid,
    this.id,
    this.title,
    this.body,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }
  Map<String, dynamic> toJson() => {
        'userid': userid,
        'id': id,
        'title': title,
        'body': body,
      };
}
