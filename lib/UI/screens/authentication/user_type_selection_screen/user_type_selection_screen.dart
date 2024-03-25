import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/registration/driver_registration.dart';
import 'package:life_link/UI/screens/authentication/registration/hospital_registration.dart';
import 'package:life_link/UI/screens/authentication/registration/patient_registration.dart';
import 'package:life_link/UI/screens/authentication/user_type_selection_screen/components/user_options.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

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
  bool _box1 = true;
  bool _box2 = true;
  final Border _border = Border.all(
    color: greyColor,
    width: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  border: _box2 ? _border : null,
                  description:
                      'By continuing as patient you can call and ambulance on one click when you need it.',
                  heading: 'I’m a Patient',
                  image: Assets.arrowForwardHead,
                  function: () async {
                    // func2();
                    // if (widget.userCredential != null) {
                    //   _checkAndUploadUserData(UserType.driver);
                    // }
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const RegistrationScreen(
                    //       userType: UserType.driver,
                    //     ),
                    //   ),
                    // );
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PatientRegistration()));

                  },
                ),
                SizedBox(
                  height: (SizeConfig.height8(context)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    UserOptions(
                      border: _box1 ? _border : null,
                      description:
                          'By continuing as hospital you can register a hospital and keep facilitating patients',
                      heading: 'I’m a Hospital',
                      image: Assets.arrowForwardHead,
                      function: () {
                        // func1();
                        // if (widget.userCredential != null) {
                        //   _checkAndUploadUserData(UserType.business);
                        // }
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const RegistrationScreen(
                        //       userType: UserType.business,
                        //     ),
                        //   ),
                        // );
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => HospitalRegistration()));
                      },
                    ),
                    UserOptions(
                      border: _box2 ? _border : null,
                      description:
                          'By continuing as driver you can register a driver and keep facilitating patients',
                      heading: 'I’m a Driver',
                      image: Assets.arrowForwardHead,
                      function: () async {
                        // func2();
                        // if (widget.userCredential != null) {
                        //   _checkAndUploadUserData(UserType.driver);
                        // }
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => const RegistrationScreen(
                        //       userType: UserType.driver,
                        //     ),
                        //   ),
                        // );
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => DriverRegistration()));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> func1() async {
    setState(() {
      _box1 = true;
      _box2 = false;
    });
  }

  Future<void> func2() async {
    setState(() {
      _box2 = true;
      _box1 = false;
    });
  }

  // void _checkAndUploadUserData(UserType userType) async {
  //   FirestoreRepository firestoreRepository = FirestoreRepository();
  //   if (!await firestoreRepository
  //       .isUserDocumentEmpty(widget.userCredential!.user!.uid)) {
  //     String? email = widget.userCredential?.user!.email ??
  //         widget.userCredential!.user!.providerData.first.email!;
  //     String userName = email.substring(0, email.indexOf('@'));
  //     log(userName);
  //     firestoreRepository.uploadUserData(
  //       UserModel(
  //         email: widget.userCredential?.user!.email ??
  //             widget.userCredential!.user!.providerData.first.email!,
  //         userName: widget.userCredential?.user!.displayName ??
  //             widget.userCredential!.user!.providerData.first.displayName ??
  //             userName,
  //         role: userType.name,
  //         uid: widget.userCredential!.user!.uid,
  //       ),
  //     );
  //     Navigator.of(context).pushAndRemoveUntil(
  //       MaterialPageRoute(
  //         builder: (context) => userType == UserType.driver
  //             ? const DriverRegistrationScreen()
  //             : const BusinessRegistrationScreen(),
  //       ),
  //       (route) => false,
  //     );
  //     return;
  //   }
  // }
}
