import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailedBlog extends StatefulWidget {
  const DetailedBlog({Key? key}) : super(key: key);

  @override
  State<DetailedBlog> createState() => _DetailedBlogState();
}

class _DetailedBlogState extends State<DetailedBlog> {
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
                      width: MediaQuery.of(context).size.width * 0.368,
                    ),
                    const Text(
                      'Blogs',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0344827586,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CircleAvatar(
                        radius:
                            MediaQuery.of(context).size.height * 0.0306666666,
                        backgroundImage:
                            const AssetImage('assets/images/woman.jpg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        children: const [
                          SizedBox(
                            width: 300,
                            child: Text(
                              'Elizabeth Reck',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              width: 300,
                              child: Text(
                                '23 March 2022, 11:00pm',
                                style: TextStyle(
                                    color: Color(0xFF9F9F9F),
                                    fontFamily: 'PublicSans',
                                    fontWeight: FontWeight.w300,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.039408866,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: const [
                      Text(
                        'Learn to Wheat',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02155172,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.24508620,
                  width: MediaQuery.of(context).size.width * 0.8933333333333333,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0),
                        ),
                        child: Image.asset('assets/images/veges.jpg')),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.064039408,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width *
                              0.8933333333333333,
                          child: const Text(
                            'The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web site',
                            style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'PublicSans',
                                fontWeight: FontWeight.w500,
                                height: 2,
                                fontSize: 14),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.033251,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
