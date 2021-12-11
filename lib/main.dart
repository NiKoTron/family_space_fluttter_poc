import 'dart:async';

import 'package:family_space_flutter/bloc/home/home_bloc.dart';
import 'package:family_space_flutter/bloc/home/home_event.dart';
import 'package:family_space_flutter/bloc/login/login_bloc.dart';
import 'package:family_space_flutter/bloc/root/root_bloc.dart';
import 'package:family_space_flutter/bloc/root/root_state.dart';
import 'package:family_space_flutter/pages/home_page.dart';
import 'package:family_space_flutter/pages/login_page.dart';
import 'package:family_space_flutter/pages/welcome_page.dart';
import 'package:family_space_flutter/repositories/auth/auth_repository.dart';
import 'package:family_space_flutter/repositories/auth/shared_prefs_auth_repository.dart';
import 'package:family_space_flutter/repositories/location_repository.dart/location_repository.dart';
import 'package:family_space_flutter/repositories/location_repository.dart/plugin_location_repository.dart';
import 'package:family_space_flutter/repositories/participants/mock_participants_repository.dart';
import 'package:family_space_flutter/repositories/participants/participants_repository.dart';
import 'package:family_space_flutter/repositories/permissions/permissions_repository.dart';
import 'package:family_space_flutter/repositories/permissions/plugin_permissions_repository.dart';
import 'package:family_space_flutter/repositories/tracks/mock_track_repository.dart';
import 'package:family_space_flutter/repositories/tracks/tracks_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        RepositoryProvider<PermissionsRepository>(
            create: (_) => PluginPermissionsRepository()),
        RepositoryProvider<LocationRepository>(
            create: (_) => PluginLocationRepository(Location())),
        RepositoryProvider<TracksRepository>(
            create: (_) => MockTrackRepository()),
        RepositoryProvider<ParticipantsRepository>(
            create: (_) => MockParticipantsRepository()),
        ChangeNotifierProvider<AuthRepository>(
            create: (_) => SharedPreferencesAuthRepository()),
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RootBloc>(
      create: (_) => RootBloc(authRepository: context.read<AuthRepository>()),
      child: MaterialApp(
        home: BlocBuilder<RootBloc, RootState>(
          builder: (_, state) {
            return state.map(
                unauthorized: _unAuthorizedFlow,
                authorized: _authorizedFlow,
                init: _splashScreen);
          },
        ),
      ),
    );
  }

  Widget _authorizedFlow(value) => BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(
          authRepository: context.read<AuthRepository>(),
          locationRepository:
              RepositoryProvider.of<LocationRepository>(context),
          tracksRepository: RepositoryProvider.of<TracksRepository>(context),
          participantsRepository:
              RepositoryProvider.of<ParticipantsRepository>(context),
        )..add(const HomeEvent.init()),
        child: const HomePage(),
      );

  Widget _splashScreen(value) => SizedBox.expand(
        child: Image.asset(
          'assets/images/backdrop_720_000.jpg',
          fit: BoxFit.cover,
        ),
      );

  Widget _unAuthorizedFlow(value) => const WelcomePage();
}
