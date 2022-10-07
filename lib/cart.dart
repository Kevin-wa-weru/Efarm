import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/checkout.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Cart',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03300492,
            ),
            Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(AuthenticationHelper().userid.trim())
                        .collection('cart')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CartItem(
                              name: snapshot.data!.docs[index]['name'],
                              price: snapshot.data!.docs[index]['subtotal'],
                              qty: snapshot.data!.docs[index]['qty'],
                              image: snapshot.data!.docs[index]['imageUrl'],
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    })),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CheckOut()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0615763,
                    width: MediaQuery.of(context).size.width * 0.8933333,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Color(0xFF7CD956),
                              Color(0xFF3EA334),
                            ])),
                    child: Center(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(AuthenticationHelper().userid.trim())
                              .collection('cart')
                              .snapshots(),
                          builder: (context, AsyncSnapshot snapshot) {
                            late String total = '';
                            List allsubTotals = [];
                            if (snapshot.hasData) {
                              for (var doc in snapshot.data.docs) {
                                allsubTotals.add(double.parse(doc['subtotal']));
                              }

                              total = allsubTotals
                                  .reduce((value, current) => value + current)
                                  .toStringAsFixed(2);

                              return Text(
                                'Continue : Total \$$total',
                                style: const TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  const CartItem({
    Key? key,
    required this.name,
    required this.price,
    required this.qty,
    required this.image,
  }) : super(key: key);
  final String name;
  final String price;
  final String qty;
  final String image;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  List<String> selectedItem = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: InkWell(
              onTap: () {
                setState(() {
                  if (selectedItem.contains(widget.image)) {
                    selectedItem.remove(widget.image);
                  } else {
                    selectedItem.add(widget.image);
                  }
                });
              },
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: selectedItem.contains(widget.image)
                        ? const Color(0xFF3EA334)
                        : Colors.transparent,
                    border: Border.all(
                      color: Colors.black87,
                      width: selectedItem.contains(widget.image) ? 0.5 : 2,
                    )),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.152709,
            width: MediaQuery.of(context).size.width * 0.8533333,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
                border: Border.all(
                  color: const Color(0xFFBBBBBB),
                  width: 1,
                )),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 5, bottom: 5),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.139162561,
                    width: MediaQuery.of(context).size.width * 0.29866666,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(80.0),
                            topRight: Radius.circular(80.0),
                            bottomLeft: Radius.circular(80.0),
                            bottomRight: Radius.circular(80.0),
                          ),
                          child: Image.network(widget.image)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.444666666,
                        color: Colors.transparent,
                        child: Text(
                          widget.name,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * 0.444666666,
                          color: Colors.transparent,
                          child: Text(
                            '\$${widget.price}',
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width * 0.444666666,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0, top: 15),
                              child: Container(
                                height: MediaQuery.of(context).size.height *
                                    0.041871,
                                width:
                                    MediaQuery.of(context).size.width * 0.22933,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: const Color(0xFFBBBBBB),
                                      width: 1,
                                    )),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final docRef = await FirebaseFirestore
                                              .instance
                                              .collection("users")
                                              .doc(AuthenticationHelper()
                                                  .userid
                                                  .trim())
                                              .collection('cart')
                                              .where('imageUrl',
                                                  isEqualTo: widget.image)
                                              .get();

                                          if (docRef.docs.first['qty'] == '1') {
                                          } else {
                                            docRef.docs.first.reference.update({
                                              'qty': (int.parse(docRef
                                                          .docs.first['qty']) -
                                                      1)
                                                  .toString(),
                                              'subtotal': (double.parse(docRef
                                                          .docs
                                                          .first['subtotal']) -
                                                      double.parse(docRef
                                                          .docs.first['price']))
                                                  .toStringAsFixed(2),
                                            });
                                          }
                                        },
                                        child: const Icon(
                                          Icons.remove,
                                          size: 15,
                                        ),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                      Text(
                                        widget.qty,
                                        style: const TextStyle(
                                            color: Color(0xFF000000),
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                      InkWell(
                                        onTap: () async {
                                          final docRef = await FirebaseFirestore
                                              .instance
                                              .collection("users")
                                              .doc(AuthenticationHelper()
                                                  .userid
                                                  .trim())
                                              .collection('cart')
                                              .where('imageUrl',
                                                  isEqualTo: widget.image)
                                              .get();

                                          docRef.docs.first.reference.update({
                                            'qty': (int.parse(docRef
                                                        .docs.first['qty']) +
                                                    1)
                                                .toString(),
                                            'subtotal': (double.parse(docRef
                                                        .docs
                                                        .first['subtotal']) +
                                                    double.parse(docRef
                                                        .docs.first['price']))
                                                .toStringAsFixed(2),
                                          });
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  if (selectedItem.contains(widget.image)) {
                                    selectedItem.remove(widget.image);
                                  }
                                  final docRef = await FirebaseFirestore
                                      .instance
                                      .collection("users")
                                      .doc(AuthenticationHelper().userid.trim())
                                      .collection('cart')
                                      .where('imageUrl',
                                          isEqualTo: widget.image)
                                      .get();

                                  print(docRef);

                                  await docRef.docs.first.reference.delete();
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.041871921,
                                  width: MediaQuery.of(context).size.width *
                                      0.090666666,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: const Color(0xFFFF4646),
                                  ),
                                  child: InkWell(
                                    child: Center(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.024938,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.04933333,
                                        child: IgnorePointer(
                                          child: InkWell(
                                            onTap: () async {
                                              if (selectedItem
                                                  .contains(widget.image)) {
                                                selectedItem
                                                    .remove(widget.image);
                                              }
                                              final docRef =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("users")
                                                      .doc(
                                                          AuthenticationHelper()
                                                              .userid
                                                              .trim())
                                                      .collection('cart')
                                                      .where('imageUrl',
                                                          isEqualTo:
                                                              widget.image)
                                                      .get();

                                              print(docRef);

                                              await docRef.docs.first.reference
                                                  .delete();
                                            },
                                            child: SvgPicture.asset(
                                                'assets/icons/delete.svg',
                                                color: Colors.white,
                                                fit: BoxFit.fitHeight),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
