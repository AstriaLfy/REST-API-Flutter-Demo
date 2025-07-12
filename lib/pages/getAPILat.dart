import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_rest_api/models/users.dart';
import 'package:http/http.dart' as http;

class getAPIlat extends StatefulWidget {
  const getAPIlat({super.key});

  @override
  State<getAPIlat> createState() => _getAPIlatState();
}

class _getAPIlatState extends State<getAPIlat> {
  List<Result> users = [];


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
          Expanded(
            child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final email = user.email;
                  final name = user.gender;
                  final nat = user.nat;

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: $email', style: const TextStyle(color: Colors.white)),
                        Text('Gender: $name', style: const TextStyle(color: Colors.white)),
                        Text('Nationality: $nat', style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
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
      });
      print("Fetch Success");
    } else {
      print("fetch failed due to API problem: ${response.statusCode}");
    }
  }
}