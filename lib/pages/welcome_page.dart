import 'package:family_space_flutter/pages/login_page.dart';
import 'package:family_space_flutter/text_styles.dart';
import 'package:family_space_flutter/widgets/rounded_button.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video/backdrop_720.mov')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: _controller.value.isInitialized
                ? FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 100.0,
                    right: 32,
                    left: 32,
                  ),
                  child: Text(
                    'Family Space',
                    style: TextStyles.h1.copyWith(
                      color: Colors.white,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    'Возможность делиться координатами в реальном времени',
                    style: TextStyles.h1.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 72,
                    right: 32,
                    left: 32,
                    bottom: 24,
                  ),
                  child: RoundedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Начать',
                      style: TextStyles.h2.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 32,
                    left: 32,
                    bottom: 24,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Я уже зарегистрирован. ',
                      style: TextStyles.body.copyWith(color: Colors.white),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Войти',
                          style: TextStyle(
                            color: Color(0xFFFF7A00),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*
  Text(
                    'Я уже зарегистрирован. Войти',
                    style: TextStyles.body.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
  */

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
