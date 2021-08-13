
import 'dart:convert';

List<Autogenerated> categoryPostFromJson(String str) => List<Autogenerated>.from(json.decode(str).map((x) => Autogenerated.fromJson(x)));

class Autogenerated {
  late int id;
  late int count;
  late String name;
  late String slug;
  late String taxonomy;

  Autogenerated({
    required this.id,
    required this.count,
    required this.name,
    required this.slug,
    required this.taxonomy,
  });

  Autogenerated.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    count = json['count'];
    name = json['name'];
    slug = json['slug'];
    taxonomy = json['taxonomy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['count'] = this.count;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['taxonomy'] = this.taxonomy;
    return data;
  }
}