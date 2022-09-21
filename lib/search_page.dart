import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchfield/searchfield.dart';

class Searching extends StatefulWidget {
  const Searching({super.key});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  List<SearchFieldListItem> travelmode = [
    SearchFieldListItem('poetry farm'),
    SearchFieldListItem('poetry farm'),
    SearchFieldListItem('poetry farm'),
    SearchFieldListItem('poetry farm'),
    SearchFieldListItem('poetry farm'),
    SearchFieldListItem('poetry farm'),
    SearchFieldListItem('poetry farm'),
  ];
  String selectedmode = '';
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
          child: ListView(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.023891625,
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
                  width: MediaQuery.of(context).size.width * 0.168,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16),
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 80),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: SearchField(
                    focusNode: focusNode,
                    hint: 'Search',
                    searchInputDecoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Colors.transparent, width: 0),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 0.0133990,
                          width:
                              MediaQuery.of(context).size.width * 0.030666666,
                          child: SvgPicture.asset('assets/icons/search.svg',
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      filled: true,
                    ),
                    itemHeight: 50,
                    maxSuggestionsInViewPort: 6,
                    suggestionsDecoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onSuggestionTap: (value) {
                      selectedmode = value.searchKey;
                    },
                    suggestions: travelmode),
              ),
            ),
          ]),
        ));
  }
}
