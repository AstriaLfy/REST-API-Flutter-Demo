import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getAPI extends StatefulWidget {
  const getAPI({super.key});

  @override
  State<getAPI> createState() => _getAPIState();
}

class _getAPIState extends State<getAPI> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Get API", style: TextStyle(color: Colors.white),), backgroundColor: Colors.blue,),
      floatingActionButton: FloatingActionButton(onPressed: FetchUser, child: Text("+", style: TextStyle(fontSize: 36),),),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context,index){
            final user = users[index];
            final email = user['email'];
            final name = user['name']['first'];
            final imageUrl = user['picture']['thumbnail'];
        return ListTile(
          leading: ClipRRect(borderRadius: BorderRadius.circular(100), child: Image.network(imageUrl)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(email),
              Text(name.toString()),
            ],
          ),
        );
      }),
    );
  }

  void FetchUser() async {
    print("Fetch User");
    final url = 'https://randomuser.me/api/?results=10';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
    });
    print("Fetch Complete");
  }
}
