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
}
