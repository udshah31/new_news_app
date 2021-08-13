import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_design_news_app/pages/about_us.dart';
import 'package:new_design_news_app/pages/contact_us.dart';
import 'package:new_design_news_app/pages/favourite_page.dart';
import 'package:new_design_news_app/pages/notification_detail.dart';
import 'package:new_design_news_app/pages/settings.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:new_design_news_app/config.dart';
import 'package:new_design_news_app/controllers/categories_controller.dart';
import 'package:new_design_news_app/pages/news_page.dart';
import 'package:new_design_news_app/widget/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return Container(
      color: Colors.white,
      child: Obx(() {
        if (categoriesController.isLoading.value)
          return Center(
            child: CircularProgressIndicator(),
          );
        return DefaultTabController(
          length: categoriesController.categoriesList.length,
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => FavouritePage());
                    },
                    child: Icon(
                      Icons.bookmark_added_rounded,
                      size: 26.0,
                      color: Colors.black38,
                    ),
                  ),
                ),
                PopupMenuButton(
                    icon: Icon(Icons.more_vert,
                        size: 26.0, color: Colors.black38),
                    onSelected: (item) => onSelected(context, item),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 0,
                            child: Text(
                              "About Us",
                              style: GoogleFonts.mukta(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              )),
                            ),
                          ),
                          PopupMenuItem(
                            value: 1,
                            child: Text("Contact Us",
                                style: GoogleFonts.mukta(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ))),
                          ),
                          PopupMenuItem(
                            value: 2,
                            child: Text("Settings",
                                style: GoogleFonts.mukta(
                                    textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ))),
                          )
                        ]),
              ],
              title: Text(
                "नेपाल संसार",
                style: GoogleFonts.mukta(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              elevation: 0,
              bottom: TabBar(
                tabs: categoriesController.categoriesList
                    .map((cat) => tab(
                          cat.name,
                        ))
                    .toList(),
                indicatorWeight: 2.0,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.black,
                automaticIndicatorColorAdjustment: true,
                labelStyle:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black45,
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                labelColor: Colors.black,
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                children: categoriesController.categoriesList.map((model) {
                  return NewsPage(
                      categoryId: model.id,
                      isReload: true,
                      totalRecords: model.count,
                      title: model.name);
                }).toList(),
              ),
            ),
            drawer: NavigationDrawer(),
          ),
        );
      }),
    );
  }

  Widget tab(String tabName) {
    return Tab(
      child: Text(tabName,
          style: GoogleFonts.mukta(
            textStyle: TextStyle(fontWeight: FontWeight.w500),
          )),
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(Config.oneSignalAppId);
    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      var data = openedResult.notification.additionalData;

      Get.to(() => NotificationDetail(), arguments: data);
    });
  }

  void onSelected(BuildContext context, Object? item) {
    switch (item) {
      case 0:
        Get.to(() => AboutUs());
        break;
      case 1:
        Get.to(() => ContactUs());
        break;
      case 2:
        Get.to(() => Settings());
        break;
    }
  }
}
