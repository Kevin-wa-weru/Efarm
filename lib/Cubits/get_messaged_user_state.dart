part of 'get_messaged_user_cubit.dart';

@freezed
class GetMessagedUserState with _$GetMessagedUserState {
  const factory GetMessagedUserState.initial() = _Initial;
  const factory GetMessagedUserState.loading() = _Loading;
  const factory GetMessagedUserState.loaded(List messagedUsers) = _Loaded;
  const factory GetMessagedUserState.error(String error) = _Error;
}
