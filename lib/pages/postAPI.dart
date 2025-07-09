import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Untuk jsonEncode dan jsonDecode
import '../models/post_model.dart'; // Import model Post kita

class PostApiPage extends StatefulWidget {
  const PostApiPage({super.key});

  @override
  State<PostApiPage> createState() => _PostApiPageState();
}

class _PostApiPageState extends State<PostApiPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool _isLoading = false;
  String _responseMessage = ''; // Untuk menampilkan pesan respons

  // Fungsi untuk mengirim POST request
  Future<void> _createPost() async {
    setState(() {
      _isLoading = true; // Mulai loading
      _responseMessage = 'Mengirim data...';
    });

    final String title = _titleController.text;
    final String body = _bodyController.text;

    // Pastikan input tidak kosong
    if (title.isEmpty || body.isEmpty) {
      setState(() {
        _isLoading = false;
        _responseMessage = 'Judul dan isi tidak boleh kosong!';
      });
      return;
    }

    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts'); // Endpoint POST

    // Siapkan data yang akan dikirim dalam bentuk objek Post
    final newPost = Post(title: title, body: body, userId: 1); // userId bisa fixed untuk contoh

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', // Header penting: beritahu server kita kirim JSON
        },
        body: postToJson(newPost), // Ubah objek Post menjadi JSON string
      );

      if (response.statusCode == 201) { // Kode 201 Created menunjukkan POST sukses
        final createdPost = postFromJson(response.body); // Dekode respons ke objek Post
        setState(() {
          _responseMessage = 'Post berhasil dibuat! ID: ${createdPost.id}, Title: ${createdPost.title}';
          _titleController.clear(); // Bersihkan input
          _bodyController.clear();
        });
        print('Post berhasil dibuat: ${response.body}');
      } else {
        // Jika ada error dari server
        setState(() {
          _responseMessage = 'Gagal membuat post: ${response.statusCode} - ${response.body}';
        });
        print('Error saat membuat post: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Error jaringan atau error lain
      setState(() {
        _responseMessage = 'Terjadi error: $e';
      });
      print('Exception saat membuat post: $e');
    } finally {
      setState(() {
        _isLoading = false; // Akhiri loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POST API Demo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Post',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi Post',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator()) // Tampilkan loading
                : ElevatedButton(
              onPressed: _createPost,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white
              ),
              child: const Text('Create Post', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 20),
            Text(
              _responseMessage,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _responseMessage.startsWith('Gagal') || _responseMessage.startsWith('Terjadi error')
                    ? Colors.red
                    : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}