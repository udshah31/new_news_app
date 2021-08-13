import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_design_news_app/database/database.dart';
import 'package:new_design_news_app/widget/favourite_item_widget.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Bookmark News",
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
            child: GestureDetector(
              onTap: () {
                setState(() {
                  clearTable();
                  Get.snackbar("Are You Sure!!!", "Removed Successfully!!!",
                      snackPosition: SnackPosition.BOTTOM);
                });
              },
              child: Icon(
                Icons.delete_forever,
                size: 26.0,
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: allFavouriteNews(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final news = snapshot.data[index];
                    return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            deleteFavourite(news.id);
                            Get.snackbar(
                                "", "Book Mark Removed Successfully!!!",
                                snackPosition: SnackPosition.BOTTOM);
                          });
                        },
                        child: FavouriteItemWidget(news: news));
                  }),
            );
          }
        },
      ),
    );
  }
}
