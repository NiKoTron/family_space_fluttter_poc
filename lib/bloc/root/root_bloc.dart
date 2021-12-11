import 'dart:async';

import 'package:family_space_flutter/bloc/root/root_event.dart';
import 'package:family_space_flutter/bloc/root/root_state.dart';
import 'package:family_space_flutter/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final AuthRepository authRepository;
  RootBloc({required this.authRepository}) : super(const RootState.init()) {
    authRepository.getToken().then(
      (token) async {
        await _fireAuthEvent(token);
        authRepository.addListener(_authListener);
      },
    );

    on<SignInRootEvent>((event, emit) {
      emit(RootState.authorized(event.authToken));
    });
    on<SignOutRootEvent>((event, emit) {
      emit(const RootState.unauthorized());
    });
  }

  void _authListener() {
    authRepository.getToken().then(_fireAuthEvent);
  }

  FutureOr _fireAuthEvent(String? token) {
    if (token != null) {
      add(RootEvent.signIn(token));
    } else {
      add(const RootEvent.signOut());
    }
  }
}
