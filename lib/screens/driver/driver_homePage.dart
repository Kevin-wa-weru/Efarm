import 'package:eshamba/chat.dart';
import 'package:eshamba/driver_order_details.dart';
import 'package:eshamba/driverprofile.dart';
import 'package:eshamba/quick_chat.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int currentIndex = 0;
  Widget resolveAppBarTitle(currentpage) {
    if (currentpage == 0) {
      return const Text(
        'Delivery Requests',
        style: TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w600,
            fontSize: 18),
      );
    }
    if (currentpage == 1) {
      return Container();
    }

    if (currentpage == 2) {
      return const Text(
        'Past Orders',
        style: TextStyle(
            color: Color(0xFF000000),
            fontFamily: 'PublicSans',
            fontWeight: FontWeight.w600,
            fontSize: 18),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: resolveAppBarTitle(currentIndex),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DriverProfile()));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .where('userid',
                          isEqualTo: AuthenticationHelper().userid.trim())
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        child: snapshot.data.docs.first['avatarUrl'] == ''
                            ? Center(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xFFE8E8E8),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.0147783251,
                                      width: MediaQuery.of(context).size.width *
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
                                backgroundColor: const Color(0xFFF4F4F4),
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    snapshot.data.docs.first['avatarUrl']),
                              ),
                      );
                    } else {
                      return Container();
                    }
                  }),
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
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder<Object>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(AuthenticationHelper().userid.trim())
                              .collection('requests')
                              .where('status', isEqualTo: 'none')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.docs.isEmpty) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 70.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3275862,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70933,
                                          color: Colors.transparent,
                                          child: Image.asset(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3275862,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.70933,
                                              'assets/images/car.gif'),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 15.0),
                                          child: Text(
                                            'No delivery requests yet',
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontFamily: 'PublicSans',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Column(
                                  children: snapshot.data!.docs
                                      .map<Widget>((e) => SingleDeliveryRequest(
                                            address: e['address'],
                                            date:
                                                '${DateTime.parse(e['date'].toDate().toString()).day}/${DateTime.parse(e['date'].toDate().toString()).month}/${DateTime.parse(e['date'].toDate().toString()).year},',
                                            image: e['requestby']['avatarUrl'],
                                            price: e['price'],
                                            name: e['requestby']['name'],
                                            vehicles: e['vehicles'],
                                            docid: e.reference.id,
                                            requestId: e['requestId'],
                                          ))
                                      .toList(),
                                );
                              }
                            } else {
                              return Container();
                            }
                          })
                    ],
                  )
                ],
              ),
              const Chat(),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(AuthenticationHelper().userid.trim())
                          .collection('orders')
                          .where('type', isEqualTo: 'driver')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.docs.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3275862,
                                      width: MediaQuery.of(context).size.width *
                                          0.70933,
                                      color: Colors.transparent,
                                      child: Image.asset(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3275862,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70933,
                                          'assets/images/Empty.gif'),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        'No Orders yet',
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Column(
                                children: snapshot.data.docs
                                    .map<Widget>((e) =>
                                        SinglePastOrderForDriver(
                                          address: e['address'],
                                          items: e['items'],
                                          ordernote: e['ordernote'],
                                          payment: e['payment'],
                                          shippingfee: e['shippingfee'],
                                          status: e['status'],
                                          total: e['total'],
                                          date: DateTime.parse(
                                              e['date'].toDate().toString()),
                                          refernce: e.reference.id,
                                        ))
                                    .toList());
                          }
                        } else {
                          return Container();
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SingleDeliveryRequest extends StatelessWidget {
  const SingleDeliveryRequest({
    Key? key,
    required this.address,
    required this.price,
    required this.date,
    required this.vehicles,
    required this.image,
    required this.name,
    required this.docid,
    required this.requestId,
  }) : super(key: key);
  final String address;
  final String price;
  final String date;
  final String vehicles;
  final String image;
  final String name;
  final String docid;
  final String requestId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(7.0),
        ),
        child: Card(
          elevation: 6,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3719211822,
            width: MediaQuery.of(context).size.width * 0.89333333333,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
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
                      Container(
                        height: 20,
                        width: MediaQuery.of(context).size.width * 0.5730133,
                        color: Colors.transparent,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '\$$price/day',
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01939655,
                        width: MediaQuery.of(context).size.width * 0.0330133,
                        child: SvgPicture.asset('assets/icons/calendar.svg',
                            fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          date,
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
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0),
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03987684,
                        width: MediaQuery.of(context).size.width * 0.0593333333,
                        child: SvgPicture.asset('assets/icons/truck.svg',
                            fit: BoxFit.contain),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '$vehicles Vehicle(s)',
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05172413793,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.850666666,
                  height: MediaQuery.of(context).size.height * 0.068965517,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFEFFFF1),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          colors: [
                            Color(0xFFEFFFF1),
                            Color(0xFFF8F8F8),
                          ])),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 12, bottom: 12, right: 10),
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFFF4F4F4),
                          radius: 20,
                          backgroundImage: NetworkImage(image),
                        ),
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuickChatDetails(
                                        userID: requestId,
                                        name: name,
                                        avatarUrl: image,
                                      )));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.30666666,
                          height:
                              MediaQuery.of(context).size.height * 0.02987684,
                          color: Colors.transparent,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  0.02987684,
                              width: MediaQuery.of(context).size.width *
                                  0.0693333333,
                              child: SvgPicture.asset('assets/icons/text.svg',
                                  fit: BoxFit.contain),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          final docRef = FirebaseFirestore.instance
                              .collection("users")
                              .doc(AuthenticationHelper().userid.trim())
                              .collection('requests')
                              .doc(docid);

                          await docRef.update({
                            'status': 'decline',
                          });
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.05665024,
                          width: MediaQuery.of(context).size.width * 0.312,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFFFF9595),
                                    Color(0xFFFF9595),
                                  ])),
                          child: const Center(
                            child: Text(
                              'Decline',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () async {
                          final docRef = FirebaseFirestore.instance
                              .collection("users")
                              .doc(AuthenticationHelper().userid.trim())
                              .collection('requests')
                              .doc(docid);

                          await docRef.update({
                            'status': 'accept',
                          });

                          final docRef2 = FirebaseFirestore.instance
                              .collection("users")
                              .doc(AuthenticationHelper().userid.trim())
                              .collection('orders');

                          await docRef2.add({
                            'date': DateTime.now(),
                            'total': price,
                            'shippingfee': '0.00',
                            'ordernote': '',
                            'items': [
                              {
                                'imageUrl': image,
                                'name': name,
                                'price': price,
                                'qty': '1',
                                'subtotal': price
                              }
                            ],
                            'address': {'description': address},
                            'payment': 'unpaid',
                            'status': 'pending',
                            'type': 'driver'
                          });
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * 0.05665024,
                          width: MediaQuery.of(context).size.width * 0.312,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF7CD956),
                                    Color(0xFF3EA334),
                                  ])),
                          child: const Center(
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18),
                            ),
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
    );
  }
}

class SinglePastOrderForDriver extends StatelessWidget {
  const SinglePastOrderForDriver({
    Key? key,
    required this.address,
    required this.items,
    required this.ordernote,
    required this.payment,
    required this.shippingfee,
    required this.status,
    required this.total,
    required this.date,
    required this.refernce,
  }) : super(key: key);
  final Map address;
  final List items;
  final String ordernote;
  final String payment;
  final String shippingfee;
  final String status;
  final String total;
  final DateTime date;
  final String refernce;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.167487684,
          width: MediaQuery.of(context).size.width * 0.893333333,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xFFFBFBFB),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'ORDER ID $refernce',
                        style: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: Text(
                        '\$$total',
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
                padding: const EdgeInsets.only(top: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Total Items: ${items.length.toString()}',
                        style: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 11.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriverOrderDetails(
                                        address: address,
                                        items: items,
                                        payment: payment,
                                        shippingfee: shippingfee,
                                        status: status,
                                        total: total,
                                        date: date,
                                        refernce: refernce,
                                        ordernote: ordernote,
                                      )));
                        },
                        child: Row(
                          children: const [
                            Text(
                              'View',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0283251,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.0418719,
                      width: MediaQuery.of(context).size.width * 0.23466666,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [
                                Color(0xFF7CD956),
                                Color(0xFF3EA334),
                              ])),
                      child: Center(
                        child: Text(
                          status,
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
