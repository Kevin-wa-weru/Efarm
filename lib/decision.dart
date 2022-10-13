import 'package:eshamba/homepage.dart';
import 'package:eshamba/onboarding.dart';
import 'package:eshamba/screens/driver/driver_homePage.dart';
import 'package:eshamba/vendorpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Decision extends StatefulWidget {
  const Decision({
    Key? key,
  }) : super(key: key);

  @override
  State<Decision> createState() => _DecisionState();
}

class _DecisionState extends State<Decision> {
  late String user = '';

  Widget resolveUserType() {
    if (user == 'user') {
      return const HomePage();
    }

    if (user == 'Vendor') {
      // return const Vendor();

      return const Vendorprofile();
    }

    if (user == 'driver') {
      return const DriverHomePage();

      // return const DriverProfileadd();
    }
    return const Onboarding();
  }

  @override
  void initState() {
    super.initState();

    getUserType();
  }

  getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? stringValue = prefs.getString('stringValue');
    print(stringValue);

    setState(() {});
    user = stringValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: resolveUserType(),
    );
  }
}
