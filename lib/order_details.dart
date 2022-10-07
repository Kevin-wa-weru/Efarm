import 'package:eshamba/edit_address.dart';
import 'package:eshamba/payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails(
      {Key? key,
      required this.address,
      required this.items,
      required this.ordernote,
      required this.payment,
      required this.shippingfee,
      required this.status,
      required this.total,
      required this.date,
      required this.refernce})
      : super(key: key);
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
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final descriptionController = TextEditingController();
  int maxLine = 7;
  late bool hasAddress = false;
  late Map<String, dynamic> orderaddress = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'Order Details',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return SingleCheckoutItem(
                    name: widget.items[index]['name'],
                    price: widget.items[index]['subtotal'],
                    qty: widget.items[index]['qty'],
                    image: widget.items[index]['imageUrl'],
                  );
                },
              ),
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
                        child: Text(
                          '${widget.items.length} Item(s), Total: \$${widget.total}',
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        )),
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
                  Column(
                    children: [
                      const SizedBox(
                        height: 19,
                      ),
                      SingleAddress(
                        description: widget.address['description'],
                        pbox: widget.address['pbox'],
                        phone: widget.address['phone'],
                        region: widget.address['region'],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.0463546,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'SubTotal (${widget.items.length} item)',
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
                          '\$${widget.total}',
                          style: const TextStyle(
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
                          'Shipping fee',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          widget.shippingfee,
                          style: const TextStyle(
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
                          child: Text(
                            '\$${(double.parse(widget.total) + double.parse(widget.shippingfee)).toString()} ',
                            style: const TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )),
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
                children: const [
                  Text(
                    '',
                    style: TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
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
