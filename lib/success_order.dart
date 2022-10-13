import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/homepage.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessfulOrder extends StatefulWidget {
  const SuccessfulOrder(
      {Key? key,
      required this.address,
      required this.shippingfee,
      required this.ordernote})
      : super(key: key);
  final Map<String, dynamic> address;
  final int shippingfee;
  final String ordernote;
  @override
  State<SuccessfulOrder> createState() => _SuccessfulOrderState();
}

class _SuccessfulOrderState extends State<SuccessfulOrder> {
  bool placed = false;
  List allItems = [];
  late String totalPrice = '';

  setOrder() async {
    final docRef = await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().userid.trim())
        .collection('cart')
        .get();

    for (var items in docRef.docs) {
      allItems.add({
        'imageUrl': items['imageUrl'],
        'name': items['name'],
        'price': items['price'],
        'qty': items['qty'],
        'subtotal': items['subtotal']
      });
    }

    List allsubTotals = [];

    for (var doc in docRef.docs) {
      allsubTotals.add(double.parse(doc['subtotal']));
    }

    totalPrice = allsubTotals
        .reduce((value, current) => value + current)
        .toStringAsFixed(2);

    final docRef2 = FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().userid.trim())
        .collection('orders');

    final docRef3 = FirebaseFirestore.instance
        .collection("users")
        .doc(AuthenticationHelper().userid.trim())
        .collection('notifications');

    print(allItems);
    print(docRef2);

    var response = await docRef2.add({
      'date': DateTime.now(),
      'total': totalPrice,
      'shippingfee': widget.shippingfee.toString(),
      'ordernote': widget.ordernote,
      'items': allItems,
      'address': widget.address,
      'payment': 'unpaid',
      'status': 'pending',
      'type': 'user'
    });

    docRef3.add({
      'date': DateTime.now(),
      'title': 'You order number has been received',
      'body':
          'Hello there. Order of number ${response.id} has been received. It willbe delivered to your address after three days.',
      'id': response.id,
    });

    setState(() {
      placed = true;
    });

    Timer(const Duration(seconds: 4), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  void initState() {
    setOrder();

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
            Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.256157635,
                  width: MediaQuery.of(context).size.width * 0.89333333,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.transparent,
                  ),
                  child: Image.asset('assets/images/placed.gif'),
                ),
                placed == true
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.049261083,
                          width:
                              MediaQuery.of(context).size.width * 0.333333333,
                          child: SvgPicture.asset('assets/icons/tick.svg',
                              color: const Color(0xFF3EA334),
                              fit: BoxFit.fitHeight),
                        ),
                      )
                    : Container(),
                placed == true
                    ? const Text(
                        'Order has been placed !',
                        style: TextStyle(
                            color: Color(0xFF3EA334),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      )
                    : const Text(
                        'Placing your order...',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
