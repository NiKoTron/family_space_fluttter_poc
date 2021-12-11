import 'dart:async';

import 'package:family_space_flutter/model/coordinates.dart';
import 'package:family_space_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  final Coordinates initialCameraCoords;

  final Stream<List<AbsRoute>> routesStream;
  final Stream<List<AbsMarker>> markersStream;

  const GoogleMapWidget({
    Key? key,
    required this.initialCameraCoords,
    required this.routesStream,
    required this.markersStream,
  }) : super(key: key);

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  final _icon = <String, BitmapDescriptor>{};

  @override
  void initState() {
    super.initState();

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(48, 48),
            ),
            'assets/images/i_am_marker.png')
        .then(
      (value) => setState(
        () {
          _icon['assets/images/i_am_marker.png'] = value;
        },
      ),
    );

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(48, 48),
            ),
            'assets/images/home_marker.png')
        .then(
      (value) => setState(
        () {
          _icon['assets/images/home_marker.png'] = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<List<AbsMarker>>(
        stream: widget.markersStream,
        builder: (_, markerSnapshot) => StreamBuilder<List<AbsRoute>>(
          stream: widget.routesStream,
          builder: (_, routeSnapshot) => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.initialCameraCoords.toGMapsLatLng(),
              zoom: 15.5,
            ),
            polylines: _getPolyLines(routeSnapshot.data ?? []),
            markers: _getMarkers(markerSnapshot.data ?? []),
          ),
        ),
      );

  Set<Polyline> _getPolyLines(List<AbsRoute> routes) => routes
      .map(
        (e) => Polyline(
            polylineId: PolylineId(e.id),
            color: e.color,
            width: e.thickness.toInt(),
            points: e.routeCoordinates.map((e) => e.toGMapsLatLng()).toList()),
      )
      .toSet();

  Set<Marker> _getMarkers(List<AbsMarker> markers) => markers
      .map(
        (e) => Marker(
            markerId: MarkerId(e.id),
            position: e.coordinates.toGMapsLatLng(),
            icon: _icon.containsKey(e.assetPath)
                ? _icon[e.assetPath] ?? BitmapDescriptor.defaultMarker
                : BitmapDescriptor.defaultMarker),
      )
      .toSet();
}
