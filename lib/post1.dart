import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/main.dart';

class Post1 extends StatefulWidget {
  // final String postData;
  // const Posts({super.key, required this.postData});
  const Post1({super.key});
/*  fetchData(postData) {
    // TODO: implement fetchData
    throw UnimplementedError();
  }*/

  @override
  State<Post1> createState() => _PostsState();
}

class _PostsState extends State<Post1> {
  // late String postData = postData;
  var getPost1 = 'https://jsonplaceholder.typicode.com/posts/1';
  var post1Data = 'No Data!';
  var statusCodePost1 = 404;
  var data = 'No Data!';
  bool isLoading = true;

/*  fetchData() async {
    // print('Button Pressed!');
    http.Response responsePosts = await http.get(Uri.parse(getPost1));

    setState(() {
      post1Data = responsePosts.body;
      // print(data);
      statusCodePost1 = responsePosts.statusCode;
      // print('Status Code: $statusCode');
      if (statusCodePost1 == 200){
        data = post1Data;
      } else {
        data = 'Data Not Found';
      }

      // List <Map<String,dynamic>> postData = json.decode(response.body);

    });
  }*/

  void getData() async{
    http.Response response = await http.get(Uri.parse(getPost1));
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
          title: const Text('Post 1'),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*Text(
                                '${jsonDecode(data)['id']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),*/

                              Text(
                                'User ID: ${jsonDecode(data)['userId']}',
                              ),

                              Text(
                                '${jsonDecode(data)['title']}',
                                  style: const TextStyle(color: Colors.blue),
                              ),

                              Text(
                                '${jsonDecode(data)['body']}',
                              ),
                              ],
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
