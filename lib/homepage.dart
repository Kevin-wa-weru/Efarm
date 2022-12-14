import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/Cubits/get_blogs_cubit.dart';
import 'package:eshamba/Cubits/get_farms_cubit.dart';
import 'package:eshamba/Cubits/get_posted_products_cubit.dart';
import 'package:eshamba/detailed_blog.dart';
import 'package:eshamba/detailed_farm_detail.dart';
import 'package:eshamba/screens/shared/about_us.dart';
import 'package:eshamba/blogs.dart';
import 'package:eshamba/book_lorry_step1.dart';
import 'package:eshamba/cart.dart';
import 'package:eshamba/chat.dart';
import 'package:eshamba/models/data.dart';
import 'package:eshamba/notifications.dart';
import 'package:eshamba/orders.dart';
import 'package:eshamba/post_request.dart';
import 'package:eshamba/privacy_policy.dart';
import 'package:eshamba/profile.dart';
import 'package:eshamba/search_page.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:eshamba/terms_and_conditions.dart';
import 'package:eshamba/view_all.dart';
import 'package:filter_list/filter_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCatogory;
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
        context.read<GetPostedProductsCubit>().getProducts();
        context.read<GetFarmsCubit>().getFarms();
        Navigator.pop(context);
      },
    );
  }

  @override
  void initState() {
    context.read<GetPostedProductsCubit>().getProducts();
    context.read<GetFarmsCubit>().getFarms();
    context.read<GetBlogsCubit>().getBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                        height: MediaQuery.of(context).size.height * 0.09236453,
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
                          width: MediaQuery.of(context).size.width * 0.11733333,
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
                          width: MediaQuery.of(context).size.width * 0.11733333,
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
                          width: MediaQuery.of(context).size.width * 0.11733333,
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
                              child: SvgPicture.asset('assets/icons/terms.svg',
                                  color: Colors.white, fit: BoxFit.contain),
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
                          width: MediaQuery.of(context).size.width * 0.11733333,
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
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PostRequest()));
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
                          width: MediaQuery.of(context).size.width * 0.11733333,
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
                                  'assets/icons/request.svg',
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Post a Request',
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
                          width: MediaQuery.of(context).size.width * 0.11733333,
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
                              child: SvgPicture.asset('assets/icons/truck.svg',
                                  color: Colors.white, fit: BoxFit.contain),
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
                        height: MediaQuery.of(context).size.height * 0.0657142,
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
            icon: currentIndex == 1
                ? Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/vendor2.svg',
                            color: Colors.black87,
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
                            'assets/icons/vendor2.svg',
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
            icon: currentIndex == 3
                ? Transform.translate(
                    offset: const Offset(0.0, 10.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/icons/page.svg',
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
                            'assets/icons/page.svg',
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
          child: IndexedStack(
            index: currentIndex,
            children: [
              ListView(
                children: [
                  Column(
                    children: [
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('users')
                                                    .doc(AuthenticationHelper()
                                                        .userid
                                                        .trim())
                                                    .collection('notifications')
                                                    .snapshots(),
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    List allnewNotifications =
                                                        [];
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
                                                                  border: Border
                                                                      .all(
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
                                                                    fontSize:
                                                                        10,
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
                                          child: Container(
                                            child: snapshot.data.docs
                                                        .first['avatarUrl'] ==
                                                    ''
                                                ? Center(
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: const Color(
                                                            0xFFE8E8E8),
                                                      ),
                                                      child: Center(
                                                        child: SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.0147783251,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                          child: SvgPicture.asset(
                                                              'assets/icons/user.svg',
                                                              color: Colors
                                                                  .black12,
                                                              fit: BoxFit
                                                                  .contain),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor:
                                                        const Color(0xFFF4F4F4),
                                                    radius: 15,
                                                    backgroundImage:
                                                        NetworkImage(snapshot
                                                                .data
                                                                .docs
                                                                .first[
                                                            'avatarUrl']),
                                                  ),
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
                        height:
                            MediaQuery.of(context).size.height * 0.033251231,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Searching()));
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                            ),
                          ),
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.06933333,
                          ),
                          InkWell(
                            onTap: () {
                              openFilterDialog();
                            },
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.0233990,
                              width: MediaQuery.of(context).size.width *
                                  0.050666666,
                              child: SvgPicture.asset('assets/icons/filter.svg',
                                  fit: BoxFit.fitHeight),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0283251,
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01477832,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cateogry.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCatogory = cateogry[index];

                                    context
                                        .read<GetPostedProductsCubit>()
                                        .getProducts();
                                    context.read<GetFarmsCubit>().getFarms();
                                    context.read<GetBlogsCubit>().getBlogs();
                                  });
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                    ),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.044334,
                                      width: MediaQuery.of(context).size.width *
                                          0.3386666,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(55),
                                          color: selectedCatogory ==
                                                  cateogry[index]
                                              ? const Color(0xFF39B54A)
                                              : const Color(0xFFE8E8E8)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Center(
                                          child: Text(
                                            cateogry[index],
                                            style: TextStyle(
                                                color: selectedCatogory ==
                                                        cateogry[index]
                                                    ? Colors.white
                                                    : const Color(0xFF000000),
                                                fontFamily: 'PublicSans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.030640394,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Top Products',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViewAllItems(
                                              selectedCategory: 'products',
                                            )));
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01860837,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          color: Colors.transparent,
                          height:
                              MediaQuery.of(context).size.height * 0.287093596,
                          child: BlocBuilder<GetPostedProductsCubit,
                              GetPostedProductsState>(
                            builder: (context, state) {
                              return state.when(
                                  initial: () {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const SingleLoadingProduct();
                                      },
                                    );
                                  },
                                  loading: () {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const SingleLoadingProduct();
                                      },
                                    );
                                  },
                                  loaded: (products) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: products.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SingleTopProduct(
                                          product: products[index],
                                        );
                                      },
                                    );
                                  },
                                  error: (String message) => Center(
                                        child: Text(message),
                                      ));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.030640394,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Farms',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViewAllItems(
                                              selectedCategory: 'farms',
                                            )));
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01860837,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          color: Colors.transparent,
                          height:
                              MediaQuery.of(context).size.height * 0.4878325,
                          child: BlocBuilder<GetFarmsCubit, GetFarmsState>(
                            builder: (context, state) {
                              return state.when(
                                  initial: () {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const SingleFarmLoading();
                                      },
                                    );
                                  },
                                  loading: () {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 1,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const SingleFarmLoading();
                                      },
                                    );
                                  },
                                  loaded: (farms) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: farms.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SingleFarm(
                                          farm: farms[index],
                                        );
                                      },
                                    );
                                  },
                                  error: (String message) => Center(
                                        child: Text(message),
                                      ));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.030640394,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: Text(
                              'Recent Blogs',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ViewAllItems(
                                              selectedCategory: 'blogs',
                                            )));
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'View all',
                                    style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontFamily: 'PublicSans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01860837,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Container(
                          color: Colors.transparent,
                          height:
                              MediaQuery.of(context).size.height * 0.26231527,
                          child: BlocBuilder<GetBlogsCubit, GetBlogsState>(
                            builder: (context, state) {
                              return state.when(
                                  initial: () {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cateogry.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const SingleHomePageBlogLoading();
                                      },
                                    );
                                  },
                                  loading: () {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cateogry.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return const SingleHomePageBlogLoading();
                                      },
                                    );
                                  },
                                  loaded: (blogs) {
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: blogs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return SingleHomePageBlog(
                                          blog: blogs[index],
                                        );
                                      },
                                    );
                                  },
                                  error: (String message) => Center(
                                        child: Text(message),
                                      ));
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Cart(),
              const Chat(),
              const Blogs(),
              const Orders(
                showbackArrow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleHomePageBlog extends StatelessWidget {
  const SingleHomePageBlog({
    Key? key,
    required this.blog,
  }) : super(key: key);
  final Map<String, dynamic> blog;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedBlog(
                        blog: blog,
                      )));
        },
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
              height: MediaQuery.of(context).size.height * 0.26231527,
              width: MediaQuery.of(context).size.width * 0.5386666,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.147783251,
                    width: MediaQuery.of(context).size.width * 0.538666666,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Image.network(blog['image'])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            blog['postedBy'],
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 9.16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, left: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Text(
                            blog['title'],
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14.18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            color: Colors.transparent,
                            width:
                                MediaQuery.of(context).size.width * 0.488666666,
                            child: Text(
                              blog['description'],
                              style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10.00),
                            ),
                          ),
                        ),
                      ],
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

class SingleHomePageBlogLoading extends StatelessWidget {
  const SingleHomePageBlogLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
          bottomLeft: Radius.circular(7.0),
          bottomRight: Radius.circular(7.0),
        ),
        child: Card(
          elevation: 2,
          color: const Color(0xFFE8E8E8),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.26231527,
            width: MediaQuery.of(context).size.width * 0.5386666,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color(0xFFE8E8E8),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.147783251,
                  width: MediaQuery.of(context).size.width * 0.538666666,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                        child: Container()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            height: 10,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 7.0, left: 10.0),
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Container(
                            height: 10,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3.0, left: 10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                            width:
                                MediaQuery.of(context).size.width * 0.488666666,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                            child: Container()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SingleFarm extends StatelessWidget {
  const SingleFarm({
    Key? key,
    required this.farm,
  }) : super(key: key);

  final Map<String, dynamic> farm;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedFarm(
                        farm: farm,
                      )));
        },
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
                      child: Image.network(farm['link']),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 11.0, left: 10.0),
                    child: Row(
                      children: [
                        Text(
                          farm['name'],
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
                            farm['location'],
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
                            'Available: ${farm['time']}',
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: SizedBox(
                            width:
                                MediaQuery.of(context).size.width * 0.79333333,
                            child: Text(
                              farm['description'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Color(0xFF707070),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10),
                            ),
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

class SingleFarmLoading extends StatelessWidget {
  const SingleFarmLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
          bottomLeft: Radius.circular(7.0),
          bottomRight: Radius.circular(7.0),
        ),
        child: Card(
          elevation: 2,
          color: const Color(0xFFE8E8E8),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4778325,
            width: MediaQuery.of(context).size.width * 0.89333333,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color(0xFFE8E8E8),
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
                        child: Container(
                          color: Colors.white,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 11.0, left: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 10,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 10,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Container(
                          height: 10,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Colors.white,
                          ),
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
                      color: Colors.white,
                    ),
                    child: const Center(
                      child: Text(
                        '',
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
    );
  }
}

class SingleTopProduct extends StatefulWidget {
  const SingleTopProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Map<String, dynamic> product;

  @override
  State<SingleTopProduct> createState() => _SingleTopProductState();
}

class _SingleTopProductState extends State<SingleTopProduct> {
  bool addingToCart = false;
  String? productbeingAdded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
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
              height: MediaQuery.of(context).size.height * 0.277093596,
              width: MediaQuery.of(context).size.width * 0.893333333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.164433497,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Image.network(
                            widget.product['imageURl'],
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFE8E8E8),
                          radius: 15,
                          backgroundImage:
                              NetworkImage(widget.product['postedByAvatarUrl']),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            widget.product['postedByName'],
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w300,
                                fontSize: 9.16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, left: 50.0),
                            child: Row(
                              children: [
                                Text(
                                  widget.product['productName'],
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 6.0, left: 27.0),
                            child: Row(
                              children: [
                                Text(
                                  '\$${widget.product['productPrice']}',
                                  style: const TextStyle(
                                      color: Color(0xFF39B54A),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                          onTap: () async {
                            setState(() {
                              addingToCart = true;
                              productbeingAdded = widget.product['imageURl'];
                            });

                            final checkRef = await FirebaseFirestore.instance
                                .collection("users")
                                .doc(AuthenticationHelper().userid.trim())
                                .collection('cart')
                                .where('imageUrl',
                                    isEqualTo: widget.product['imageURl'])
                                .get();
                            if (checkRef.docs.isEmpty) {
                              final docRef = FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(AuthenticationHelper().userid.trim())
                                  .collection('cart');

                              await docRef.add({
                                'name': widget.product['productName'],
                                'price': widget.product['productPrice'],
                                'imageUrl': widget.product['imageURl'],
                                'qty': '1',
                                'subtotal': widget.product['productPrice'],
                              });

                              setState(() {
                                addingToCart = false;
                                productbeingAdded = '';
                              });

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  "Added to cart",
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                              );
                            } else {
                              setState(() {
                                addingToCart = false;
                                productbeingAdded = '';
                              });
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                  "Already in cart",
                                  style: TextStyle(
                                      color: Color(0xFFFFFFFF),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                )),
                              );
                            }
                          },
                          child: Container(
                            height:
                                MediaQuery.of(context).size.height * 0.046798,
                            width: MediaQuery.of(context).size.width *
                                0.258666666666,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    colors: [
                                      Color(0xFF7CD956),
                                      Color(0xFF3EA334),
                                    ])),
                            child: productbeingAdded ==
                                        widget.product['imageURl'] &&
                                    addingToCart == true
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
                                      'Add to cart',
                                      style: TextStyle(
                                          color: Color(0xFFFFFFFF),
                                          fontFamily: 'PublicSans',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class SingleLoadingProduct extends StatelessWidget {
  const SingleLoadingProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(7.0),
          topRight: Radius.circular(7.0),
          bottomLeft: Radius.circular(7.0),
          bottomRight: Radius.circular(7.0),
        ),
        child: Card(
          color: const Color(0xFFE8E8E8),
          elevation: 2,
          child: Container(
              height: MediaQuery.of(context).size.height * 0.277093596,
              width: MediaQuery.of(context).size.width * 0.893333333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color(0xFFE8E8E8),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.164433497,
                    width: MediaQuery.of(context).size.width * 0.893333333,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Container(
                            color: const Color(0xFFE8E8E8),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(700),
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: 20,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, left: 50.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 6.0, left: 27.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.046798,
                          width: MediaQuery.of(context).size.width *
                              0.258666666666,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: const Center(
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
