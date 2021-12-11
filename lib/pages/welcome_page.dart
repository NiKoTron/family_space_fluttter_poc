import 'package:family_space_flutter/bloc/login/login_bloc.dart';
import 'package:family_space_flutter/pages/login_page.dart';
import 'package:family_space_flutter/repositories/auth/auth_repository.dart';
import 'package:family_space_flutter/repositories/permissions/permissions_repository.dart';
import 'package:family_space_flutter/text_styles.dart';
import 'package:family_space_flutter/widgets/rounded_button.dart';
import 'package:family_space_flutter/widgets/video_backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            const VideoBackdrop(
              videoAsset: 'assets/video/backdrop_720.mov',
              firstFrameAsset: 'assets/images/backdrop_720_000.jpg',
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
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<LoginBloc>(
                              create: (_) => LoginBloc(
                                  permissionRepository: RepositoryProvider.of<
                                      PermissionsRepository>(context),
                                  authRepository:
                                      context.read<AuthRepository>()),
                              child: const LoginPage(),
                            ),
                          ),
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
