import 'package:eshamba/introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);

  int currentPage = 0;
  final int _numPages = 3;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF3EA334) : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark
            .copyWith(statusBarColor: Colors.transparent),
        child: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Introduction()));
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: SizedBox(
                    child: Image.asset(
                        height: MediaQuery.of(context).size.height * 0.092364,
                        width: MediaQuery.of(context).size.width * 0.2,
                        'assets/images/logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(
                    onTap: () {
                      print(currentPage);
                      if (currentPage == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Introduction()));
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w700,
                          fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.087438,
                      ),
                      SizedBox(
                        child: Image.asset(
                            height:
                                MediaQuery.of(context).size.height * 0.3275862,
                            width: MediaQuery.of(context).size.width * 0.70933,
                            'assets/images/farmer1.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.077586,
                      ),
                      const Center(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur ',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'adipiscing elit. Amet neque congue molestie ac',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'ut malesuada. Eleifend nunc rhoncus',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'elementum vestibulum mauris,',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.087438,
                      ),
                      SizedBox(
                        child: Image.asset(
                            height:
                                MediaQuery.of(context).size.height * 0.3275862,
                            width: MediaQuery.of(context).size.width * 0.70933,
                            'assets/images/farmer2.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.077586,
                      ),
                      const Center(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur ',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'adipiscing elit. Amet neque congue molestie ac',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'ut malesuada. Eleifend nunc rhoncus',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'elementum vestibulum mauris,',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.087438,
                      ),
                      SizedBox(
                        child: Image.asset(
                            height:
                                MediaQuery.of(context).size.height * 0.3275862,
                            width: MediaQuery.of(context).size.width * 0.70933,
                            'assets/images/farmer3.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.077586,
                      ),
                      const Center(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consectetur ',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'adipiscing elit. Amet neque congue molestie ac',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'ut malesuada. Eleifend nunc rhoncus',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'elementum vestibulum mauris,',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0, left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
