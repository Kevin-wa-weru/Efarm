import 'dart:async';

import 'package:eshamba/services/local_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SavedLocation extends StatefulWidget {
  const SavedLocation({Key? key}) : super(key: key);

  @override
  State<SavedLocation> createState() => _SavedLocationState();
}

class _SavedLocationState extends State<SavedLocation> {
  List<LocationInfo>? allsavedLocations;

  Future getAllSavedLocations() async {
    LocalDB locationAddress = LocalDB();
    locationAddress
        .initializeDatabase()
        .then((value) => debugPrint('====DATABASE INITIALISED'));

    List<LocationInfo> savedLocations =
        await locationAddress.getSavedLocations();

    if (savedLocations.isEmpty) {
      setState(() {
        allsavedLocations = [];
      });
    } else {
      setState(() {
        allsavedLocations = savedLocations;
      });
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: getAllSavedLocations(),
          builder: (context, snapshot) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0581773399,
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
                      width: MediaQuery.of(context).size.width * 0.068,
                    ),
                    const Text(
                      'Saved Places',
                      style: TextStyle(
                          color: Color(0xFF000000),
                          fontFamily: 'PublicSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                allsavedLocations == null
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                            itemCount: allsavedLocations!.length,
                            itemBuilder: ((context, index) => LOcationListTile(
                                  location: allsavedLocations![index]
                                      .address
                                      .toString(),
                                ))),
                      )
              ],
            );
          }),
    );
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
        onTap: () {},
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
