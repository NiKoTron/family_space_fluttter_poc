import 'dart:async';

import 'package:family_space_flutter/bloc/home/home_event.dart';
import 'package:family_space_flutter/bloc/home/home_state.dart';
import 'package:family_space_flutter/model/banner.dart';
import 'package:family_space_flutter/repositories/auth/auth_repository.dart';
import 'package:family_space_flutter/repositories/location_repository.dart/location_repository.dart';
import 'package:family_space_flutter/repositories/participants/participants_repository.dart';
import 'package:family_space_flutter/repositories/tracks/tracks_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocationRepository locationRepository;
  final TracksRepository tracksRepository;
  final ParticipantsRepository participantsRepository;
  final AuthRepository authRepository;

  static final _banners = List.generate(
    6,
    (index) => const Banner(
        title: 'Premium — подписка',
        description: 'Еще больше уведомлений для полной безопасности'),
  );

  HomeBloc({
    required this.tracksRepository,
    required this.locationRepository,
    required this.participantsRepository,
    required this.authRepository,
  }) : super(
          HomeState(
            mapProvider: MapProvider.googleMaps,
            banners: _banners,
          ),
        ) {
    //init async data;
    locationRepository
        .currentLocationStream()
        .listen((location) => add(HomeEvent.updateMyLocation(location)));

    //event handlers
    on<InitHomeEvent>((event, emit) {
      tracksRepository
          .getTrack()
          .then((value) => emit(state.copyWith(displayedTrack: value)));
      tracksRepository
          .getHomeLocation()
          .then((value) => emit(state.copyWith(homeLocation: value)));
      tracksRepository.getHomeAddress().then((value) => emit(state.copyWith(
            currentPosition: 'Сейчас дома',
            homeGeocoded: value,
          )));
      participantsRepository
          .getParticipants()
          .then((value) => emit(state.copyWith(participants: value)));
    });

    on<UpdateMyLocationHomeEvent>((event, emit) {
      emit(state.copyWith(myLocation: event.location));
    });

    on<SetMapProviderHomeEvent>(
        (event, emit) => emit(state.copyWith(mapProvider: event.mapProvider)));

    on<LogOutHomeEvent>((_, __) {
      authRepository.removeToken();
    });
  }
}
