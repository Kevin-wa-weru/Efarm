import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/detailed_blog.dart';
import 'package:eshamba/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchComplete extends StatefulWidget {
  const SearchComplete(
      {super.key,
      required this.selectedCategory,
      required this.selectedSuggestion,
      required this.selectedBlogby});
  final String selectedCategory;
  final String selectedSuggestion;
  final String selectedBlogby;
  @override
  State<SearchComplete> createState() => _SearchCompleteState();
}

class _SearchCompleteState extends State<SearchComplete> {
  resolveCategoryWidget(String category, String query, String blogby) {
    print(category);
    print(query);
    print(blogby);
    if (category == 'products') {
      return Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('productName', isEqualTo: query)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                print(snapshot);
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
                  .collection('farms')
                  .where('name', isEqualTo: query)
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
                    // .where('title', isEqualTo: query)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SingleSearchBlog(
                          blog: snapshot.data.docs[index].data(),
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                }));
      } else {
        return Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('blogs')
                  // .where('postedBy', isEqualTo: query)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SingleSearchBlog(
                        blog: snapshot.data.docs[index].data(),
                      );
                    },
                  );
                } else {
                  return Container();
                }
              }),
        );
      }
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
                const Text(
                  'Search Results',
                  style: TextStyle(
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
            resolveCategoryWidget(widget.selectedCategory,
                widget.selectedSuggestion, widget.selectedBlogby)
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
