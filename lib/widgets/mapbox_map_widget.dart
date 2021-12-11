import 'dart:async';
import 'dart:typed_data';

import 'package:family_space_flutter/model/coordinates.dart';
import 'package:family_space_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapBoxWidget extends StatefulWidget {
  final Coordinates initialCameraCoords;

  final Stream<List<AbsRoute>> routesStream;
  final Stream<List<AbsMarker>> markersStream;

  const MapBoxWidget({
    Key? key,
    required this.initialCameraCoords,
    required this.routesStream,
    required this.markersStream,
  }) : super(key: key);

  @override
  State<MapBoxWidget> createState() => _MapBoxWidgetState();
}

class _MapBoxWidgetState extends State<MapBoxWidget> {
  MapboxMapController? _controller;

  final Set<String> _loadedAssetsImage = {};

  final _idsRelation = <String, String>{};

  late final StreamSubscription<List<AbsMarker>> _markerSubscription;

  late final StreamSubscription<List<AbsRoute>> _routesSubscription;

  bool _styleIsLoaded = false;

  bool _controllerDisposed = false;

  @override
  void initState() {
    super.initState();
    _markerSubscription = widget.markersStream.listen(_markerListener);
    _routesSubscription = widget.routesStream.listen(_routesListener);
  }

  @override
  void dispose() {
    _controllerDisposed = true;

    _markerSubscription.cancel();
    _routesSubscription.cancel();

    try {
      _controller?.dispose();
    } catch (_) {}
    _controller = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      onStyleLoadedCallback: () {
        _styleIsLoaded = true;
      },
      onMapCreated: (controller) {
        _controller = controller;
      },
      accessToken:
          'sk.eyJ1Ijoibmlqb3Ryb24iLCJhIjoiY2t4MGR3ODBtMHFtcTJxb2Iyd3hvbnNheSJ9.YgTVnvXJ609DF2JGN_GaCw',
      initialCameraPosition: CameraPosition(
        target: widget.initialCameraCoords.toMapBoxLatLng(),
        zoom: 15.5,
      ),
    );
  }

  void _markerListener(List<AbsMarker> markers) async {
    if (_styleIsLoaded && !_controllerDisposed) {
      //await _controller?.clearSymbols();
      markers.forEach(addMarker);
    }
  }

  Future<void> addMarker(AbsMarker marker) async {
    if (!_loadedAssetsImage.contains(marker.assetPath)) {
      final ByteData bytes = await rootBundle.load(marker.assetPath);
      final Uint8List list = bytes.buffer.asUint8List();

      await _controller?.addImage(marker.assetPath, list);
      _loadedAssetsImage.add(marker.assetPath);
    }
    if (_styleIsLoaded && !_controllerDisposed) {
      if (_idsRelation.containsKey(marker.id)) {
        final symbolId = _idsRelation[marker.id];
        final symbol =
            _controller?.symbols.firstWhere((symbol) => symbol.id == symbolId);
        if (symbol != null &&
            marker.coordinates.toMapBoxLatLng() != symbol.options.geometry) {
          _controller?.updateSymbol(
            symbol,
            SymbolOptions(
              geometry: marker.coordinates.toMapBoxLatLng(),
            ),
          );
        }
      } else {
        final symbol = await _controller?.addSymbol(
          SymbolOptions(
            geometry: marker.coordinates.toMapBoxLatLng(),
            iconImage: marker.assetPath,
          ),
        );
        if (symbol != null) {
          _idsRelation[marker.id] = symbol.id;
        }
      }
    }
  }

  void _routesListener(List<AbsRoute> routes) async {
    if (_styleIsLoaded) {
      _controller?.clearLines();

      _controller?.addLines(
        routes
            .map(
              (e) => LineOptions(
                lineColor: e.color.toHexStringRGB(),
                geometry:
                    e.routeCoordinates.map((e) => e.toMapBoxLatLng()).toList(),
                lineWidth: e.thickness,
              ),
            )
            .toList(),
      );
    }
  }
}
