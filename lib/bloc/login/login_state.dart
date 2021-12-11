import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required String phoneNumber,
  }) = _LoginState;
}

extension LoginStateExtension on LoginState {
  bool get isPhoneNumberValid => phoneNumber.length > 11;
}
