import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
import 'package:life_link/UI/screens/profile_screen/components/tile_widget.dart';
import 'package:life_link/UI/screens/rules_and_terms_screen/rules_and_terms_screen.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class SettingsScreen extends StatelessWidget {
  // final UserModel? userModel;
  const SettingsScreen({
    super.key,
    // required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    // log("Height: ${SizeConfig.height(context)}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: backgroundColor,
          centerTitle: true,
          // automaticallyImplyLeading: false,
          title: Text(
            "Settings",
            style: TextStyle(
              color: appTextColor,
              fontSize: SizeConfig.font18(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: const [
            // _EditProfileButton(userData: userData),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TileWidget(
              text: "Rules and terms",
              trailingImg: Assets.arrowForwardHead,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RulesAndTermsScreen(),
                  ),
                );
              },
              cardColor: backgroundColor,
              titleTextColor: appTextColor,
              leadingImg: null,
            ),
            TileWidget(
              text: "Delete Account",
              trailingImg: Assets.arrowForwardHead,
              onTap: () {
                // deleteAccountAlert(
                //   context: context,
                //   description:
                //       "If you delete your account it will not retrieve are you sure?",
                //   image: Assets.deleteAccountAlert,
                //   heading: "Deleting Account",
                //   onCancelTap: () {
                //     Navigator.of(context).pop();
                //   },
                //   onDeleteTap: () {
                //     // AuthRepository authRepository = AuthRepository();
                //     // authRepository.deleteUserAccount(
                //     //   userModel!.uid!,
                //     //   userModel!.role,
                //     // );
                //     // Navigator.of(context).pushAndRemoveUntil(
                //     //   MaterialPageRoute(
                //     //       builder: (context) => const AuthDecisionScreen()),
                //     //   (route) => false,
                //     // );
                //     // _showSnackBar("Account Deleted",
                //     //     "Account and it's data is deleted!", context);
                //   },
                // );
              },
              cardColor: backgroundColor,
              titleTextColor: appTextColor,
              leadingImg: null,
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.height12(context)),
              child: TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.font14(context),
                        color: redColor,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // void _showSnackBar(
  //   String title,
  //   String subTitle,
  //   BuildContext context,
  // ) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     snackBar(
  //       subTitle: subTitle,
  //     ),
  //   );
  // }
}
