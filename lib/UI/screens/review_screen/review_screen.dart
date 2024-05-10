import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/utils.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({
    super.key,
    required this.reviewController,
  });
  final TextEditingController reviewController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              Assets.feedbackImage,
              height: 100,
              width: 100,
            ),
            TextFormFieldWidget(
              controller: reviewController,
              validator: (value) => Utils.simpleValidator(value),
              label: "Feedback",
              hintText:
                  "How was the behaviour of driver or how hospital treated you?",
              maxLength: 800,
              maxlines: 5,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              title: "Done",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CustomButton(
              buttonColor: greyColor,
              title: "Cancel",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
