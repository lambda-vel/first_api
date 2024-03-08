import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/main.dart';

class Post1Comments extends StatefulWidget {
  // final String postData;
  // const Posts({super.key, required this.postData});
  const Post1Comments({super.key});
/*  fetchData(postData) {
    // TODO: implement fetchData
    throw UnimplementedError();
  }*/

  @override
  State<Post1Comments> createState() => _Post1CommentsState();
}

class _Post1CommentsState extends State<Post1Comments> {
  // late String postData = postData;
  var getPost1Comments = 'https://jsonplaceholder.typicode.com/posts/1/comments';
  var post1CommentData = 'No Data!';
  var statusCodePost1Comments = 404;
  var data = 'No Data!';

  fetchData() async {
    // print('Button Pressed!');
    http.Response responsePosts = await http.get(Uri.parse(getPost1Comments));

    setState(() {
      post1CommentData = responsePosts.body;
      // print(data);
      statusCodePost1Comments = responsePosts.statusCode;
      // print('Status Code: $statusCode');
      if (statusCodePost1Comments == 200){
        data = post1CommentData;
      } else {
        data = 'Data Not Found';
      }

      // List <Map<String,dynamic>> postData = json.decode(response.body);

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Post 1 Comments'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          titleTextStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          actions:[
            IconButton(
              onPressed: (){
                fetchData();
              },
              icon: const Icon(Icons.download),
            ),
          ],
          leading: BackButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const FirstAPI()));
            },
          ),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
            color: Colors.black12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              // child: Text(postData),
              child: Column(
                children: [
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
