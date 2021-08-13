import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:new_design_news_app/model/news_model.dart';

class ItemWidget extends StatelessWidget {
  final News news;
  ItemWidget({required this.news});

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    String nepaliDate = NepaliMoment.fromAD(DateTime.parse(news.date),
        referenceDate: DateTime.parse(now));
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          image(),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _parseHtmlString(news.title.rendered),
                    style: GoogleFonts.mukta(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    _parseHtmlString(news.excerpt.rendered),
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    nepaliDate,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget image() {
    return CachedNetworkImage(
      imageUrl: news.jetpackFeaturedMediaUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: 110,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
