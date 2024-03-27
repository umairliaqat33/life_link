import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/home_screen/components/info_card.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/firestore_repository.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _userModel;
  DriverModel? _driverModel;
  final FirestoreController _firestoreController = FirestoreController();
  String _userName = '';
  String _email = '';
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.height15(context),
            right: SizeConfig.height15(context),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height20(context) * 3,
                ),
                child: InfoCard(
                  name: _userName,
                  email: _email,
                  imageLink: "",
                ),
              ),
              SizedBox(
                height: SizeConfig.height20(context) * 2,
              ),
              GestureDetector(
                child: Container(
                  width: SizeConfig.width20(context) * 10,
                  height: SizeConfig.height20(context) * 10,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primaryColor,
                        primaryColor,
                        whiteColor,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    shape: BoxShape.circle,
                    color: primaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        spreadRadius: 15,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "SOS",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.width20(context) * 7.5,
                height: SizeConfig.height20(context) * 7,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getUserData() async {
    if (FirestoreRepository.checkUser() != null) {
      _userModel = await _firestoreController.getUserData();
      if (_userModel!.userType == UserType.driver.name) {
        _getAndSetDriverData();
      } else if (_userModel!.userType == UserType.hospital.name) {
        _getAndSetHospitalData();
      } else {
        _getAndSetPatientData();
      }
    }
  }

  Future<void> _getAndSetDriverData() async {
    _driverModel = await _firestoreController.getDriverData();
    if (_driverModel != null) {
      _email = _driverModel!.email;
      _userName = _driverModel!.name;
      setState(() {});
    }
  }

  void _getAndSetHospitalData() {}
  void _getAndSetPatientData() {}
}
