import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "About Us",
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
      body: Container(
        child: Center(
          child: Text(
            "Journey For Tech is a professional web designing and web solution company in Kathmandu Nepal. Our creative website designers give your website innovative, impressive and eye-catching design which gives your website an outstanding and presentable position among your competitors. We are a passionate, results-oriented team based in Nepal . We deliver end-to-end website design, development solutions that are focused on client goals and objectives.",
            style: GoogleFonts.mukta(
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
