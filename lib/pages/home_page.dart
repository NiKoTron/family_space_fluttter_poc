import 'dart:async';
import 'dart:ui';

import 'package:family_space_flutter/bloc/home/home_bloc.dart';
import 'package:family_space_flutter/bloc/home/home_event.dart';
import 'package:family_space_flutter/bloc/home/home_state.dart';
import 'package:family_space_flutter/model/coordinates.dart';
import 'package:family_space_flutter/model/user.dart';
import 'package:family_space_flutter/text_styles.dart';
import 'package:family_space_flutter/widgets/banner_widget.dart';
import 'package:family_space_flutter/widgets/circle_button.dart';
import 'package:family_space_flutter/widgets/google_map_widget.dart';
import 'package:family_space_flutter/widgets/mapbox_map_widget.dart';
import 'package:family_space_flutter/widgets/user_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AbsMarker {
  final String id;
  final Coordinates coordinates;
  final String assetPath;
  final double size;

  const AbsMarker({
    required this.id,
    required this.coordinates,
    required this.assetPath,
    required this.size,
  });
}

class AbsRoute {
  final String id;
  final List<Coordinates> routeCoordinates;
  final Color color;
  final double thickness;

  const AbsRoute({
    required this.id,
    required this.routeCoordinates,
    required this.color,
    required this.thickness,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final routesStreamController = StreamController<List<AbsRoute>>.broadcast();

  final markersStreamController = StreamController<List<AbsMarker>>.broadcast();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    routesStreamController.close();
    markersStreamController.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (_, state) {
          final markers = <AbsMarker>[];
          if (state.myLocation != null) {
            markers.add(
              AbsMarker(
                assetPath: 'assets/images/i_am_marker.png',
                coordinates: state.myLocation!,
                size: 48,
                id: 'iam',
              ),
            );
          }
          if (state.homeLocation != null) {
            markers.add(
              AbsMarker(
                assetPath: 'assets/images/home_marker.png',
                coordinates: state.homeLocation!,
                size: 48,
                id: 'home',
              ),
            );
          }
          markersStreamController.add(markers);

          final routes = <AbsRoute>[];
          if (state.displayedTrack != null) {
            routes.add(
              AbsRoute(
                id: 'track',
                routeCoordinates: state.displayedTrack!,
                color: Colors.blue.withOpacity(0.5),
                thickness: 5,
              ),
            );
          }
          routesStreamController.add(routes);
        },
        builder: (_, state) => SlidingUpPanel(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          minHeight: 114,
          maxHeight: 408,
          parallaxEnabled: true,
          backdropEnabled: true,
          panel: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      height: 4,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                Text(
                  state.currentPosition ?? '',
                  style: TextStyles.h2,
                ),
                const SizedBox(height: 4),
                Text(
                  state.homeGeocoded ?? '',
                  style: TextStyles.body,
                ),
                const SizedBox(height: 32),
                ..._items(state.participants),
              ],
            ),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              state.homeLocation == null
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : state.mapProvider == MapProvider.googleMaps
                      ? GoogleMapWidget(
                          initialCameraCoords: state.homeLocation!,
                          routesStream: routesStreamController.stream,
                          markersStream: markersStreamController.stream,
                        )
                      : MapBoxWidget(
                          initialCameraCoords: state.homeLocation!,
                          routesStream: routesStreamController.stream,
                          markersStream: markersStreamController.stream,
                        ),
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        right: 16,
                        left: 16,
                      ),
                      child: Row(
                        children: [
                          CircleButton.gradient(
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                const HomeEvent.logOut(),
                              );
                            },
                            child: Image.asset(
                              'assets/images/star_white.png',
                              height: 24,
                              width: 24,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(22),
                              ),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 2.5,
                                  sigmaY: 2.5,
                                ),
                                child: Container(
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'Супер семья',
                                            style: TextStyles.h3,
                                          ),
                                        ),
                                        const Icon(
                                            Icons.arrow_downward_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          CircleButton(
                            color: Colors.white,
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context).add(
                                HomeEvent.setMapProvider(
                                  state.mapProvider == MapProvider.googleMaps
                                      ? MapProvider.mapBox
                                      : MapProvider.googleMaps,
                                ),
                              );
                            },
                            child: Image.asset(
                              'assets/images/stack.png',
                              height: 26,
                              width: 26,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: SizedBox(
                        height: 98,
                        child: PageView.builder(
                          padEnds: false,
                          itemCount: state.banners?.length ?? 0,
                          itemBuilder: (_, i) => BannerWidget(
                            title: state.banners?[i].title ?? '',
                            description: state.banners?[i].description ?? '',
                          ),
                          controller: PageController(viewportFraction: 0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _items(List<User>? participants) => participants == null
      ? []
      : participants
          .map((e) => UserItemWidget(
              avatar: e.avatarUrl,
              name: e.name,
              fromTime: e.joinedSince,
              lowBattery: e.batteryStatus))
          .toList();
}
