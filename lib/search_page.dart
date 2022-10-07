import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/homepage.dart';
import 'package:eshamba/searcch_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Searching extends StatefulWidget {
  const Searching({super.key});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  final searchController = TextEditingController();

  String selectedCategory = '';
  String selectedSuggestion = '';
  String selectedBlogby = '';

  FocusNode focusNode = FocusNode();

  bool hasTappedonSearch = false;

  List predictions = [];

  Future<void> searchAutoComplete(String query) async {
    setState(() {
      predictions = [];
    });

    var productsRef = await FirebaseFirestore.instance
        .collection("products")
        .where("caseSearch", arrayContains: query)
        .get();

    var blogsRef = await FirebaseFirestore.instance
        .collection("blogs")
        .where("caseSearch", arrayContains: query)
        .get();

    var farmssRef = await FirebaseFirestore.instance
        .collection("farms")
        .where("caseSearch", arrayContains: query)
        .get();

    for (var item in productsRef.docs) {
      setState(() {
        predictions.add({
          'suggetion': item['productName'],
          'docid': item.id,
          'category': 'products'
        });
      });
    }

    for (var item in blogsRef.docs) {
      setState(() {
        predictions.add({
          'suggetion': item['postedBy'],
          'docid': item.id,
          'category': 'blogs',
          'by': 'poster'
        });
        predictions.add({
          'suggetion': item['title'],
          'docid': item.id,
          'category': 'blogs',
          'by': 'title'
        });
      });
    }

    for (var item in farmssRef.docs) {
      setState(() {
        predictions.add(
            {'suggetion': item['name'], 'docid': item.id, 'category': 'farms'});
      });
    }
  }

  resolveCategoryWidget(String category, String query, String blogby) {
    if (category == 'products') {
      return Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('productName', isEqualTo: selectedSuggestion)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleTopProduct(
                        product: snapshot.data.docs[index].data(),
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
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('productName', isEqualTo: selectedSuggestion)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleFarm(
                        farm: snapshot.data.docs[index].data(),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }));
    }

    if (category == 'blogs') {
      if (blogby == 'title') {
        return Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('blogs')
                    // .where('title', isEqualTo: selectedSuggestion)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleFarm(
                          farm: snapshot.data.docs[index].data(),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }));
      } else {
        Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('blogs')
                    .where('postedBy', isEqualTo: selectedSuggestion)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleFarm(
                          farm: snapshot.data.docs[index].data(),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }));
      }
    }
  }

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

//   setSearchParam(String caseNumber) {
//   List<String> caseSearchList = List();
//   String temp = "";
//   for (int i = 0; i < caseNumber.length; i++) {
//     temp = temp + caseNumber[i];
//     caseSearchList.add(temp);
//   }
//   return caseSearchList;
// }

  resolveTypeOfStreeam(String category, String query) async {
    if (category == 'products') {
      return FirebaseFirestore.instance
          .collection('products')
          .where('productName', isEqualTo: selectedSuggestion)
          .snapshots();
    }

    if (category == 'blogs') {
      var result = await FirebaseFirestore.instance
          .collection('blogs')
          .where('postedBy', isEqualTo: selectedSuggestion)
          .get();

      if (result.docs.isEmpty) {
        return FirebaseFirestore.instance
            .collection('blogs')
            .where('title', isEqualTo: selectedSuggestion)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('blogs')
            .where('postedBy', isEqualTo: selectedSuggestion)
            .snapshots();
      }
    }

    if (selectedCategory == 'farms') {
      return FirebaseFirestore.instance
          .collection('farms')
          .where('name', isEqualTo: selectedSuggestion)
          .snapshots();
    }
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
                  width: MediaQuery.of(context).size.width * 0.328,
                ),
                const Text(
                  'Search',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.013891625,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8933333,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    focusNode: focusNode,
                    style: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: const Color(0xFFEFEFEF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0.2),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 2),
                        borderRadius: BorderRadius.circular(33),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical:
                            MediaQuery.of(context).size.height * 0.0197339,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(
                            top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.0147783251,
                          width: MediaQuery.of(context).size.width * 0.04,
                          child: SvgPicture.asset('assets/icons/search.svg',
                              color: const Color(0xFF39B54A),
                              fit: BoxFit.contain),
                        ),
                      ),
                      filled: true,
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    onChanged: (value) {
                      searchAutoComplete(value);
                    },
                    controller: searchController,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: predictions.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (predictions[index]['category'] == 'blogs') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchComplete(
                                              selectedSuggestion:
                                                  predictions[index]
                                                      ['suggetion'],
                                              selectedCategory:
                                                  predictions[index]
                                                      ['category'],
                                              selectedBlogby: predictions[index]
                                                  ['by'],
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchComplete(
                                              selectedSuggestion:
                                                  predictions[index]
                                                      ['suggetion'],
                                              selectedCategory:
                                                  predictions[index]
                                                      ['category'],
                                              selectedBlogby: '',
                                            )));
                              }
                            });
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.0372413793,
                                    width: MediaQuery.of(context).size.width *
                                        0.03866666,
                                    child: SvgPicture.asset(
                                        'assets/icons/search.svg',
                                        color: Colors.black54,
                                        fit: BoxFit.contain),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      color: Colors.transparent,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Text(
                                        predictions[index]['suggetion'],
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontFamily: 'PublicSans',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  height: 1,
                                  color: Colors.black12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))),
            )
          ]),
        ));
  }
}
