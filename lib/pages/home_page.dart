import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:family_space_flutter/text_styles.dart';
import 'package:family_space_flutter/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = Completer<GoogleMapController>();

  static const LatLng _center = LatLng(59.982316315315, 30.315298319102);

  late Location _location;

  Marker? _iAmMarker;
  Marker? _homeMarker;

  BitmapDescriptor? _myLocationIcon;
  LatLng? _myLocationMarker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _location = Location();

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(
              size: Size(48, 48),
            ),
            'assets/images/home_marker.png')
        .then((value) {
      setState(() {
        _homeMarker = Marker(
          markerId: const MarkerId('home'),
          position: _center,
          icon: value,
        );
      });

      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(
                size: Size(48, 48),
              ),
              'assets/images/i_am_marker.png')
          .then((value) {
        _myLocationIcon = value;
        _location.getLocation().then((location) {
          setState(() {
            if (location.latitude != null && location.longitude != null) {
              _iAmMarker = Marker(
                markerId: const MarkerId('iam'),
                position: LatLng(location.latitude!, location.longitude!),
                icon: _myLocationIcon!,
              );
            }
          });
        });
      });

      _location.onLocationChanged.listen((LocationData currentLocation) {
        if (_myLocationIcon != null &&
            currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          _iAmMarker = Marker(
            markerId: const MarkerId('iam'),
            position:
                LatLng(currentLocation.latitude!, currentLocation.longitude!),
            icon: _myLocationIcon!,
          );
        }
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        minHeight: 114,
        maxHeight: 408,
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
              SizedBox(height: 36),
              Text(
                'Сейчас дома',
                style: TextStyles.h2,
              ),
              SizedBox(height: 4),
              Text(
                'ул. Николая Островского, 89',
                style: TextStyles.body,
              ),
              SizedBox(height: 32),
              ..._items,
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _center,
                zoom: 15.5,
              ),
              polylines: _getPolyLines(),
              markers: _getMarkers(),
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
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/star_white.png',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        SizedBox(
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
                                      const Icon(Icons.arrow_downward_rounded),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        CircleButton(
                          color: Colors.white,
                          onPressed: () {},
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
                        itemBuilder: (_, __) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 48,
                                      width: 48,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEFF2F4),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Image.asset(
                                          'assets/images/star.png',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Premium — подписка',
                                              style: TextStyles.h3,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'Еще больше уведомлений для полной безопасности',
                                              style: TextStyles.body,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.close),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
    );
  }

  List<Widget> get _items => [
        _buildItem(
          avatar: 'https://i.pravatar.cc/300?img=${Random().nextInt(70)}',
          name: 'Мама',
          lowBattery: Random().nextBool(),
          fromTime: DateTime.now().subtract(
            Duration(
                hours: Random().nextInt(23), minutes: Random().nextInt(59)),
          ),
        ),
        _buildItem(
          avatar: 'https://i.pravatar.cc/300?img=${Random().nextInt(70)}',
          name: 'Папа',
          lowBattery: Random().nextBool(),
          fromTime: DateTime.now().subtract(
            Duration(
                hours: Random().nextInt(23), minutes: Random().nextInt(59)),
          ),
        ),
        _buildItem(
          avatar: 'https://i.pravatar.cc/300?img=${Random().nextInt(70)}',
          name: 'Сын',
          lowBattery: Random().nextBool(),
          fromTime: DateTime.now().subtract(
            Duration(
                hours: Random().nextInt(23), minutes: Random().nextInt(59)),
          ),
        ),
      ];

  Widget _buildItem(
          {required String avatar,
          required String name,
          VoidCallback? onTap,
          bool lowBattery = false,
          required DateTime fromTime}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF2F4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Container(
                          child: Image.network(avatar),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            color: Color(lowBattery ? 0xFFE86303 : 0xFF65FABC),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyles.h3,
                        ),
                        if (lowBattery)
                          Text(
                            'Низкий заряд батареи',
                            style: TextStyles.subText.copyWith(
                              color: Color(0xFFE86303),
                            ),
                          ),
                        Text(
                          'Тут с ${fromTime.hour}:${fromTime.minute}',
                          style: TextStyles.subText,
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.chevron_right_rounded),
              ],
            ),
          ),
        ),
      );

  Set<Marker> _getMarkers() {
    final Set<Marker> markers = {};

    if (_homeMarker != null) {
      markers.add(_homeMarker!);
    }

    if (_iAmMarker != null) {
      markers.add(_iAmMarker!);
    }

    return markers;
  }

  Set<Polyline> _getPolyLines() => {
        Polyline(
            polylineId: const PolylineId("route_54765342"),
            color: Colors.blue.withOpacity(0.5),
            width: 5,
            points: _polylineCoordinates),
      };

  List<LatLng> get _polylineCoordinates => [
        LatLng(59.982289722716168, 30.315139558960606),
        LatLng(59.982201889981432, 30.314335961591265),
        LatLng(59.981910531227946, 30.31357767882805),
        LatLng(59.981859186112821, 30.312973749457647),
        LatLng(59.981977783199127, 30.312622260591002),
        LatLng(59.982343303933234, 30.309797877958097),
        LatLng(59.982800655343929, 30.309012573500951),
        LatLng(59.982669090451502, 30.309335311329015),
        LatLng(59.982488148894461, 30.309589912275836),
        LatLng(59.982351675525877, 30.309920482595508),
        LatLng(59.98208527577475, 30.311659590289594),
        LatLng(59.981985188691972, 30.313170257322447),
        LatLng(59.981941473992428, 30.313309266415711),
        LatLng(59.981785320051912, 30.313498392686466),
        LatLng(59.981896482677406, 30.313574713710697),
        LatLng(59.982642931478729, 30.314006748853433),
        LatLng(59.982680726606873, 30.314751319519793),
        LatLng(59.982348984516094, 30.31508123284905),
        LatLng(59.982304378645154, 30.315102057125632),
        LatLng(59.982323926699387, 30.31530474152542),
        LatLng(59.982323926699387, 30.315298319101998),
      ];
}
