import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/detailed_blog.dart';
import 'package:eshamba/homepage.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ViewAllItems extends StatefulWidget {
  const ViewAllItems({
    super.key,
    required this.selectedCategory,
  });
  final String selectedCategory;

  @override
  State<ViewAllItems> createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> {
  resolveCategoryWidget(
    String category,
  ) {
    if (category == 'products') {
      return Expanded(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SingleSearchProduct(
                          product: snapshot.data.docs[index].data(),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }));
    }

    if (category == 'farms') {
      return Expanded(
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('farms').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SingleFarm(
                          farm: snapshot.data.docs[index].data(),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }));
    }

    if (category == 'blogs') {
      return Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('blogs')
                  // .where('title', isEqualTo: query)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SingleSearchBlog(
                          blog: snapshot.data.docs[index].data(),
                        ),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.053891625,
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
                  width: MediaQuery.of(context).size.width * 0.278,
                ),
                Text(
                  widget.selectedCategory,
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.003891625,
            ),
            resolveCategoryWidget(
              widget.selectedCategory,
            )
          ]),
        ));
  }
}

class SingleSearchBlog extends StatelessWidget {
  const SingleSearchBlog({
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
              height: MediaQuery.of(context).size.height * 0.30231527,
              width: MediaQuery.of(context).size.width * 0.5386666,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.187783251,
                    width: MediaQuery.of(context).size.width,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          child: Hero(
                              tag: blog['image'],
                              child: Image.network(blog['image']))),
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
                          child: Hero(
                            tag: blog['title'],
                            child: Text(
                              blog['title'],
                              style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.18),
                            ),
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

class SingleSearchProduct extends StatefulWidget {
  const SingleSearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Map<String, dynamic> product;

  @override
  State<SingleSearchProduct> createState() => _SingleSearchProductState();
}

class _SingleSearchProductState extends State<SingleSearchProduct> {
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
              height: MediaQuery.of(context).size.height * 0.307093596,
              width: MediaQuery.of(context).size.width * 0.893333333,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.194433497,
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
