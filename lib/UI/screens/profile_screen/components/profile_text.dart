import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';

class profile_text extends StatelessWidget {
  const profile_text({super.key, required this.text, required this.value});
  final String text, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.width15(context), top: SizeConfig.height8(context)),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: Text(
                text,
                style: TextStyle(fontSize: SizeConfig.font16(context)),
                overflow: TextOverflow.ellipsis,
              )),
          Expanded(
              flex: 3,
              child: Text(
                value,
                style: TextStyle(fontSize: SizeConfig.font16(context)),
                overflow: TextOverflow.ellipsis,
              ))
        ],
      ),
    );
  }
}
