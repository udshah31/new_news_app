class FavouriteData {
  // ignore: non_constant_identifier_names
  static final db_id = "id";
  // ignore: non_constant_identifier_names
  static final db_date = "date";
  // ignore: non_constant_identifier_names
  static final db_title = "title";
  // ignore: non_constant_identifier_names
  static final db_description = "description";
  // ignore: non_constant_identifier_names
  static final db_link = "link";
  // ignore: non_constant_identifier_names
  static final db_isFavourite = "favourite";
  // ignore: non_constant_identifier_names
  static final db_image = "image";

  int id;
  String date, title, description, link, image;
  bool isFavourite;

  FavouriteData({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.link,
    required this.isFavourite,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'description': description,
      'link': link,
      'isFavourite': isFavourite ? 1 : 0,
      'image': image,
    };
  }

  FavouriteData.fromMap(Map<String, dynamic> map)
      : this(
            id: map[db_id],
            date: map[db_date],
            title: map[db_title],
            description: map[db_description],
            link: map[db_link],
            isFavourite: map[db_isFavourite],
            image: map[db_image]);

  @override
  String toString() {
    return 'FavouriteData(date: $date, title: $title, description: $description, link: $link, isFavourite: $isFavourite, image: $image)';
  }
}
