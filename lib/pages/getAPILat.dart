import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_rest_api/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:learning_rest_api/pages/userDetail.dart';

class getAPIlat extends StatefulWidget {
  const getAPIlat({super.key});

  @override
  State<getAPIlat> createState() => _getAPIlatState();
}

class _getAPIlatState extends State<getAPIlat> {
  List<Result> users = [];
  Info? apiInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test API")),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchAPI,
        child: const Text("+", style: TextStyle(fontSize: 36)),
      ),
      body: Column(
        children: [
          if (users.isEmpty)
            Text("Press + to Start"),
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final email = user.email;
                  final gender = user.gender;
                  final nat = user.nat;
                  final imgProfile = user.picture.medium;
                  final name = user.name.first + " " + user.name.last;


                  return
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => detailUser(userId : name)));
                      },
                    child:
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.network(imgProfile),
                          ),
                          Text('${user.name.title} ${user.name.first} ${user.name.last}'),
                          Text('Email: $email', style: const TextStyle(color: Colors.white)),
                          Text('Gender: $gender', style: const TextStyle(color: Colors.white)),
                          Text('Nationality: $nat', style: const TextStyle(color: Colors.white)),
                          if (apiInfo?.seed != null)
                            Text(apiInfo!.seed), //sebaiknya dijadikan final variabel, untuk clean code
                          Text(apiInfo!.page.toString()),
                        ],
                      ),
                    )
                      ,)
             ;
                }),
          ),
        ],
      ),
    );
  }

  fetchAPI() async {
    print("Fetch Starts");
    final url = 'https://randomuser.me/api/?results=10';
    final link = Uri.parse(url);
    final response = await http.get(link);
    final hasil = response.body;
    final Product prodak = productFromJson(hasil);

    if (response.statusCode == 200) {
      setState(() {
        users = prodak.results;
        apiInfo = prodak.info;
      });
      print("Fetch Success");
    } else {
      print("fetch failed due to API problem: ${response.statusCode}");
    }
  }
}