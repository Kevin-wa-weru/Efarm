import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool accepted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.053333333,
            ),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 60,
                width: 60,
                color: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
            ),
            const Text(
              'About Us',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.77066666,
                      child: const Text(
                        'E-farm application is the platform that will allow farmers to automate agricultural procedures, particularly marketing, such as displaying products, searching for and meeting with clients (vendors and final consumers).The main goal of an app goal is to create a well-organized digital market for agricultural products in East Africa.Chimbo application is the platform created as a smart, sustainable digital solution that offers well-established, accredited, transparent and secure sales process pipelines for the real estate industry. Our custom features and solutions leverage the best out of existing modern technology in support of the buyers’ and sellers’ requirements and needs.',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontSize: 14),
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.033251,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
