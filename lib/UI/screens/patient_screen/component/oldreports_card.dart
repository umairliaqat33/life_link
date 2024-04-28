import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/patient_screen/component/report_view_alert.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';

class OldReportsCard extends StatelessWidget {
  const OldReportsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.width20(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Report no: 101",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.font18(context),
                      color: appTextColor,
                    ),
                  ),
                  const Text("10-04-2024")
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Visted at Hospital Name",
                    style: TextStyle(
                      fontSize: SizeConfig.font12(context),
                      color: appTextColor,
                    ),
                  ),
                ],
              ),
              Center(
                child: MaterialButton(
                  minWidth: SizeConfig.width(context),
                  color: primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  onPressed: () => _viewReportButton(context),
                  child: Text(
                    "View Report",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: SizeConfig.font12(context),
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

  void _viewReportButton(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ReportViewingAlert();
      },
    );
  }
}
