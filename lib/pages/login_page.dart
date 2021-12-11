import 'package:family_space_flutter/bloc/login/login_bloc.dart';
import 'package:family_space_flutter/bloc/login/login_event.dart';
import 'package:family_space_flutter/bloc/login/login_state.dart';
import 'package:family_space_flutter/text_styles.dart';
import 'package:family_space_flutter/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (_, s) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 24,
            ),
            child: Column(
              children: [
                Text('Укажите ваш номер телефона', style: TextStyles.h1),
                const SizedBox(height: 24),
                TextField(
                  onChanged: (text) {
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginEvent.enterPhone(text));
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                    hintText: 'Номер телефона',
                  ),
                ),
                Expanded(child: Container()),
                RoundedButton(
                  onPressed: s.isPhoneNumberValid
                      ? () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(const LoginEvent.login());
                          Navigator.of(context).maybePop();
                        }
                      : null,
                  child: Text(
                    'Продолжить',
                    style: TextStyles.h2.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  InputBorder get _border => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFFFF7A00), width: 2.0),
      );
}
