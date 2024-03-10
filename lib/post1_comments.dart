import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/main.dart';

class Post1Comments extends StatefulWidget {
  const Post1Comments({super.key});

  @override
  State<Post1Comments> createState() => _Post1CommentsState();
}

class _Post1CommentsState extends State<Post1Comments> {
  // late String postData = postData;
  var getPost1Comments = 'https://jsonplaceholder.typicode.com/posts/1/comments';
  var post1CommentData = 'No Data!';
  var statusCodePost1Comments = 404;
  var data = 'No Data!';
  bool isLoading = true;

/*  fetchData() async {
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
  }*/

  void getData() async{
    http.Response response = await http.get(Uri.parse(getPost1Comments));
    setState(() {
      data = response.body;
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    getData();
    // print(data.runtimeType);
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
                  isLoading
                      ? const CircularProgressIndicator()
                      : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: jsonDecode(data).length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            child: Text(
                              '${jsonDecode(data)[index]['id']}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            '${jsonDecode(data)[index]['name']}',
                            style: const TextStyle(color: Colors.blue),
                          ),
                          subtitle: Text(
                            '${jsonDecode(data)[index]['email']}',
                          ),

                          /*Text(
                            '${jsonDecode(data)[index]['body']}',
                          ),*/
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
