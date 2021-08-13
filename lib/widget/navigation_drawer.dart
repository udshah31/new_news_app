import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_design_news_app/controllers/categories_controller.dart';
import 'package:new_design_news_app/pages/drawer_page.dart';
import 'package:new_design_news_app/pages/home_page.dart';

class NavigationDrawer extends StatelessWidget {

  final CategoriesController categoriesController =
      Get.put(CategoriesController());

      

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10.0,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Image.asset(
                          "assets/images/logo_450.png",
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "नेपाल संसार",
                        style: GoogleFonts.mukta(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.black54,
              ),
              title: Text(
                "गृह पृष्ठ",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => HomePage());
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                CupertinoIcons.news_solid,
                color: Colors.black54,
              ),
              title: Text(
                "समाचार",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                print('drawer $categoriesController.categoriesList.length');
                Get.to(() => DrawerNews(
                      title: 'समाचार',
                      categoryId: 1,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.account_balance,
                color: Colors.black54,
              ),
              title: Text(
                "राजनीति",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'राजनीति',
                      categoryId: 3,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                CupertinoIcons.globe,
                color: Colors.black54,
              ),
              title: Text(
                "अन्तराष्ट्रिय",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'अन्तराष्ट्रिय',
                      categoryId: 9,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.money,
                color: Colors.black54,
              ),
              title: Text(
                "अर्थ",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'अर्थ',
                      categoryId: 10,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.campaign,
                color: Colors.black54,
              ),
              title: Text(
                "प्रवास",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'प्रवास',
                      categoryId: 18,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.sports_football,
                color: Colors.black54,
              ),
              title: Text(
                "खेलकुद",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'खेलकुद',
                      categoryId: 4,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                CupertinoIcons.film,
                color: Colors.black54,
              ),
              title: Text(
                "मनोरञ्जन",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'मनोरञ्जन',
                      categoryId: 11,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.biotech,
                color: Colors.black54,
              ),
              title: Text(
                "सूचना प्रबिधि",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'सूचना प्रबिधि',
                      categoryId: 11,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.health_and_safety,
                color: Colors.black54,
              ),
              title: Text(
                "यौन/स्वास्थ्य",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'यौन/स्वास्थ्य',
                      categoryId: 5,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.article,
                color: Colors.black54,
              ),
              title: Text(
                "पत्रपत्रिकाबाट",
                style: GoogleFonts.mukta(
                    textStyle: TextStyle(
                        color: Colors.black54,
                        fontSize: 20,
                        fontWeight: FontWeight.w500)),
              ),
              onTap: () {
                Get.to(() => DrawerNews(
                      title: 'पत्रपत्रिकाबाट',
                      categoryId: 20,
                      isReload: true,
                      totalRecords: categoriesController.categoriesList.length
                    ));
              },
            ),
            ListTile(
              horizontalTitleGap: 0.0,
              leading: Icon(
                Icons.coronavirus,
                color: Colors.black54,
              ),
              title: Text(
                "कोरोना भाइरस",
                style: GoogleFonts.mukta(
                  textStyle: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              onTap: () {
                Get.to(
                  () => DrawerNews(
                    title: 'कोरोना भाइरस',
                    categoryId: 317,
                    isReload: true,
                    totalRecords: categoriesController.categoriesList.length
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
