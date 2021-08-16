class FavouriteData {
  late final int fid;
  late final String fdate;
  late final String ftitle;
  late final String fdescription;
  late final String flink;
  late final String fimage;
  late final bool fisFavourite;

  FavouriteData({
    required this.fid,
    required this.fdate,
    required this.ftitle,
    required this.fdescription,
    required this.flink,
    required this.fisFavourite,
    required this.fimage,
  });

  int get id => fid;
  String get date => fdate;
  String get title => ftitle;
  String get description => fdescription;
  String get link => flink;
  String get image => fimage;
  bool get isFavorite => fisFavourite;

  Map<String, dynamic> toMap() {
    return {
      'id': fid,
      'date': fdate,
      'title': ftitle,
      'description': fdescription,
      'link': flink,
      'image': fimage,
      'isfavourite': fisFavourite ? 1 : 0
    };
  }

  FavouriteData.fromMap(Map<String, dynamic> map)
      : this(
            fid: map['id'],
            fdate: map['date'],
            ftitle: map['title'],
            fdescription: map['description'],
            flink: map['link'],
            fisFavourite: map['isFavourite'] == 1,
            fimage: map['image']);

  set favourite(bool choice) {
    this.fisFavourite = choice;
  }
}
