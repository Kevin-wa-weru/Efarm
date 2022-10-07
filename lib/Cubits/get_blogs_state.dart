part of 'get_blogs_cubit.dart';

@freezed
class GetBlogsState with _$GetBlogsState {
  const factory GetBlogsState.initial() = _Initial;
  const factory GetBlogsState.loading() = _Loading;
  const factory GetBlogsState.loaded(List allBlogs) = _Loaded;
  const factory GetBlogsState.error(String error) = _Error;
}
