import 'dart:async';

import 'package:family_space_flutter/pages/home_page.dart';
import 'package:family_space_flutter/pages/login_page.dart';
import 'package:family_space_flutter/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
