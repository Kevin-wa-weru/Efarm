import 'package:eshamba/services/auto_complete.dart';
import 'package:eshamba/services/local_database.dart';
import 'package:eshamba/services/network_utilities.dart';
import 'package:eshamba/services/place_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({
    super.key,
  });

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  final searchController = TextEditingController();
  String googleApikey = "AIzaSyAmQ9UeFrn_LxD4SzDSYlCHcVIj0V2qbt0";

  List<AutoCompletePrediction> placePreditions = [];

  Future<void> placeAutoComplete(String query) async {
    Uri uri =
        Uri.https('maps.googleapis.com', 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": googleApikey,
    });

    String? response = await NetWorkUtility.fetchUrl(uri);

    if (response != null) {
      PlaceAutoCompleteResponsed result =
          PlaceAutoCompleteResponsed.parseAutoCompleteResult(response);

      if (result.prediction != null) {
        setState(() {
          placePreditions = result.prediction!;
        });
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
              height: MediaQuery.of(context).size.height * 0.063891625,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.053333333,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context, 'Starting Point'),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.028,
                ),
                const Text(
                  'Set your start location',
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
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: 'PublicSans',
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isDense: true,
                    fillColor: const Color(0xFFEFEFEF),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.0197339,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                          top: 14, right: 14.0, bottom: 14.0, left: 24.5),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height * 0.0147783251,
                        width: MediaQuery.of(context).size.width * 0.04,
                        child: SvgPicture.asset('assets/icons/search.svg',
                            fit: BoxFit.contain),
                      ),
                    ),
                    filled: true,
                    hintText: 'search location',
                    hintStyle: const TextStyle(
                        color: Color(0xFF000000),
                        fontFamily: 'PublicSans',
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  onChanged: (value) {
                    placeAutoComplete(value);
                  },
                  controller: searchController,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10, right: 25),
              child: InkWell(
                onTap: () async {
                  Navigator.pop(context, 'mylocation');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFEFEFEF),
                  ),
                  width: MediaQuery.of(context).size.width * 0.674666666,
                  height: MediaQuery.of(context).size.height * 0.054334975,
                  child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0372413793,
                                width: MediaQuery.of(context).size.width *
                                    0.03866666,
                                child: SvgPicture.asset(
                                    'assets/icons/location.svg',
                                    color: Colors.black,
                                    fit: BoxFit.contain),
                              ),
                            ),
                            const Text(
                              'Use my current location',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Color(0xFF000000),
                                  fontFamily: 'PublicSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1,
                color: Colors.black12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: placePreditions.length,
                  itemBuilder: ((context, index) => LOcationListTile(
                        location: placePreditions[index].description!,
                      ))),
            )
          ]),
        ));
  }
}

class LOcationListTile extends StatelessWidget {
  const LOcationListTile({
    Key? key,
    required this.location,
  }) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        onTap: () {
          LocalDB locationAddress = LocalDB();
          locationAddress
              .initializeDatabase()
              .then((value) => debugPrint('====DATABASE INITIALISED'));
          var locationInfo = LocationInfo(address: location);

          locationAddress.insertSavedLocation(locationInfo);
          Navigator.pop(context, location);
        },
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0372413793,
                  width: MediaQuery.of(context).size.width * 0.03866666,
                  child: SvgPicture.asset('assets/icons/location.svg',
                      color: Colors.black54, fit: BoxFit.contain),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      location,
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
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 1,
                color: Colors.black12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
