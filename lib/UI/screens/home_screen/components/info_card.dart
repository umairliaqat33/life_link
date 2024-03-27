import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final String email;
  final String? imageLink;
  const InfoCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageLink,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              color: blackColor,
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.font20(context),
            ),
          ),
          Text(
            email,
            style: TextStyle(
              color: greyColor,
              fontSize: SizeConfig.font14(context),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
