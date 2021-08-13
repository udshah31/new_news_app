import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_design_news_app/controllers/news_controller.dart';
import 'package:new_design_news_app/pages/detail_page.dart';
import 'package:new_design_news_app/widget/item_widget.dart';

class NewsPage extends StatefulWidget {
  late final int categoryId;
  late final bool isReload;
  late final totalRecords;
  late final String title;

  NewsPage(
      {required this.categoryId,
      required this.isReload,
      required this.totalRecords,
      required this.title});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController newsController = Get.put(NewsController());

  ScrollController _scrollController = ScrollController();
  int _page = 1;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      if (this.widget.isReload) {
        await newsController.fetchNews(
            categoryId: this.widget.categoryId,
            pageNumber: 1,
            totalRecords: this.widget.totalRecords);
      }
    });

    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        await newsController.fetchNews(
            pageNumber: ++_page,
            totalRecords: this.widget.totalRecords,
            categoryId: this.widget.categoryId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return newsList();
  }

  Widget newsList() {
    return Container(
      child: Obx(() {
        if (newsController.isLoading.value)
          return Center(
            child: CircularProgressIndicator(),
          );
        else
          return RefreshIndicator(
            key: refreshKey,
            onRefresh: () async {
              await newsController.fetchNews(
                  pageNumber: 1,
                  totalRecords: this.widget.totalRecords,
                  categoryId: this.widget.categoryId);
            },
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: newsController.newsList.length,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  final item = newsController.newsList[index];
                  if ((index == newsController.newsList.length - 1) &&
                      newsController.newsList.length <
                          this.widget.totalRecords) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      Get.to(
                          () => DetailPage(
                                news: item,
                              ),
                          arguments: this.widget.title);
                    },
                    child: ItemWidget(news: item),
                  );
                }),
          );
      }),
    );
  }
}
