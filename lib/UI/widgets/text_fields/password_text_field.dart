import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:life_link/config/size_config.dart';
import 'package:life_link/constants/text_field_decoration.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
    this.textFieldFilled = true,
  });
  final TextEditingController controller;
  final bool? textFieldFilled;

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
        Padding(
          padding: const EdgeInsets.only(
            left: 3,
          ),
          child: Text(
            'Password',
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.font12(context) + 1,
            ),
          ),
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
            filled: widget.textFieldFilled,
            fillColor: textFieldFillColor,
            hintText: 'Password mini 8 characters',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _textVisible = !_textVisible;
                });
              },
              icon: _textVisible
                  ? SvgPicture.asset(
                      Assets.passwordVisibilityOff,
                      height: SizeConfig.height20(context),
                      width: SizeConfig.width20(context),
                      colorFilter:
                          const ColorFilter.mode(greyColor, BlendMode.srcIn),
                    )
                  : SvgPicture.asset(
                      Assets.passwordVisibilityOn,
                      height: SizeConfig.height20(context),
                      width: SizeConfig.width20(context),
                      colorFilter:
                          const ColorFilter.mode(greyColor, BlendMode.srcIn),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
