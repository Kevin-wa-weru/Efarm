import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/screens/shared/about_us.dart';
import 'package:eshamba/book_lorry_step1.dart';
import 'package:eshamba/notifications.dart';
import 'package:eshamba/orders.dart';
import 'package:eshamba/privacy_policy.dart';
import 'package:eshamba/profile.dart';
import 'package:eshamba/search_page.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/terms_and_conditions.dart';
import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'chat.dart';

class Vendorprofile extends StatefulWidget {
  const Vendorprofile({super.key});

  @override
  State<Vendorprofile> createState() => _VendorprofileState();
}

class _VendorprofileState extends State<Vendorprofile> {
  int currentIndex = 0;

  List<String> userList = [
    "Price ",
    "Date Added",
    "Most Reviwed ",
    "Near me ",
    "Natural Products ",
    "Machineries ",
    "Tools ",
    "Animals ",
  ];

  List<String> selectedUserList = [];
  void openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      hideSearchField: true,
      height: 300,
      themeData: FilterListThemeData(context,
          controlButtonBarTheme: ControlButtonBarThemeData(context,
              controlButtonTheme: const ControlButtonThemeData(
                  primaryButtonBackgroundColor: Color(0xFF3EA334))),
          choiceChipTheme: const ChoiceChipThemeData(
              selectedBackgroundColor: Color(0xFF3EA334))),
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (user) => user,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (user, query) {
        return user.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });

        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SizedBox(
          width: MediaQuery.of(context).size.width / 1.35,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0)),
            child: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      child: Image.asset(
                          height:
                              MediaQuery.of(context).size.height * 0.09236453,
                          width: MediaQuery.of(context).size.width * 0.2,
                          'assets/images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0357142,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notifications()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05541871,
                      width: MediaQuery.of(context).size.width * 0.597333333333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFF4F4F4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.0657142,
                            width:
                                MediaQuery.of(context).size.width * 0.11733333,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF39B54A),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.020480295,
                                width: MediaQuery.of(context).size.width *
                                    0.0380266666,
                                child: SvgPicture.asset(
                                    'assets/icons/notification.svg',
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Notifications',
                              style: TextStyle(
                                  color: Color(0xFF39B54A),
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
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUs()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05541871,
                      width: MediaQuery.of(context).size.width * 0.597333333333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFF4F4F4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.0657142,
                            width:
                                MediaQuery.of(context).size.width * 0.11733333,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF39B54A),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.020480295,
                                width: MediaQuery.of(context).size.width *
                                    0.0380266666,
                                child: SvgPicture.asset('assets/icons/page.svg',
                                    color: Colors.white, fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'About Us',
                              style: TextStyle(
                                  color: Color(0xFF39B54A),
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
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TermsCondition()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05541871,
                      width: MediaQuery.of(context).size.width * 0.597333333333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFF4F4F4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.0657142,
                            width:
                                MediaQuery.of(context).size.width * 0.11733333,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF39B54A),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.020480295,
                                width: MediaQuery.of(context).size.width *
                                    0.0380266666,
                                child: SvgPicture.asset(
                                    'assets/icons/terms.svg',
                                    color: Colors.white,
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Terms & Conditions',
                              style: TextStyle(
                                  color: Color(0xFF39B54A),
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
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrivacyPolicy()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05541871,
                      width: MediaQuery.of(context).size.width * 0.597333333333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFF4F4F4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.0657142,
                            width:
                                MediaQuery.of(context).size.width * 0.11733333,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF39B54A),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.020480295,
                                width: MediaQuery.of(context).size.width *
                                    0.0380266666,
                                child: SvgPicture.asset(
                                    'assets/icons/privacy.svg',
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Privacy policy',
                              style: TextStyle(
                                  color: Color(0xFF39B54A),
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
                              builder: (context) => const BookLorryStep1()));
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05541871,
                      width: MediaQuery.of(context).size.width * 0.597333333333,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: const Color(0xFFF4F4F4),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.0657142,
                            width:
                                MediaQuery.of(context).size.width * 0.11733333,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: const Color(0xFF39B54A),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.020480295,
                                width: MediaQuery.of(context).size.width *
                                    0.0380266666,
                                child: SvgPicture.asset(
                                    'assets/icons/truck.svg',
                                    color: Colors.white,
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Book a driver',
                              style: TextStyle(
                                  color: Color(0xFF39B54A),
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
                    height: MediaQuery.of(context).size.height * 0.20945812,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05541871,
                    width: MediaQuery.of(context).size.width * 0.37066666,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFFF7070),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height:
                              MediaQuery.of(context).size.height * 0.0657142,
                          width: MediaQuery.of(context).size.width * 0.11733333,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFFFF7070),
                          ),
                          child: Center(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.020480295,
                              width: MediaQuery.of(context).size.width *
                                  0.0380266666,
                              child: SvgPicture.asset('assets/icons/logout.svg',
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
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
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: const Color(0xFF3EA334),
          showUnselectedLabels: true,
          onTap: (index) => setState(() => currentIndex = index),
          currentIndex: currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: '',
              backgroundColor: Colors.white,
              icon: currentIndex == 0
                  ? Transform.translate(
                      offset: const Offset(0.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/home.svg',
                              color: const Color(0xFF3EA334),
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    )
                  : Transform.translate(
                      offset: const Offset(0.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/home.svg',
                              color: const Color(0xFF3EA334),
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: currentIndex == 2
                  ? Transform.translate(
                      offset: const Offset(0.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/chat.svg',
                              color: const Color(0xFF3EA334),
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    )
                  : Transform.translate(
                      offset: const Offset(0.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/chat.svg',
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: currentIndex == 4
                  ? Transform.translate(
                      offset: const Offset(0.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/network.svg',
                              color: const Color(0xFF3EA334),
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    )
                  : Transform.translate(
                      offset: const Offset(0.0, 10.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: SvgPicture.asset(
                              'assets/icons/network.svg',
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.dark
                .copyWith(statusBarColor: Colors.transparent),
            child: SafeArea(
              child: IndexedStack(
                index: currentIndex,
                children: [
                  ListView(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Builder(
                            builder: (context) => InkWell(
                              onTap: () => Scaffold.of(context).openDrawer(),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.014778325,
                                width:
                                    MediaQuery.of(context).size.width * 0.048,
                                child: SvgPicture.asset(
                                    'assets/icons/drawer.svg',
                                    fit: BoxFit.fitHeight),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: SizedBox(
                            child: Image.asset(
                                height: MediaQuery.of(context).size.height *
                                    0.092364,
                                width: MediaQuery.of(context).size.width * 0.2,
                                'assets/images/logo.png'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Notifications()));
                                },
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.033399014,
                                      width: MediaQuery.of(context).size.width *
                                          0.05066666666,
                                      child: SvgPicture.asset(
                                          'assets/icons/bell.svg',
                                          fit: BoxFit.fitHeight),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(10.0, -10.0),
                                      child: Row(
                                        children: [
                                          StreamBuilder<Object>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(AuthenticationHelper()
                                                      .userid
                                                      .trim())
                                                  .collection('notifications')
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot snapshot) {
                                                if (snapshot.hasData) {
                                                  List allnewNotifications = [];
                                                  for (var item
                                                      in snapshot.data.docs) {
                                                    DateTime date =
                                                        DateTime.parse(
                                                            item['date']
                                                                .toDate()
                                                                .toString());

                                                    if ((DateTime.now()
                                                            .difference(date)
                                                            .inDays <=
                                                        1)) {
                                                      allnewNotifications
                                                          .add(1);
                                                    }
                                                  }

                                                  if (allnewNotifications
                                                      .isNotEmpty) {
                                                    return Container(
                                                        height: 15,
                                                        width: 15,
                                                        decoration:
                                                            BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            70),
                                                                color: Colors
                                                                    .black,
                                                                border:
                                                                    Border.all(
                                                                  color: const Color(
                                                                      0xFF202020),
                                                                  width: 1,
                                                                )),
                                                        child: Center(
                                                          child: Text(
                                                              allnewNotifications
                                                                  .length
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white)),
                                                        ));
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              })
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              StreamBuilder<Object>(
                                  stream: FirebaseFirestore.instance
                                      .collection('users')
                                      .where('userid',
                                          isEqualTo: AuthenticationHelper()
                                              .userid
                                              .trim())
                                      .snapshots(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Profile()));
                                        },
                                        child: snapshot.data.docs
                                                    .first['avatarUrl'] ==
                                                ''
                                            ? Container(
                                                height: 40,
                                                width: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
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
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    const Color(0xFFE8E8E8),
                                                radius: 15,
                                                backgroundImage: NetworkImage(
                                                    snapshot.data.docs
                                                        .first['avatarUrl']),
                                              ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  })
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.033251231,
                    ),
                    Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Searching()));
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height *
                                  0.0591133,
                              width: MediaQuery.of(context).size.width *
                                  0.7493333333,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: const Color(0xFFF4F4F4),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 22.0, right: 17),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.0233990,
                                      width: MediaQuery.of(context).size.width *
                                          0.050666666,
                                      child: SvgPicture.asset(
                                          'assets/icons/search.svg',
                                          fit: BoxFit.fitHeight),
                                    ),
                                  ),
                                  const Text(
                                    'Search',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.06933333,
                      ),
                      InkWell(
                        onTap: () {
                          openFilterDialog();
                        },
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.0233990,
                          width:
                              MediaQuery.of(context).size.width * 0.050666666,
                          child: SvgPicture.asset('assets/icons/filter.svg',
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                    ]),
                    StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('userid',
                                isEqualTo: AuthenticationHelper().userid.trim())
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.074334,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.893333,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(55),
                                            color: const Color(0xFFE8E8E8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 22.0,
                                                          right: 17),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.0369458128078818,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: const Color(
                                                            0xFF7CD956)),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01152709,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.042666666,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/eye2.svg',
                                                            fit: BoxFit
                                                                .fitHeight),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  'Todays Visitors',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'PublicSans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.32666666,
                                                  color: Colors.transparent,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      snapshot.data.docs.first[
                                                          'daysVisitors'],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'PublicSans',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.074334,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.893333,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(55),
                                            color: const Color(0xFFE8E8E8)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 22.0,
                                                          right: 17),
                                                  child: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.0369458128078818,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.08,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: const Color(
                                                            0xFF7CD956)),
                                                    child: Center(
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.01152709,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.042666666,
                                                        child: SvgPicture.asset(
                                                            'assets/icons/money.svg',
                                                            fit: BoxFit
                                                                .fitHeight),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Text(
                                                  'Todays Earning',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'PublicSans',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.32666666,
                                                  color: Colors.transparent,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '\$${snapshot.data.docs.first['daysVisitors']}',
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'PublicSans',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Farm',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ),
                    ),
                    StreamBuilder<Object>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('userid',
                                isEqualTo: AuthenticationHelper().userid.trim())
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return SingledFarm(
                              farmname: snapshot.data.docs.first['workPlace']
                                  ['name'],
                              image: snapshot.data.docs.first['workPlace']
                                  ['image'],
                              address: snapshot.data.docs.first['mapAddress']
                                  ['address'],
                              description: '',
                              openTime: snapshot.data.docs.first['workingHours']
                                  ['openTime'],
                              closeTime: snapshot.data.docs
                                  .first['workingHours']['closingTime'],
                            );
                          } else {
                            return Container();
                          }
                        })
                  ]),
                  const Chat(),
                  const Orders(
                    showbackArrow: false,
                  )
                ],
              ),
            )));
  }
}

class SingledFarm extends StatelessWidget {
  const SingledFarm({
    Key? key,
    required this.farmname,
    required this.address,
    required this.openTime,
    required this.closeTime,
    required this.description,
    required this.image,
  }) : super(key: key);
  final String farmname;
  final String address;
  final String openTime;
  final String closeTime;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) =>  DetailedFarm(farm: {},)));
      },
      child: Padding(
        padding:
            const EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(7.0),
            topRight: Radius.circular(7.0),
            bottomLeft: Radius.circular(7.0),
            bottomRight: Radius.circular(7.0),
          ),
          child: Card(
            elevation: 2,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4778325,
              width: MediaQuery.of(context).size.width * 0.89333333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2426108,
                    width: MediaQuery.of(context).size.width * 0.89333333,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Image.network(image)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11.0, left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          farmname,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.01939655,
                          width: MediaQuery.of(context).size.width * 0.0330133,
                          child: SvgPicture.asset('assets/icons/location.svg',
                              fit: BoxFit.contain),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            address,
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                    child: Row(
                      children: [
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.01939655,
                          width: MediaQuery.of(context).size.width * 0.0330133,
                          child: SvgPicture.asset('assets/icons/clock.svg',
                              fit: BoxFit.contain),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Available: $openTime to $closeTime',
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                            style: TextStyle(
                                color: Color(0xFF707070),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.0566502,
                      width: MediaQuery.of(context).size.width * 0.776,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Color(0xFF7CD956),
                                Color(0xFF3EA334),
                              ])),
                      child: const Center(
                        child: Text(
                          'Tembelea Shamba',
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
