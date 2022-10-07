// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_messaged_user_state.dart';
part 'get_messaged_user_cubit.freezed.dart';

class GetMessagedUserCubit extends Cubit<GetMessagedUserState> {
  GetMessagedUserCubit() : super(const GetMessagedUserState.initial());
  late List allMessagedUser = [];

  listenToMessages() async {
    emit(const GetMessagedUserState.loading());
    //listend to changes in user doc
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final docRef = FirebaseFirestore.instance
        .collection("chats")
        .doc(user!.uid)
        .collection('messages');
    docRef.snapshots().listen(
      (event) async {
        for (var change in event.docChanges) {
          print('Chaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaange');
          var userInfo = await FirebaseFirestore.instance
              .collection("chats")
              .doc(user.uid)
              .collection("messages")
              .get();

          List allrecentMessages = userInfo.docs;

          for (var userinfo in allrecentMessages) {
            allMessagedUser.add(userinfo);
          }
          print('Herrooooooooo');
          print(allrecentMessages.first['message']);

          emit(GetMessagedUserState.loaded(allrecentMessages));
        }
      },
      onError: (error) => debugPrint("Listen failed: $error"),
    );
  }
}
