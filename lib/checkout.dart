import 'package:eshamba/edit_address.dart';
import 'package:eshamba/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final descriptionController = TextEditingController();
  int maxLine = 7;
  late bool hasAddress = false;
  late Map<String, dynamic> orderaddress = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
        child: InkWell(
          onTap: () {
            if (hasAddress == false) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                  "You have not added an address",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )),
              );
            } else if (descriptionController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text(
                  "Add some order note ",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                )),
              );
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(
                            order: orderaddress,
                            shippingfee: 30,
                            orderNote: descriptionController.text,
                          )));
            }
          },
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
            child: const Center(
              child: Text(
                'Proceed to Pay',
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
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.054679802,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.053333333,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.288,
                  ),
                  const Text(
                    'Checkout',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(AuthenticationHelper().userid.trim())
                      .collection('cart')
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleCheckoutItem(
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
                  }),
              Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.black12,
                    width: MediaQuery.of(context).size.width * 0.82333333,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50.0, top: 14),
                    child: Align(
                      alignment: Alignment.centerRight,
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
                                '${snapshot.data.docs.length} Item(s), Total: \$$total',
                                style: const TextStyle(
                                    color: Color(0xFF000000),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 50.0, top: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Price dropped, saved:\$00.00',
                        style: TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(AuthenticationHelper().userid.trim())
                          .collection('addresses')
                          .snapshots(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        } else {
                          hasAddress = true;
                          orderaddress = {
                            'description':
                                snapshot.data!.docs.first['descrription'],
                            'pbox': snapshot.data!.docs.first['address'],
                            'phone': snapshot.data!.docs.first['phone'],
                            'region': snapshot.data!.docs.first['region'],
                          };

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 19,
                                  ),
                                  SingleAddress(
                                    description: snapshot.data!.docs[index]
                                        ['descrription'],
                                    pbox: snapshot.data!.docs[index]['address'],
                                    phone: snapshot.data!.docs[index]['phone'],
                                    region: snapshot.data!.docs[index]
                                        ['region'],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }),
                  DottedBorder(
                    color: Colors.black12,
                    strokeWidth: 1,
                    dashPattern: const [10, 6],
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditAdress(
                                      type: 'new',
                                    )));
                      },
                      child: Container(
                          width:
                              MediaQuery.of(context).size.width * 0.873333333,
                          height:
                              MediaQuery.of(context).size.height * 0.092364532,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add),
                                Text(
                                  'Address',
                                  style: TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0463546,
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Add Order Note',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12, width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8933333,
                    height: MediaQuery.of(context).size.height * 0.12931034,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextFormField(
                        maxLines: maxLine,
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
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.transparent, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.0197339,
                            horizontal: 20,
                          ),
                          filled: true,
                          hintText: 'Write here..',
                          hintStyle: const TextStyle(
                              color: Color(0xFFB8B8B8),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: descriptionController,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
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

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  'SubTotal (${snapshot.data.docs.length} item)',
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Text(
                                  '\$$total',
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Shipping fee',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Text(
                          '\$30',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Total:',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
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
                                  allsubTotals
                                      .add(double.parse(doc['subtotal']));
                                }

                                total = allsubTotals
                                    .reduce((value, current) => value + current)
                                    .toStringAsFixed(2);

                                return Text(
                                  '\$${(double.parse(total) + 30.00).toString()} ',
                                  style: const TextStyle(
                                      color: Color(0xFF000000),
                                      fontFamily: 'PublicSans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
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

class SingleAddress extends StatelessWidget {
  const SingleAddress({
    Key? key,
    required this.region,
    required this.description,
    required this.phone,
    required this.pbox,
  }) : super(key: key);

  final String region;
  final String description;
  final String phone;
  final String pbox;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                'Delivery address',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w500,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditAdress(
                                    phone: phone,
                                    pbox: pbox,
                                    description: description,
                                    region: region,
                                    type: 'update',
                                  )));
                    },
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 19,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.893333333,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12, width: 1),
            borderRadius: BorderRadius.circular(4),
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0, top: 4),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      region,
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.837333333,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0, top: 4),
                        child: Text(
                          description,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SingleCheckoutItem extends StatelessWidget {
  const SingleCheckoutItem({
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, top: 10),
          child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.104679802,
                    width: MediaQuery.of(context).size.width * 0.21333333,
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.490666666,
                        color: Colors.transparent,
                        child: Text(
                          name,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width:
                              MediaQuery.of(context).size.width * 0.490666666,
                          color: Colors.transparent,
                          child: Text(
                            '\$$price',
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.520666666,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'QTY: $qty',
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 1,
          color: Colors.black12,
          width: MediaQuery.of(context).size.width * 0.82333333,
        ),
      ],
    );
  }
}
