import 'package:freezed_annotation/freezed_annotation.dart';

part 'root_event.freezed.dart';

@freezed
class RootEvent with _$RootEvent {
  const factory RootEvent.signIn(String authToken) = SignInRootEvent;
  const factory RootEvent.signOut() = SignOutRootEvent;
}
