import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/design_layers/layer_two.dart';
import 'package:life_link/UI/screens/authentication/registration/registration_screen.dart';
import 'package:life_link/UI/screens/authentication/user_type_selection_screen/components/user_options.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  final UserCredential? userCredential;
  const UserTypeSelectionScreen({
    super.key,
    this.userCredential,
  });

  @override
  State<UserTypeSelectionScreen> createState() =>
      _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  int _boxNumb = 0;
  final Border _border = Border.all(
    color: greyColor,
    width: 2,
  );
  @override
  void dispose() {
    super.dispose();
    _boxNumb = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.primaryBackgroundImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: SizeConfig.height20(context) * 8,
                right: 2,
                bottom: 0,
                left: 2,
                child: const LayerTwo(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: (SizeConfig.width8(context) * 2),
                    right: (SizeConfig.width8(context) * 2),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: (SizeConfig.height8(context) * 8),
                        ),
                        UserOptions(
                          border: _boxNumb == 1 ? _border : null,
                          description:
                              'By continuing as patient you can call and ambulance on one click when you need it.',
                          heading: 'I’m a Patient',
                          image: Assets.arrowForwardHead,
                          function: () async {
                            _setBrder(1);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const RegistrationScreen(
                                    userType: UserType.patient),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: (SizeConfig.height8(context)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            UserOptions(
                              border: _boxNumb == 2 ? _border : null,
                              description:
                                  'By continuing as hospital you can register a hospital and keep facilitating patients',
                              heading: 'I’m a Hospital',
                              image: Assets.arrowForwardHead,
                              function: () {
                                _setBrder(2);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(
                                            userType: UserType.hospital),
                                  ),
                                );
                              },
                            ),
                            UserOptions(
                              border: _boxNumb == 3 ? _border : null,
                              description:
                                  'By continuing as driver you can register a driver and keep facilitating patients',
                              heading: 'I’m a Driver',
                              image: Assets.arrowForwardHead,
                              function: () async {
                                _setBrder(3);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen(
                                            userType: UserType.driver),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _setBrder(int i) async {
    setState(() {
      _boxNumb = i;
    });
  }
}
