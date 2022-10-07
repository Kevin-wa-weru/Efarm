import 'package:eshamba/Cubits/get_blogs_cubit.dart';
import 'package:eshamba/detailed_blog.dart';
import 'package:eshamba/homepage.dart';
import 'package:eshamba/models/data.dart';
import 'package:eshamba/search_blogs.dart';
import 'package:eshamba/search_page.dart';
import 'package:eshamba/view_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Blogs extends StatefulWidget {
  const Blogs({Key? key}) : super(key: key);

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  String? selectedOrder;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            const Center(
              child: Text(
                'Blogs',
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontFamily: 'PublicSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02933333,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchBlogs()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0591133,
                    width: MediaQuery.of(context).size.width * 0.904,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 22.0, right: 17),
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.0233990,
                            width:
                                MediaQuery.of(context).size.width * 0.050666666,
                            child: SvgPicture.asset('assets/icons/search.svg',
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        const Text(
                          'Search',
                          style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02339901,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Recent Posts',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewAllItems(
                                        selectedCategory: 'blogs',
                                      )));
                        },
                        child: Row(
                          children: const [
                            Text(
                              'View all',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02955665024,
                ),
                BlocBuilder<GetBlogsCubit, GetBlogsState>(
                  builder: (context, state) {
                    return state.when(
                        initial: () {
                          return const SingleHomePageBlogLoading();
                        },
                        loading: () {
                          return const SingleHomePageBlogLoading();
                        },
                        loaded: (blogs) {
                          return Column(
                            children: blogs
                                .map((e) => SingleBlog(
                                      blog: e,
                                    ))
                                .toList(),
                          );
                        },
                        error: (String message) => Center(
                              child: Text(message),
                            ));
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0332512315,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ViewAllItems(
                                        selectedCategory: 'blogs',
                                      )));
                        },
                        child: Row(
                          children: const [
                            Text(
                              'View all',
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0332512315,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    color: Colors.transparent,
                    height: MediaQuery.of(context).size.height * 0.26231527,
                    child: BlocBuilder<GetBlogsCubit, GetBlogsState>(
                      builder: (context, state) {
                        return state.when(
                            initial: () {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cateogry.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return const SingleHomePageBlogLoading();
                                },
                              );
                            },
                            loading: () {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: cateogry.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return const SingleHomePageBlogLoading();
                                },
                              );
                            },
                            loaded: (blogs) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: blogs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SingleHomePageBlog(
                                    blog: blogs[index],
                                  );
                                },
                              );
                            },
                            error: (String message) => Center(
                                  child: Text(message),
                                ));
                      },
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

class SingleBlog extends StatelessWidget {
  const SingleBlog({
    Key? key,
    required this.blog,
  }) : super(key: key);
  final Map<String, dynamic> blog;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailedBlog(
                        blog: blog,
                      )));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.13300492,
                width: MediaQuery.of(context).size.width * 0.2586666666,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      child: Image.network(blog['image'])),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.594666666,
                    color: Colors.transparent,
                    child: Text(
                      blog['title'],
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.594666666,
                      color: Colors.transparent,
                      child: Text(
                        blog['description'],
                        style: const TextStyle(
                            color: Color(0xFF8D98AF),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w400,
                            fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
