import 'package:flutter/material.dart';

class detailUser extends StatefulWidget {
  final userId;
  const detailUser({super.key, required this.userId});

  @override
  State<detailUser> createState() => _detailUserState();
}

class _detailUserState extends State<detailUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail User ID: ${widget.userId}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User ID yang diterima:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              widget.userId.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}