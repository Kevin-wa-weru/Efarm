import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_blogs_state.dart';
part 'get_blogs_cubit.freezed.dart';

class GetBlogsCubit extends Cubit<GetBlogsState> {
  GetBlogsCubit() : super(const GetBlogsState.initial());

  List allBlogs = [];

  getBlogs() async {
    emit(const GetBlogsState.loading());
    FirebaseFirestore.instance
        .collection("blogs")
        .doc()
        .snapshots()
        .listen((event) async {
      var blogData = await FirebaseFirestore.instance.collection("blogs").get();

      for (var blog in blogData.docs) {
        allBlogs.add(blog.data());
      }

      emit(GetBlogsState.loaded(allBlogs));
      print(allBlogs);
      allBlogs = [];
    });
  }
}
