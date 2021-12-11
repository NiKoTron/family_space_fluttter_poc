import 'dart:async';

import 'package:family_space_flutter/bloc/login/login_event.dart';
import 'package:family_space_flutter/bloc/login/login_state.dart';
import 'package:family_space_flutter/repositories/auth/auth_repository.dart';
import 'package:family_space_flutter/repositories/permissions/permissions_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PermissionsRepository permissionRepository;
  final AuthRepository authRepository;
  LoginBloc({
    required this.permissionRepository,
    required this.authRepository,
  }) : super(const LoginState(
          phoneNumber: '',
        )) {
    on<EnterPhoneLoginEvent>(_onPhoneEntered);
    on<LoginLoginEvent>(_onLoginEvent);
  }

  FutureOr<void> _onLoginEvent(
      LoginLoginEvent event, Emitter<LoginState> emit) async {
    final isLocationPermissionGranted = await permissionRepository
        .isLocationPermitionGranted(requestIfNeeded: true);

    if (isLocationPermissionGranted) {
      authRepository.setToken('my_awesome_fake_token');
    }
  }

  FutureOr<void> _onPhoneEntered(
      EnterPhoneLoginEvent event, Emitter<LoginState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }
}
