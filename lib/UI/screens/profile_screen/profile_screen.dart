import 'package:flutter/material.dart';
// import 'package:life_link/UI/screens/profile_screen/components/info_card.dart';
import 'package:life_link/UI/screens/profile_screen/components/tile_widget.dart';
import 'package:life_link/UI/screens/settings_screen/settings_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
// import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // var userData;
  String? imageLink;
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Profile",
          context: context,
          backButton: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: SizeConfig.width8(context) * 2,
                ),
              ],
            ),
            SizedBox(
              height: SizeConfig.height8(context) * 2,
            ),
            TileWidget(
              text: "Settings",
              trailingImg: Assets.arrowForwardHead,
              onTap: () => settingsButton(),
              cardColor: backgroundColor,
              leadingImg: Assets.settingsIcon,
              titleTextColor: appTextColor,
            ),
            // TileWidget(
            //   text: getUserType() == UserType.driver.name
            //       ? AppStrings.favoriteBusinesses
            //       : AppStrings.favoriteDrivers,
            //   trailingImg: Assets.arrowForwardHead,
            //   onTap: null,
            //   cardColor: backgroundColor,
            //   leadingImg: Assets.favoriteIcon,
            //   titleTextColor: appTextColor,
            // ),
            const TileWidget(
              text: "Help",
              trailingImg: Assets.arrowForwardHead,
              onTap: null,
              cardColor: backgroundColor,
              leadingImg: Assets.helpIcon,
              titleTextColor: appTextColor,
            ),
          ],
        ),
      ),
    );
  }

  // ProgressCard _createProgressCard(String userRole, int position) {
  //   String image;
  //   String data;
  //   if (userRole == AppStrings.roleBusiness) {
  //     if (position == 0) {
  //       image = Assets.iconParkSolid;
  //       data = AppStrings.roleBusiness;
  //     } else {
  //       image = Assets.iconBoldTruck;
  //       data = AppStrings.subscription;
  //     }
  //   } else {
  //     if (position == 0) {
  //       image = Assets.smallTickMark;
  //       data =
  //           //  userData.data == null ? "0 Jobs done" :
  //           "83 jobs";
  //     } else {
  //       image = Assets.smallStar;
  //       data =
  //           //  userData.data == null ? "0/0" :
  //           "4.5/5";
  //     }
  //   }
  //   return ProgressCard(
  //     imageLink: image,
  //     text: data,
  //   );
  // }
  void settingsButton() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }
}
