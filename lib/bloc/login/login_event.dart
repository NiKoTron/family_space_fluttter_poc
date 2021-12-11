import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
class LoginEvent {
  const factory LoginEvent.enterPhone(String phoneNumber) =
      EnterPhoneLoginEvent;
  const factory LoginEvent.login() = LoginLoginEvent;
}
