// pages/home.dart
import 'package:flutter/material.dart';
import 'package:learning_rest_api/pages/deleteAPI.dart';
import 'package:learning_rest_api/pages/getAPI.dart';
import 'package:learning_rest_api/pages/postAPI.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rest API")),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          APIButton(
            title: "GET",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const getAPI()));
            },
            color: Colors.blue,
          ),
          APIButton(
            title: "POST",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PostApiPage()));
            },
            color: Colors.green,
          ),
          APIButton(
            title: "DELETE",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const deleteAPI()));
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class APIButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;

  const APIButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}