import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Contact Us",
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
            "Head Office: Tinkune, Kathmandu \n Branch Office: Janakpur \n Branch Office: Biratnagar \n Phone: +977-9801035905 \n Email: info@journeyfortech.com ",
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
