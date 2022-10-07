import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/login.dart';
import 'package:eshamba/onboarding.dart';
import 'package:eshamba/orders.dart';
import 'package:eshamba/rate.dart';
import 'package:eshamba/screens/shared/about_us.dart';
import 'package:eshamba/services/country_code.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/settings.dart' as settingss;
import 'package:eshamba/update_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? countryName = '';
  String? countryCode = '';

  late String email;
  late String password;
  late String name;

  Future<String> getCountry() async {
    Network n = Network("http://ip-api.com/json");
    var locationSTR = (await n.getData());
    var locationx = jsonDecode(locationSTR);

    List<Country> country = countryList
        .where((element) => element.name == locationx["country"])
        .toList();
    setState(() {
      countryName = locationx["country"];
      countryCode = '+${country.first.phoneCode}';
    });
    debugPrint('COUNTRYYYYY:::::::::::::: $countryCode');
    return locationx["country"];
  }

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Transform.translate(
              offset: const Offset(0.0, -50.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.50123152,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50.0),
                          ),
                          color: Color(0xFF39B54A),
                        ),
                      ),
                      Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.25738916,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(100.0),
                                  ),
                                  color: Colors.red,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(200.0),
                                      ),
                                      child: Image.asset(
                                          'assets/images/veges.jpg')),
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0615763,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.052566502,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09866666,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                                topLeft: Radius.circular(10.0),
                                              ),
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.0172413793,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01866666,
                                                  child: const Icon(
                                                    Icons.arrow_back_ios,
                                                    size: 15,
                                                  )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateProfile(
                                                          email: email,
                                                          name: name,
                                                          password: password,
                                                        )));
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.052566502,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09866666,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10.0),
                                                topRight: Radius.circular(10.0),
                                                bottomLeft:
                                                    Radius.circular(10.0),
                                                topLeft: Radius.circular(10.0),
                                              ),
                                              color: Color(0xFFFFFFFF),
                                            ),
                                            child: Center(
                                              child: SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.0472413793,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04866666,
                                                child: SvgPicture.asset(
                                                    'assets/icons/edit.svg',
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where('userid',
                                      isEqualTo:
                                          AuthenticationHelper().userid.trim())
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  email = snapshot.data.docs.first['email'];
                                  password =
                                      snapshot.data.docs.first['password'];
                                  name = snapshot.data.docs.first['name'];

                                  return Column(
                                    children: [
                                      Transform.translate(
                                        offset: const Offset(0.0, -100.0),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                            color: Color(0x33D0D0D6),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              final picker = ImagePicker();
                                              var pickedImage =
                                                  await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery);

                                              if (pickedImage == null) {
                                              } else {
                                                var tempImage =
                                                    File(pickedImage.path);

                                                FirebaseStorage
                                                    firebaseStorage =
                                                    FirebaseStorage.instance;

                                                var response = await firebaseStorage
                                                    .ref('usersAvatar')
                                                    .child(
                                                        '${DateTime.now().microsecond.toString()}${DateTime.now().second.toString()}')
                                                    .putFile(tempImage);

                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(AuthenticationHelper()
                                                        .userid
                                                        .trim());

                                                await docRef.update({
                                                  'avatarUrl': await response
                                                      .ref
                                                      .getDownloadURL()
                                                });

                                                // ignore: use_build_context_synchronously
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                      content: Text(
                                                    "Updated profile picture",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                        fontFamily:
                                                            'PublicSans',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  )),
                                                );
                                              }
                                            },
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: snapshot.data.docs
                                                                  .first[
                                                              'avatarUrl'] !=
                                                          ''
                                                      ? CircleAvatar(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xFFF4F4F4),
                                                          radius: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.20,
                                                          backgroundImage:
                                                              NetworkImage(snapshot
                                                                      .data
                                                                      .docs
                                                                      .first[
                                                                  'avatarUrl']),
                                                        )
                                                      : Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.207142,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.40733333,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2500),
                                                            color: const Color(
                                                                0xFFF4F4F4),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10.0),
                                                            child: Center(
                                                              child: SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.050480295,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.280266666,
                                                                child: SvgPicture.asset(
                                                                    'assets/icons/picture.svg',
                                                                    color: Colors
                                                                        .black12,
                                                                    fit: BoxFit
                                                                        .contain),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ),
                                                Transform.translate(
                                                  offset: const Offset(
                                                      150.0, 130.0),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.054566502,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10966666,
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(
                                                                100.0),
                                                        topRight:
                                                            Radius.circular(
                                                                100.0),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                100.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                100.0),
                                                      ),
                                                      color: Color(0xFF171433),
                                                    ),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.0472413793,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04866666,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/camera.svg',
                                                            fit:
                                                                BoxFit.contain),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0.0, -80.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              snapshot.data.docs.first['name'],
                                              style: const TextStyle(
                                                  color: Color(0xFFFFFFFF),
                                                  fontFamily: 'PublicSans',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                countryName!,
                                                style: const TextStyle(
                                                    color: Color(0xFFFFFFFF),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              })
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile(
                                        email: email,
                                        name: name,
                                        password: password,
                                      )));
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.06773399,
                          width:
                              MediaQuery.of(context).size.width * 0.893333333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.0657142,
                                width: MediaQuery.of(context).size.width *
                                    0.11733333,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020480295,
                                    width: MediaQuery.of(context).size.width *
                                        0.0380266666,
                                    child: SvgPicture.asset(
                                        'assets/icons/user.svg',
                                        color: const Color(0xFF39B54A),
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'My Profile',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01970443,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Orders(
                                        showbackArrow: true,
                                      )));
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.06773399,
                          width:
                              MediaQuery.of(context).size.width * 0.893333333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.0657142,
                                width: MediaQuery.of(context).size.width *
                                    0.11733333,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.transparent),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020480295,
                                    width: MediaQuery.of(context).size.width *
                                        0.0380266666,
                                    child: SvgPicture.asset(
                                        'assets/icons/order.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'My Order',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01970443,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => settingss.Settings(
                                        email: email,
                                        name: name,
                                        password: password,
                                      )));
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.06773399,
                          width:
                              MediaQuery.of(context).size.width * 0.893333333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.0657142,
                                width: MediaQuery.of(context).size.width *
                                    0.11733333,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.transparent),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020480295,
                                    width: MediaQuery.of(context).size.width *
                                        0.0380266666,
                                    child: SvgPicture.asset(
                                        'assets/icons/settings.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Settings',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01970443,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RatingScreen()));
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.06773399,
                          width:
                              MediaQuery.of(context).size.width * 0.893333333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.0657142,
                                width: MediaQuery.of(context).size.width *
                                    0.11733333,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020480295,
                                    width: MediaQuery.of(context).size.width *
                                        0.0380266666,
                                    child: SvgPicture.asset(
                                        'assets/icons/star.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Rate Us',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01970443,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutUs()));
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.06773399,
                          width:
                              MediaQuery.of(context).size.width * 0.893333333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height *
                                    0.0657142,
                                width: MediaQuery.of(context).size.width *
                                    0.11733333,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020480295,
                                    width: MediaQuery.of(context).size.width *
                                        0.0380266666,
                                    child: SvgPicture.asset(
                                        color: const Color(0xFF39B54A),
                                        'assets/icons/info.svg',
                                        fit: BoxFit.contain),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'About Us',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06945812,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Onboarding()));
                                AuthenticationHelper().signOut();
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.05541871,
                                width: MediaQuery.of(context).size.width *
                                    0.370666666,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: const Color(0xFFFF7070),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0657142,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.11733333,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: const Color(0xFFFF7070),
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.020480295,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.0380266666,
                                            child: SvgPicture.asset(
                                                'assets/icons/logout.svg',
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 0.0),
                                      child: Text(
                                        'Logout',
                                        style: TextStyle(
                                            color: Color(0xFFFFFFFF),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06945812,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
