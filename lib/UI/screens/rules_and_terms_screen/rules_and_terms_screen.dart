import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/config/size_config.dart';

class RulesAndTermsScreen extends StatelessWidget {
  const RulesAndTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Rules And Terms",
        context: context,
        backButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.height15(context) + 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1) User Registration and Authentication:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                "Users need to register with valid credentials to access the app's features. Multi-factor authentication may be implemented for added security.",
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '2) Emergency Request Submission:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                'Users should be able to submit emergency requests with essential health information and location details. Clear guidelines should be provided on the type of emergencies suitable for the app\'s assistance.',
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '3) Patient Privacy and Data Security:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                'All patient information collected by the application is treated with utmost confidentiality and stored securely. Compliance with relevant data protection regulations such as HIPAA (Health Insurance Portability and Accountability Act) or GDPR (General Data Protection Regulation) is mandatory.',
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '4) Real-Time Location Tracking:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                "The app should utilize GPS technology to track the user's real-time location accurately. Users should be informed about the importance of enabling location services for emergency assistance.",
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '5) Immediate Notification to Emergency Services:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                'Upon receiving an emergency request, the app must promptly notify the nearest emergency services and provide them with relevant patient information and location coordinates.',
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '6) Real-Time Bed Availability Updates:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                'Hospitals are responsible for regularly updating their bed availability status in the application to provide users with accurate information. Automated systems or protocols should be in place to ensure timely updates.',
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '7) Privacy Policy and Data Usage:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                "A comprehensive privacy policy should be provided to users, outlining how their data will be collected, stored, and used. Users must consent to the app's data usage policies before accessing its services.",
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '8) Emergency Response Guidelines:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                "Clear instructions and guidelines are available within the app on how users should respond in different emergency situations. Users are educated on when to use the app versus directly calling emergency services. In emergency response guidelines, information is available within the app.",
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '9) Technical Support and Assistance:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                "Users should have access to technical support and assistance within the app for any queries or issues encountered. Support channels may include in-app chat support or a dedicated helpline.",
              ),
              SizedBox(height: SizeConfig.height20(context)),
              Text(
                '10) Compliance with App Store Policies:',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context)),
              ),
              const Text(
                "The app must comply with the guidelines and policies of the app stores (e.g., Apple App Store, Google Play Store) where it is published. Regular updates should be made to ensure compliance with platform requirements and security standards.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
