import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/main.dart';

class Posts extends StatefulWidget {
  // final String postData;
  // const Posts({super.key, required this.postData});
  const Posts({super.key});
/*  fetchData(postData) {
    // TODO: implement fetchData
    throw UnimplementedError();
  }*/

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  // late String postData = postData;
  var getPosts = 'https://jsonplaceholder.typicode.com/posts';
  var postData = 'No Data!';
  var statusCodePosts = 404;
  var data = 'No Data!';

  fetchData() async {
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

      // List <Map<String,dynamic>> postData = json.decode(response.body);

    });
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
