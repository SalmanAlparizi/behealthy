import 'dart:typed_data';

class Recipe {
  final int? id;
  final String title;
  final String steps;
  final String? imageUrl;
  final Uint8List? imageBytes;

  Recipe({
    this.id,
    required this.title,
    required this.steps,
    this.imageUrl,
    this.imageBytes,
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      steps: map['steps'],
      imageUrl: map['imageUrl'],
      imageBytes: map['imageBytes'] != null
          ? Uint8List.fromList(map['imageBytes'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'steps': steps,
      'imageUrl': imageUrl,
      'imageBytes': imageBytes,
    };
  }
}
