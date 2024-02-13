import 'package:cloud_firestore/cloud_firestore.dart';

class RoomModel {
  String id;
  String name;
  List utilities;
  int capacity;
  String thumbnail;
  List<String>? images;
  // DateTime? dateTime;

  RoomModel({
    required this.id,
    required this.name,
    required this.capacity,
    required this.thumbnail,
    required this.images,
    required this.utilities,
    // this.dateTime,
  });

  /// Create Empty func for clean code
  static RoomModel empty() => RoomModel(
      id: '', name: '', capacity: 0, thumbnail: '', images: [], utilities: []);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
      'thumbnail': thumbnail,
      'images': images,
      'utilities': utilities
    };
  }

  factory RoomModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data() ?? {}; // Handle null data

    return RoomModel(
      id: document.id,
      name: data['name'] as String? ??
          '', // Ensure the keys match your Firebase keys
      capacity: data['capacity'] as int? ?? 0,
      thumbnail: data['thumbnail'] as String? ?? '',
      images: List<String>.from(data['images'] as List? ?? []),
      utilities: List<String>.from(data['utilities'] as List? ?? []),
    );
  }
}
