import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nepali_utils/nepali_utils.dart';
import 'package:new_design_news_app/database/database.dart';
import 'package:new_design_news_app/model/favourite_data.dart';
import 'package:new_design_news_app/model/news_model.dart';

class DetailPage extends StatefulWidget {
  final News news;

  DetailPage({
    required this.news,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final args = Get.arguments!;
  var icon = Icons.bookmark_add_outlined;
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    return parsedString;
  }

  Future<void> share() async {
    await FlutterShare.share(
      title: widget.news.title.rendered,
      linkUrl: widget.news.link,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          args,
          style: GoogleFonts.mukta(
            textStyle: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    icon = Icons.bookmark_added_outlined;
                    var items = FavouriteData(
                      id: widget.news.id,
                      date: widget.news.date,
                      title: widget.news.title.rendered,
                      description: widget.news.content.rendered,
                      link: widget.news.link,
                      isFavourite: true,
                      image: widget.news.jetpackFeaturedMediaUrl,
                    );

                    insertNews(items);
                    Get.snackbar("", "Added to bookMark Successfully!!!",
                        snackPosition: SnackPosition.BOTTOM);
                  });
                },
                icon: Icon(
                  icon,
                  size: 26.0,
                  color: Colors.black38,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                share();
              },
              child: Icon(
                Icons.share_outlined,
                size: 26.0,
                color: Colors.black38,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [detailImage(), newsDetail()],
          ),
        ),
      ),
    );
  }

  Widget detailImage() {
    return Container(
      child: CachedNetworkImage(
        imageUrl: widget.news.jetpackFeaturedMediaUrl,
        fit: BoxFit.cover,
        height: 250,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Widget newsDetail() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            _parseHtmlString(widget.news.title.rendered),
            style: GoogleFonts.mukta(
              textStyle: TextStyle(
                  fontSize: 22,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          dateAndAuthor(),
          SizedBox(
            height: 15,
          ),
          Text(
            _parseHtmlString(widget.news.content.rendered),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                height: 1.5,
                letterSpacing: 0.5),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget dateAndAuthor() {
    String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    String nepaliDate = NepaliMoment.fromAD(DateTime.parse(widget.news.date),
        referenceDate: DateTime.parse(now));
    return Row(
      children: [
        authorImage(),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Text(
                'नेपाल संसार',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                nepaliDate,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget authorImage() {
    return Container(
      child: Image.asset(
        "assets/images/logo_450.png",
        width: 40,
        height: 40,
      ),
    );
  }
}
