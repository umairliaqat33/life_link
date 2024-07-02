import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/drivers_screen/components/driver_card_widget.dart';
import 'package:life_link/UI/screens/drivers_screen/driver_adding_screen.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/no_data_widget.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/utils.dart';

class DriverScreen extends StatefulWidget {
  const DriverScreen({super.key});

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> {
  final FirestoreController _firestoreController = FirestoreController();

  final TextEditingController _searchFieldcontroller = TextEditingController();

  Stream<List<DriverModel?>>? _driverSearchStream;

  @override
  void initState() {
    super.initState();
    _driverSearchStream = _firestoreController
        .getDriverSearchedStreamList(_searchFieldcontroller.text);
  }

  @override
  void dispose() {
    _searchFieldcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Manage Driver",
          context: context,
          backButton: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const DriverAddingScreen(),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width10(context),
            right: SizeConfig.width10(context),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormFieldWidget(
                  controller: _searchFieldcontroller,
                  validator: (value) => Utils.simpleValidator(value),
                  label: "",
                  hintText: "Enter article name to search",
                  inputAction: TextInputAction.done,
                  onChanged: (value) => _searchOnchaged(),
                  suffixIcon: Icons.close,
                  suffixIconFunction: () {
                    _searchFieldcontroller.clear();
                    _searchOnchaged();
                  },
                ),
                SizedBox(
                  height: SizeConfig.height8(context),
                ),
                SizedBox(
                  height: SizeConfig.height20(context) * 200,
                  child: StreamBuilder<List<DriverModel?>>(
                      stream: _driverSearchStream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularLoaderWidget();
                        }

                        if (snapshot.hasError) {
                          return Text(
                            "Something went wrong please try again",
                            style: TextStyle(
                              fontSize: SizeConfig.font20(context),
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        if (snapshot.data == null || snapshot.data!.isEmpty) {
                          return const NoDataWidget(
                            alertText: "No Drivers Found",
                          );
                        }
                        List<DriverModel?>? driverList = snapshot.data;

                        return ListView.builder(
                          itemCount: driverList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return DriverCardWidget(
                              driverModel: driverList[index]!,
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _searchOnchaged() {
    _driverSearchStream = _firestoreController
        .getDriverSearchedStreamList(_searchFieldcontroller.text);
    setState(() {});
  }
}
