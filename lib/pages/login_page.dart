import 'package:family_space_flutter/pages/home_page.dart';
import 'package:family_space_flutter/text_styles.dart';
import 'package:family_space_flutter/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 24,
        ),
        child: Column(
          children: [
            Text('Укажите ваш номер телефона', style: TextStyles.h1),
            const SizedBox(height: 24),
            TextField(
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
              onPressed: () async {
                if (await Permission.location.isDenied) {
                  final result = await Permission.location.request();
                  if (result == PermissionStatus.granted) {
                    if (await Permission.location.serviceStatus.isEnabled) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    }
                  }
                } else {
                  if (await Permission.location.serviceStatus.isEnabled) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                }
              },
              child: Text(
                'Продолжить',
                style: TextStyles.h2.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputBorder get _border => const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFFFF7A00), width: 2.0),
      );
}
