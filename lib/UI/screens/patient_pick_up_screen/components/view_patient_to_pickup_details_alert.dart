import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class ViewPatientToPickupDetailsAlert extends StatelessWidget {
  const ViewPatientToPickupDetailsAlert({
    super.key,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    required this.disease,
    required this.bedAssigned,
    required this.oldReportsLink,
    this.imageLink,
  });
  final String name;
  final String email;
  final String age;
  final String gender;
  final String disease;
  final String bedAssigned;
  final String oldReportsLink;
  final String? imageLink;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: scaffoldColor,
      content: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            width: SizeConfig.width20(context) * 4,
            height: SizeConfig.height20(context) * 4,
            child: ClipOval(
              child: imageLink == null || imageLink!.isEmpty
                  ? Image.asset(
                      Assets.blankProfilePicture,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      imageLink!,
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: SizeConfig.font14(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            email,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.font14(context) - 1,
              color: greyColor,
            ),
          ),
          InfoCardWidget(
            item1: age,
            item2: gender,
            item3: disease,
            item4: "BD-$bedAssigned",
            item5: oldReportsLink.isEmpty ? "None yet" : oldReportsLink,
            item1Title: 'Patient Age:',
            item2Title: 'Patient Gender:',
            item3Title: 'Disease',
            item4Title: 'Bed Assigned',
            item5Title: 'Old Reports',
          )
        ]),
      ),
    );
  }
}
