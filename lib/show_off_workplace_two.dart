import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/models/data.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/vendorpage.dart';
import 'package:flutter/material.dart';

class ShowWorkPlaceTwo extends StatefulWidget {
  const ShowWorkPlaceTwo({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  State<ShowWorkPlaceTwo> createState() => _ShowWorkPlaceTwoState();
}

class _ShowWorkPlaceTwoState extends State<ShowWorkPlaceTwo> {
  final productNameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();

  bool appisLoaading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (productNameController.text.isEmpty ||
              categoryController.text.isEmpty ||
              priceController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                "Complete Filling The Form",
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              )),
            );
          } else {
            setState(() {
              appisLoaading = true;
            });

            final userRef = await FirebaseFirestore.instance
                .collection("users")
                .doc(AuthenticationHelper().userid.trim())
                .get();

            final userRef2 = FirebaseFirestore.instance
                .collection("users")
                .doc(AuthenticationHelper().userid.trim());

            var avatar = userRef.data()!['avatarUrl'];
            var name = userRef.data()!['name'];

            FirebaseFirestore.instance.collection("products").add({
              'category': categoryController.text,
              'imageURl': widget.image,
              'postedByAvatarUrl': avatar,
              'postedByName': name,
              'postedByUserId': AuthenticationHelper().userid.trim(),
              'productName': productNameController.text,
              'productPrice': priceController.text.toString()
            });

            userRef2.update({
              'workPlace': {
                'name': productNameController.text,
                'image': widget.image,
              }
            });

            setState(() {
              appisLoaading = false;
            });
            // ignore: use_build_context_synchronously
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Vendorprofile()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20, bottom: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.0615763,
            width: MediaQuery.of(context).size.width * 0.8933333,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient:
                    const LinearGradient(begin: Alignment.topCenter, colors: [
                  Color(0xFF7CD956),
                  Color(0xFF3EA334),
                ])),
            child: appisLoaading == true
                ? const Center(
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
          ),
        ),
      ),
      body: ListView(
        children: [
          const Center(
            child: Text(
              'product details',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontFamily: 'PublicSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 24),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0911330049,
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'product details',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6911330049,
                  color: Colors.transparent,
                  child: const Text(
                    'You’ll be able to add a description and adjust advanced settings',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.023251,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8933333,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                      horizontal: 20,
                    ),
                    filled: true,
                    hintText: 'Product name',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: productNameController),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8933333,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                      horizontal: 20,
                    ),
                    filled: true,
                    hintText: 'Category',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: categoryController),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8933333,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextFormField(
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(33),
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF39B54A), width: 1),
                      borderRadius: BorderRadius.circular(33),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                      horizontal: 20,
                    ),
                    filled: true,
                    hintText: 'Price -\$',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                  controller: priceController),
            ),
          ),
        ],
      ),
    );
  }
}
