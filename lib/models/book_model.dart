class Book {
  int? id;
  String authorName;
  String bookName;
  String imageUrl;

  Book(
      {this.id,
      required this.authorName,
      required this.bookName,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'authorName': authorName,
      'bookName': bookName,
      'imageUrl': imageUrl,
    };
  }

  Book.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        authorName = map['authorName'],
        bookName = map['bookName'],
        imageUrl = map['imageUrl'] ?? '';
}
