import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_design_news_app/controllers/drawer_news_controller.dart';
import 'package:new_design_news_app/widget/item_widget.dart';
import 'detail_page.dart';

class DrawerNews extends StatefulWidget {
  late final String title;
  late final int categoryId;
  late final bool isReload;
  late final totalRecords;

  DrawerNews(
      {required this.title,
      required this.categoryId,
      required this.isReload,
      required this.totalRecords});

  @override
  _DrawerNewsState createState() => _DrawerNewsState();
}

class _DrawerNewsState extends State<DrawerNews> {
  final DrawerNewsController drawerNewsController =
      Get.put(DrawerNewsController());

  ScrollController _scrollController = ScrollController();
  int _page = 1;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (this.widget.isReload) {
        await drawerNewsController.fetchDrawerNews(
            drawerCategoryId: this.widget.categoryId,
            drawerPageNumber: 1,
            drawerTotalRecords: this.widget.totalRecords);
      }
    });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await drawerNewsController.fetchDrawerNews(
            drawerPageNumber: ++_page,
            drawerTotalRecords: this.widget.totalRecords,
            drawerCategoryId: this.widget.categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          this.widget.title,
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
      ),
      body: Container(child: drawerNewsList()),
    );
  }

  Widget drawerNewsList() {
    return Container(
      child: Obx(() {
        if (drawerNewsController.isLoading.value)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return RefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              await drawerNewsController.fetchDrawerNews(
                  drawerPageNumber: 1,
                  drawerTotalRecords: this.widget.totalRecords,
                  drawerCategoryId: this.widget.categoryId);
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: drawerNewsController.drawerNewsList.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                final item = drawerNewsController.drawerNewsList[index];
                if ((index == drawerNewsController.drawerNewsList.length - 1) &&
                    drawerNewsController.drawerNewsList.length <
                        this.widget.totalRecords) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return InkWell(
                  onTap: () {
                    Get.to(
                        DetailPage(
                          news: item,
                        ),
                        arguments: this.widget.title);
                  },
                  child: ItemWidget(news: item),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
