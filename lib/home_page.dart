import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/post1.dart';
import 'package:jaad_first_api/post1_comments.dart';
import 'package:jaad_first_api/posts.dart';

import 'comments_post1.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var getPosts = 'https://jsonplaceholder.typicode.com/posts';
  var getPost1 = 'https://jsonplaceholder.typicode.com/posts/1';
  var getPost1Comments = 'https://jsonplaceholder.typicode.com/posts/1/comments';
  var getCommentsPost1 = 'https://jsonplaceholder.typicode.com/comments?postId=1';

  var postData = 'No Post Data!';
  var data = '';
  var statusCodePosts = 404;
  var statusCodePost1 = 404;
  var statusCodePost1Comments = 404;
  var statusCodeCommentsPost1 = 404;

  void fetchData() async{
    // print('Button Pressed!');
    http.Response responsePosts = await http.get(Uri.parse(getPosts));
    http.Response responsePost1 = await http.get(Uri.parse(getPost1));
    http.Response responsePost1Comments = await http.get(Uri.parse(getPost1Comments));
    http.Response responseCommentsPost1 = await http.get(Uri.parse(getCommentsPost1));

    setState(() {
      postData = responsePosts.body;
      // print(data);
      statusCodePosts = responsePosts.statusCode;
      statusCodePost1 = responsePost1.statusCode;
      statusCodePost1Comments = responsePost1Comments.statusCode;
      statusCodeCommentsPost1 = responseCommentsPost1.statusCode;
      // print('Status Code: $statusCode');
      if (statusCodePosts == 200
          && statusCodePost1 == 200
          && statusCodePost1Comments == 200
          && statusCodeCommentsPost1 == 200){

        data = 'All data received!';
      }
    });
  }

  void _goToPosts() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Posts(),
        ));
  }

  void _goToPost1() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Post1(),
        ));
  }

  void _goToPost1Comments() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Post1Comments(),
        ));
  }

  void _goToCommentsPost1() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CommentsPost1(),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'First API',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,

          actions: [
            IconButton(
                onPressed: (){
                  fetchData();
                },
                icon: const Icon(Icons.downloading)),
          ],
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          // fetchPostData(postData);
                          _goToPosts();
                        },
                        child: const Icon(Icons.newspaper),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          _goToPost1();
                        },
                        child: const Icon(Icons.post_add),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          _goToPost1Comments();
                        },
                        child: const Icon(Icons.comment),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          _goToCommentsPost1();
                        },
                        child: const Icon(Icons.mode_comment),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                    width: 100,
                  ),

                  Text(data),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
