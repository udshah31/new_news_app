import 'dart:convert';

List<News> postFromJson(String str) =>
    List<News>.from(json.decode(str).map((x) => News.fromJson(x)));

News postDetailsFromJson(String str) => News.fromJson(jsonDecode(str));

class News {
  late int id;
  late String date;
  late String slug;
  late String link;
  late Guid title;
  late Content content;
  late Content excerpt;
  late int author;
  late String jetpackFeaturedMediaUrl;

  News({
    required this.id,
    required this.date,
    required this.slug,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.jetpackFeaturedMediaUrl,
  });

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    slug = json['slug'];
    link = json['link'];
    title = (json['title'] != null ? new Guid.fromJson(json['title']) : null)!;
    content = (json['content'] != null
        ? new Content.fromJson(json['content'])
        : null)!;
    excerpt = (json['excerpt'] != null
        ? new Content.fromJson(json['excerpt'])
        : null)!;

    author = json['author'];

    jetpackFeaturedMediaUrl = json['jetpack_featured_media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['slug'] = this.slug;
    data['link'] = this.link;

    // ignore: unnecessary_null_comparison
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }

    // ignore: unnecessary_null_comparison
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }

    // ignore: unnecessary_null_comparison
    if (this.excerpt != null) {
      data['excerpt'] = this.excerpt.toJson();
    }
    data['author'] = this.author;
    data['jetpack_featured_media_url'] = this.jetpackFeaturedMediaUrl;

    return data;
  }
}

class Guid {
  late String rendered;

  Guid({required this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

class Content {
  late String rendered;
  late bool protected;

  Content({required this.rendered, required this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    data['protected'] = this.protected;
    return data;
  }
}
