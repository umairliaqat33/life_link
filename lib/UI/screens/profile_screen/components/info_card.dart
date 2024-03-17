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
    return Card(
      color: backgroundColor,
      shadowColor: Colors.transparent,
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(
            color: appTextColor,
            fontWeight: FontWeight.w600,
            fontSize: 28,
          ),
        ),
        subtitle: Text(
          email,
          style: const TextStyle(
            color: greyColor,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: SizedBox(
          width: SizeConfig.width12(context) * 4,
          height: SizeConfig.height12(context) * 4,
          child: imageLink == null
              ? Image.asset(Assets.blankProfilePicture)
              : Image.network(
                  imageLink!,
                  fit: BoxFit.fill,
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
    );
  }
}
