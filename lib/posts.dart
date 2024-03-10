import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/main.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // late String postData = postData;
  var getPostsUrl = 'https://jsonplaceholder.typicode.com/posts';
  var postData = 'No Data!';
  var statusCodePosts = 404;
  var data = 'No Data!';
  bool isLoading = true;

/*  fetchData() async {
    // print('Button Pressed!');
    http.Response responsePosts = await http.get(Uri.parse(getPosts));

    setState(() {
      postData = responsePosts.body;
      // print(data);
      statusCodePosts = responsePosts.statusCode;
      // print('Status Code: $statusCode');
      if (statusCodePosts == 200){
        data = postData;
      } else {
        data = 'Data Not Found';
      }
    });
  }*/

  void getData() async{
    http.Response response = await http.get(Uri.parse(getPostsUrl));
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
          title: const Text('Posts'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          titleTextStyle: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
          /*actions:[
            IconButton(
              onPressed: (){
                // fetchData();
              },
              icon: const Icon(Icons.download),
            ),
          ],*/
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
              child: Column(
                children: [
                  // Text(data),
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
                                '${jsonDecode(data)[index]['title']}',
                                style: const TextStyle(color: Colors.blue),
                              ),
                              subtitle: Text(
                                '${jsonDecode(data)[index]['body']}',
                              ),
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
