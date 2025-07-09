// lib/models/post_model.dart
import 'dart:convert';

// Fungsi helper untuk mengonversi JSON string ke Post object
Post postFromJson(String str) => Post.fromJson(json.decode(str));

// Fungsi helper untuk mengonversi Post object ke JSON string
String postToJson(Post data) => json.encode(data.toJson());

class Post {
  final int? userId; // userID bisa null jika belum diketahui
  final int? id;     // ID biasanya di-generate oleh server, jadi bisa null saat POST
  final String title;
  final String body;

  Post({
    this.userId, // userId opsional saat POST, tapi ada di response
    this.id,     // id opsional saat POST, tapi ada di response
    required this.title,
    required this.body,
  });

  // Factory constructor untuk membuat objek Post dari Map (JSON)
  factory Post.fromJson(Map<String, dynamic> json) => Post(
    userId: json["userId"],
    id: json["id"],
    title: json["title"],
    body: json["body"],
  );

  // Metode untuk mengubah objek Post menjadi Map (untuk dikirim sebagai JSON)
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "id": id, // ID biasanya tidak dikirim saat POST, tapi disertakan di sini jika ada
    "title": title,
    "body": body,
  };
}