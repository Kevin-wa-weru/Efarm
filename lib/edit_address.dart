import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshamba/services/cruds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:searchfield/searchfield.dart';

class EditAdress extends StatefulWidget {
  const EditAdress(
      {Key? key,
      this.phone,
      this.pbox,
      this.description,
      this.region,
      required this.type})
      : super(key: key);
  final String? phone;
  final String? pbox;
  final String? description;
  final String? region;
  final String type;

  @override
  State<EditAdress> createState() => _EditAdressState();
}

class _EditAdressState extends State<EditAdress> {
  bool appIsLoading = false;

  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var descriptionController = TextEditingController();
  List<SearchFieldListItem> regions = [
    SearchFieldListItem('Arusha Region'),
    SearchFieldListItem('Dares Salaam Region'),
    SearchFieldListItem('Dodoma Region'),
    SearchFieldListItem('Geita Region'),
    SearchFieldListItem('Iringa Region'),
    SearchFieldListItem('Kagera Region'),
    SearchFieldListItem('Katavi Region'),
    SearchFieldListItem('Kigoma Region'),
    SearchFieldListItem('Kilimanjaro Region'),
    SearchFieldListItem('Lindi Region'),
    SearchFieldListItem('Manyara Region'),
    SearchFieldListItem('Mara Region'),
    SearchFieldListItem('Mbeya Region'),
    SearchFieldListItem('Mjini Magharibi Region'),
    SearchFieldListItem('Morogoro Region'),
    SearchFieldListItem('Mtwara Region'),
    SearchFieldListItem('Lindi Region'),
    SearchFieldListItem('Mwanza Region'),
    SearchFieldListItem('Njombe Region'),
    SearchFieldListItem('Pemba North Region'),
    SearchFieldListItem('Pemba South Region'),
  ];

  String selectedRegion = '';

  int maxLine = 7;

  @override
  void initState() {
    if (widget.description == null) {
      print('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
    } else {
      setState(() {
        phoneController = TextEditingController(text: widget.phone);
        addressController = TextEditingController(text: widget.pbox);
        descriptionController = TextEditingController(text: widget.description);
      });
    }
    super.initState();
  }

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
                      width: MediaQuery.of(context).size.width * 0.258,
                    ),
                    const Text(
                      'Your Address',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.023251,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8933333,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.0147783251,
                            width: MediaQuery.of(context).size.width * 0.04,
                            child: SvgPicture.asset('assets/icons/phone.svg',
                                color: const Color(0xFF39B54A),
                                fit: BoxFit.contain),
                          ),
                        ),
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
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Phone number',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: phoneController,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8933333,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextFormField(
                      style: const TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(
                              top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height *
                                0.0147783251,
                            width: MediaQuery.of(context).size.width * 0.04,
                            child: SvgPicture.asset('assets/icons/address.svg',
                                color: const Color(0xFF39B54A),
                                fit: BoxFit.contain),
                          ),
                        ),
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
                          horizontal: 20,
                        ),
                        filled: true,
                        hintText: 'Address',
                        hintStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: addressController,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6.0, vertical: 16),
                  child: Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: SearchField(
                        searchStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        suggestionStyle: const TextStyle(
                            color: Color(0xFF000000),
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                        hint: 'Region',
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
                              height: MediaQuery.of(context).size.height *
                                  0.0133990,
                              width: MediaQuery.of(context).size.width *
                                  0.030666666,
                              child: SvgPicture.asset('assets/icons/region.svg',
                                  color: const Color(0xFF39B54A),
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
                          selectedRegion = value.searchKey;
                        },
                        suggestions: regions),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8933333,
                  height: maxLine * 24.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                          horizontal: 20,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(bottom: 85.0),
                          child: SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.0133990,
                            width:
                                MediaQuery.of(context).size.width * 0.030666666,
                            child: SvgPicture.asset(
                                'assets/icons/description.svg',
                                color: const Color(0xFF39B54A),
                                fit: BoxFit.fitHeight),
                          ),
                        ),
                        filled: true,
                        hintText: 'Description eg near building',
                        hintStyle: const TextStyle(
                            color: Colors.black54,
                            fontFamily: 'PublicSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                      controller: descriptionController,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03527093,
                ),
                InkWell(
                  onTap: () async {
                    if (addressController.text.isEmpty ||
                        phoneController.text.isEmpty ||
                        descriptionController.text.isEmpty ||
                        selectedRegion == '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          "Complete all details",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )),
                      );
                    } else {
                      setState(() {
                        appIsLoading = true;
                      });

                      if (widget.type == 'update') {
                        final docRef = await FirebaseFirestore.instance
                            .collection("users")
                            .doc(AuthenticationHelper().userid.trim())
                            .collection('addresses')
                            .where('address', isEqualTo: widget.pbox)
                            .get();

                        await docRef.docs.first.reference.update({
                          'phone': phoneController.text,
                          'address': addressController.text,
                          'region': selectedRegion,
                          'descrription': descriptionController.text
                        });
                      } else {
                        final docRef = FirebaseFirestore.instance
                            .collection("users")
                            .doc(AuthenticationHelper().userid.trim())
                            .collection('addresses');

                        await docRef.add({
                          'phone': phoneController.text,
                          'address': addressController.text,
                          'region': selectedRegion,
                          'descrription': descriptionController.text
                        });
                      }

                      setState(() {
                        appIsLoading = false;
                      });

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                          "Address added",
                          style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'PublicSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        )),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.0615763,
                    width: MediaQuery.of(context).size.width * 0.7933333,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            colors: [
                              Color(0xFF7CD956),
                              Color(0xFF3EA334),
                            ])),
                    child: Center(
                      child: appIsLoading == true
                          ? const Center(
                              child: SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Add',
                              style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
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
