import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/order_details.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key, required this.showbackArrow}) : super(key: key);
  final bool showbackArrow;
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String selectedOrder = 'current';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: widget.showbackArrow == false
            ? const Center(
                child: Text(
                  'Current Orders',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              )
            : Row(
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
                    width: MediaQuery.of(context).size.width * 0.20,
                  ),
                  const Text(
                    'My Orders',
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.0874384236453202,
              width: MediaQuery.of(context).size.width * 0.89333333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFFBFBFB),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOrder = 'current';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.057881773,
                      width: MediaQuery.of(context).size.width * 0.37866666,
                      decoration: selectedOrder == 'current'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF7CD956),
                                    Color(0xFF3EA334),
                                  ]))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(62),
                              color: const Color(0xFFFBFBFB),
                              border:
                                  Border.all(color: Colors.black12, width: 2)),
                      child: Center(
                          child: Text(
                        'Current Orders',
                        style: TextStyle(
                            color: selectedOrder == 'current'
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF888888),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 13),
                      )),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedOrder = 'past';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.057881773,
                      width: MediaQuery.of(context).size.width * 0.37866666,
                      decoration: selectedOrder == 'past'
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Color(0xFF7CD956),
                                    Color(0xFF3EA334),
                                  ]))
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(62),
                              color: const Color(0xFFFBFBFB),
                              border:
                                  Border.all(color: Colors.black12, width: 2)),
                      child: Center(
                        child: Text(
                          'Past Orders',
                          style: TextStyle(
                              color: selectedOrder == 'past'
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFF888888),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.029556650,
            ),
            selectedOrder == 'current'
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(AuthenticationHelper().userid.trim())
                        .collection('orders')
                        .where('status', isEqualTo: 'pending')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.3275862,
                                width:
                                    MediaQuery.of(context).size.width * 0.70933,
                                color: Colors.transparent,
                                child: Image.asset(
                                    height: MediaQuery.of(context).size.height *
                                        0.3275862,
                                    width: MediaQuery.of(context).size.width *
                                        0.70933,
                                    'assets/images/Empty.gif'),
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SingleCurrentOrder(
                                  address: snapshot.data!.docs[index]
                                      ['address'],
                                  items: snapshot.data!.docs[index]['items'],
                                  ordernote: snapshot.data!.docs[index]
                                      ['ordernote'],
                                  payment: snapshot.data!.docs[index]
                                      ['payment'],
                                  shippingfee: snapshot.data!.docs[index]
                                      ['shippingfee'],
                                  status: snapshot.data!.docs[index]['status'],
                                  total: snapshot.data!.docs[index]['total'],
                                  date: DateTime.parse(snapshot
                                      .data!.docs[index]['date']
                                      .toDate()
                                      .toString()),
                                  refernce:
                                      snapshot.data!.docs[index].reference.id,
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        print(
                            'Hoooooooooooooooooooooooooooooooooonnnnnnnoossss data');
                        return Container(
                          height:
                              MediaQuery.of(context).size.height * 0.3275862,
                          width: MediaQuery.of(context).size.width * 0.70933,
                          color: Colors.red,
                          child: Image.asset(
                              height: MediaQuery.of(context).size.height *
                                  0.3275862,
                              width:
                                  MediaQuery.of(context).size.width * 0.70933,
                              'assets/images/Empty.gif'),
                        );
                      }
                    })
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(AuthenticationHelper().userid.trim())
                        .collection('orders')
                        .where('status', isEqualTo: 'complete')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.docs.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.3275862,
                                width:
                                    MediaQuery.of(context).size.width * 0.70933,
                                color: Colors.transparent,
                                child: Image.asset(
                                    height: MediaQuery.of(context).size.height *
                                        0.3275862,
                                    width: MediaQuery.of(context).size.width *
                                        0.70933,
                                    'assets/images/Empty.gif'),
                              ),
                            ),
                          );
                        } else {
                          return Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return SinglePastOrder(
                                  address: snapshot.data!.docs[index]
                                      ['address'],
                                  items: snapshot.data!.docs[index]['items'],
                                  ordernote: snapshot.data!.docs[index]
                                      ['ordernote'],
                                  payment: snapshot.data!.docs[index]
                                      ['payment'],
                                  shippingfee: snapshot.data!.docs[index]
                                      ['shippingfee'],
                                  status: snapshot.data!.docs[index]['status'],
                                  total: snapshot.data!.docs[index]['total'],
                                  date: DateTime.parse(snapshot
                                      .data!.docs[index]['date']
                                      .toDate()
                                      .toString()),
                                  refernce:
                                      snapshot.data!.docs[index].reference.id,
                                );
                              },
                            ),
                          );
                        }
                      } else {
                        return SizedBox(
                          child: Image.asset(
                              height: MediaQuery.of(context).size.height *
                                  0.3275862,
                              width:
                                  MediaQuery.of(context).size.width * 0.70933,
                              'assets/images/Empty.gif'),
                        );
                      }
                    })
          ],
        ),
      ),
    );
  }
}

class SinglePastOrder extends StatelessWidget {
  const SinglePastOrder({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
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
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'ORDER ID #125288767',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 11.0),
                    child: Text(
                      '\$347.00',
                      style: TextStyle(
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
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Total Items: 2',
                      style: TextStyle(
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
                                builder: (context) => OrderDetails(
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
                    child: const Center(
                      child: Text(
                        'Complete',
                        style: TextStyle(
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
    );
  }
}

class SingleCurrentOrder extends StatelessWidget {
  const SingleCurrentOrder({
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, right: 20, left: 20),
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
                      'ORDER ID   $refernce',
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
                      'Total Items: ${items.length}',
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
                                builder: (context) => OrderDetails(
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
                        color: const Color(0xFFFE9D2C)),
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
    );
  }
}
