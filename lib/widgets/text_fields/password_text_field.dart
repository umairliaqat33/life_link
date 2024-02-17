import 'package:flutter/material.dart';

import 'package:life_link/config/size_config.dart';
import 'package:life_link/constants/text_field_decoration.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _textVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 3,
          ),
          child: Text('Password'),
        ),
        SizedBox(
          height: SizeConfig.width8(context),
        ),
        TextFormField(
          validator: (value) => Utils.passwordValidator(value),
          textInputAction: TextInputAction.done,
          obscureText: _textVisible,
          controller: widget.controller,
          decoration: TextFieldDecoration.kPasswordFieldDecoration.copyWith(
            hintText: 'Password mini 8 characters',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _textVisible = !_textVisible;
                });
              },
              icon: _textVisible
                  ? Image.asset(
                      Assets.passwordVisibilityOff,
                      height: 20,
                      width: 20,
                      color: primaryColor,
                    )
                  : Image.asset(
                      Assets.passwordVisibilityOn,
                      height: 20,
                      width: 20,
                      color: primaryColor,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
