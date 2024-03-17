import 'package:flutter/material.dart';
// import 'package:life_link/UI/screens/profile_screen/components/info_card.dart';
import 'package:life_link/UI/screens/profile_screen/components/tile_widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: appTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: const [
          // _EditProfileButton(userData: userData),
        ],
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.only(
          //     top: SizeConfig.height12(context),
          //   ),
          //   child: Center(
          //     child: userData == null
          //         ? const Padding(
          //             padding: EdgeInsets.all(8.0),
          //             child: CircularLoaderWidget(),
          //           )
          //         : InfoCard(
          //             name: name,
          //             email: email,
          //             imageLink: imageLink,
          //           ),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // GestureDetector(
              //   onTap: () => (getUserType() == UserType.business.name
              //       ? onBusinessTap()
              //       : null),
              //   child: _createProgressCard(getUserType()!, 0),
              // ),
              SizedBox(
                width: SizeConfig.width8(context) * 2,
              ),
              // _createProgressCard(getUserType()!, 1),
            ],
          ),
          SizedBox(
            height: SizeConfig.height8(context) * 2,
          ),
          TileWidget(
            text: "Settings",
            trailingImg: Assets.arrowForwardHead,
            onTap: () {},
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
}

// class _EditProfileButton extends StatelessWidget {
//   const _EditProfileButton({
//     required this.userData,
//   });

//   final userData;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         // Navigator.of(context).push(
//         //   MaterialPageRoute(
//         //     builder: (context) => EditProfileScreen(
//         //       userData: userData,
//         //     ),
//         //   ),
//         // );
//       },
//       child: const Text(
//         "Edit Profile",
//         style: TextStyle(
//           color: primaryColor,
//           fontSize: 13,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }
// }
