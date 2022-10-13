import 'package:eshamba/Cubits/get_blogs_cubit.dart';
import 'package:eshamba/Cubits/get_farms_cubit.dart';
import 'package:eshamba/Cubits/get_messaged_user_cubit.dart';
import 'package:eshamba/Cubits/get_nearest_drivers_cubit.dart';
import 'package:eshamba/Cubits/get_posted_products_cubit.dart';
import 'package:eshamba/decision.dart';
import 'package:eshamba/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// id 'com.android.application'
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    late String userid = '';

    if (user == null) {
      userid = '';
    } else {
      userid = user.uid;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (contex) => GetPostedProductsCubit(),
        ),
        BlocProvider(
          create: (contex) => GetFarmsCubit(),
        ),
        BlocProvider(
          create: (contex) => GetBlogsCubit(),
        ),
        BlocProvider(
          create: (contex) => GetMessagedUserCubit(),
        ),
        BlocProvider(
          create: (contex) => GetNearestDriversCubit(),
        ),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: userid == '' ? const Onboarding() : const Decision(),
      ),
    );
  }
}
