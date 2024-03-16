import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
import 'package:life_link/UI/screens/authentication/user_type_selection_screen/user_type_selection_screen.dart';
import 'package:life_link/utils/colors.dart';

class OtherAuthOption extends StatelessWidget {
  const OtherAuthOption({
    super.key,
    required this.optionText,
    required this.authOptiontext,
  });
  final String optionText;
  final String authOptiontext;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$optionText have an account? '),
        TextButton(
          style: const ButtonStyle(
              splashFactory:
                  NoSplash.splashFactory //removing onClick splash color
              ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => authOptiontext == "Sign up"
                    ? const UserTypeSelectionScreen()
                    : const LoginScreen(),
              ),
            );
          },
          child: Text(
            authOptiontext,
            style: const TextStyle(
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
