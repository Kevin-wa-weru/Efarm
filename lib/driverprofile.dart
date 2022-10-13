import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/login.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/update_driver_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  bool istoggled = false;

  late String user = '';

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? stringValue = prefs.getString('stringValue');
    print(stringValue);

    setState(() {});
    user = stringValue!;
  }

  @override
  void initState() {
    getUserType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('userid',
                      isEqualTo: AuthenticationHelper().userid.trim())
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                } else {
                  return ListView(children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.006251231,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.248,
                        ),
                        const Text(
                          'Profile',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 24),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.170,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login(
                                          usertype: user,
                                        )));
                            AuthenticationHelper().signOut();
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                color: Color(0xFFFF7070),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.032251231,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.102251231,
                          ),
                          InkWell(
                            onTap: () async {
                              final picker = ImagePicker();
                              var pickedImage = await picker.pickImage(
                                  source: ImageSource.gallery);

                              if (pickedImage == null) {
                              } else {
                                var tempImage = File(pickedImage.path);

                                FirebaseStorage firebaseStorage =
                                    FirebaseStorage.instance;

                                var response = await firebaseStorage
                                    .ref('usersAvatar')
                                    .child(
                                        '${DateTime.now().microsecond.toString()}${DateTime.now().second.toString()}')
                                    .putFile(tempImage);

                                final docRef = FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(AuthenticationHelper().userid.trim());

                                await docRef.update({
                                  'avatarUrl':
                                      await response.ref.getDownloadURL()
                                });

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                    "Updated profile picture",
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  )),
                                );
                              }
                            },
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: MediaQuery.of(context).size.width *
                                          0.43,
                                      child: snapshot.data.docs
                                                  .first['avatarUrl'] ==
                                              ''
                                          ? Center(
                                              child: Container(
                                                height: 110,
                                                width: 110,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                  color:
                                                      const Color(0xFFE8E8E8),
                                                ),
                                                child: Center(
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.0147783251,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                    child: SvgPicture.asset(
                                                        'assets/icons/user.svg',
                                                        color: Colors.black12,
                                                        fit: BoxFit.contain),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : CircleAvatar(
                                              backgroundColor:
                                                  const Color(0xFFF0F0F0),
                                              radius: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.13,
                                              backgroundImage: NetworkImage(
                                                  snapshot.data.docs
                                                      .first['avatarUrl']),
                                            ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        color: Colors.transparent,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.43,
                                        child: Text(
                                          snapshot.data.docs.first['name'],
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Color(0xFF000000),
                                              fontFamily: 'PublicSans',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Transform.translate(
                                  offset: const Offset(100.0, 70.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.044566502,
                                    width: MediaQuery.of(context).size.width *
                                        0.08966666,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(100.0),
                                        topRight: Radius.circular(100.0),
                                        bottomLeft: Radius.circular(100.0),
                                        topLeft: Radius.circular(100.0),
                                      ),
                                      color: Color(0xFF39B54A),
                                    ),
                                    child: Center(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0372413793,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03866666,
                                        child: SvgPicture.asset(
                                            'assets/icons/editer.svg',
                                            color: Colors.white,
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(0.0, -10.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    snapshot.data.docs.first['name'],
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Color(0xFF39B54A),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: SizedBox(
                                    width: 150,
                                    child: Text(
                                      'Active Status',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'PublicSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    color: Colors.transparent,
                                    width: 150,
                                    child: Transform.translate(
                                      offset: const Offset(-15.0, 0.0),
                                      child: Row(
                                        children: [
                                          Transform.scale(
                                            scale: 0.8,
                                            child: CupertinoSwitch(
                                              onChanged: (value) async {
                                                final docRef = FirebaseFirestore
                                                    .instance
                                                    .collection("users")
                                                    .doc(AuthenticationHelper()
                                                        .userid
                                                        .trim());

                                                await docRef.update(
                                                    {'activeStatus': value});
                                              },
                                              value: snapshot.data.docs
                                                  .first['activeStatus'],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              snapshot.data.docs.first[
                                                          'activeStatus'] ==
                                                      false
                                                  ? 'Closed'
                                                  : 'Open',
                                              style: const TextStyle(
                                                  color: Color(0xFF39B54A),
                                                  fontFamily: 'PublicSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.032251231,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateDriverProfile(
                                      email: snapshot.data.docs.first['email'],
                                      location: snapshot
                                          .data.docs.first['addressLocation'],
                                      name: snapshot.data.docs.first['name'],
                                      phone: snapshot.data.docs.first['phone'],
                                      password:
                                          snapshot.data.docs.first['password'],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0591133,
                          width: MediaQuery.of(context).size.width * 0.904,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.704,
                                color: Colors.transparent,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Text(
                                    snapshot.data.docs.first['addressLocation'],
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.black87,
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012251231,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateDriverProfile(
                                      email: snapshot.data.docs.first['email'],
                                      location: snapshot
                                          .data.docs.first['addressLocation'],
                                      name: snapshot.data.docs.first['name'],
                                      phone: snapshot.data.docs.first['phone'],
                                      password:
                                          snapshot.data.docs.first['password'],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0591133,
                          width: MediaQuery.of(context).size.width * 0.904,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Text(
                                  snapshot.data.docs.first['phone'] == ''
                                      ? 'Phone number not available'
                                      : snapshot.data.docs.first['phone'],
                                  style: const TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.012251231,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateDriverProfile(
                                      email: snapshot.data.docs.first['email'],
                                      location: snapshot
                                          .data.docs.first['addressLocation'],
                                      name: snapshot.data.docs.first['name'],
                                      phone: snapshot.data.docs.first['phone'],
                                      password:
                                          snapshot.data.docs.first['password'],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0591133,
                          width: MediaQuery.of(context).size.width * 0.904,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: const Color(0xFFF4F4F4),
                          ),
                          child: Row(
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(left: 40.0),
                                child: Text(
                                  '****************',
                                  style: TextStyle(
                                      color: Colors.black87,
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 45, top: 13, bottom: 10),
                      child: SizedBox(
                        child: Text(
                          "Earnings",
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8, left: 40),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.165961,
                                width:
                                    MediaQuery.of(context).size.width * 0.388,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.transparent,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 10.0),
                                          child: Row(
                                            children: const [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 4.0),
                                                child: Text(
                                                  'Earning',
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontFamily: 'PublicSans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7.0, left: 10.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0),
                                                child: Text(
                                                  '${snapshot.data.docs.first['earnings']} kd',
                                                  style: const TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontFamily: 'PublicSans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 13),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 3.0, left: 10.0),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 15.0, bottom: 5),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0772413793,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08866666,
                                          child: SvgPicture.asset(
                                              'assets/icons/earnings.svg',
                                              color: const Color(0xFF39B54A),
                                              fit: BoxFit.contain),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.165961,
                              width: MediaQuery.of(context).size.width * 0.388,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                'Weekly earnings',
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 7.0, left: 10.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                '${snapshot.data.docs.first['weeklyEarnings']} kd',
                                                style: const TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 3.0, left: 10.0),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, bottom: 5),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0772413793,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08866666,
                                        child: SvgPicture.asset(
                                            'assets/icons/weekly.svg',
                                            color: const Color(0xFF39B54A),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8, left: 40),
                          child: Card(
                            elevation: 2,
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.165961,
                              width: MediaQuery.of(context).size.width * 0.388,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                color: Colors.transparent,
                              ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 10.0),
                                        child: Row(
                                          children: const [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                'Monthly earnings',
                                                style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 7.0, left: 10.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                '${snapshot.data.docs.first['monthlyEarnings']} kd',
                                                style: const TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontFamily: 'PublicSans',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            top: 3.0, left: 10.0),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15.0, bottom: 5),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.0772413793,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.08866666,
                                        child: SvgPicture.asset(
                                            'assets/icons/monthly.svg',
                                            color: const Color(0xFF39B54A),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 2,
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.165961,
                            width: MediaQuery.of(context).size.width * 0.388,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.transparent,
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10.0),
                                      child: Row(
                                        children: const [
                                          Padding(
                                            padding: EdgeInsets.only(left: 4.0),
                                            child: Text(
                                              'Yearly earnings',
                                              style: TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontFamily: 'PublicSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 7.0, left: 10.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              '${snapshot.data.docs.first['yearlyEarnings']} kd',
                                              style: const TextStyle(
                                                  color: Color(0xFF000000),
                                                  fontFamily: 'PublicSans',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(top: 3.0, left: 10.0),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15.0, bottom: 5),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.0772413793,
                                      width: MediaQuery.of(context).size.width *
                                          0.08866666,
                                      child: SvgPicture.asset(
                                          'assets/icons/yearly.svg',
                                          color: const Color(0xFF39B54A),
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]);
                }
              }),
        ));
  }
}
