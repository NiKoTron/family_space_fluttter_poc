import 'package:freezed_annotation/freezed_annotation.dart';

part 'root_state.freezed.dart';

@freezed
class RootState with _$RootState {
  const factory RootState.unauthorized() = _UnauthorizedRootState;
  const factory RootState.authorized(String token) = _AuthorizedRootState;
  const factory RootState.init() = _InitRootState;
}
