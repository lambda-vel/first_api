import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaad_first_api/main.dart';

class CommentsPost1 extends StatefulWidget {
  // final String postData;
  // const Posts({super.key, required this.postData});
  const CommentsPost1({super.key});
/*  fetchData(postData) {
    // TODO: implement fetchData
    throw UnimplementedError();
  }*/

  @override
  State<CommentsPost1> createState() => _CommentsPost1State();
}

class _CommentsPost1State extends State<CommentsPost1> {
  // late String postData = postData;
  var getCommentsPost1 = 'https://jsonplaceholder.typicode.com/comments?postId=1';
  var postCommentsPost1 = 'No Data!';
  var statusCodeCommentsPost1 = 404;
  var data = 'No Data!';

  fetchData() async {
    // print('Button Pressed!');
    http.Response responsePosts = await http.get(Uri.parse(getCommentsPost1));

    setState(() {
      postCommentsPost1 = responsePosts.body;
      // print(data);
      statusCodeCommentsPost1 = responsePosts.statusCode;
      // print('Status Code: $statusCode');
      if (statusCodeCommentsPost1 == 200){
        data = postCommentsPost1;
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
          title: const Text('Comments Post 1'),
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
