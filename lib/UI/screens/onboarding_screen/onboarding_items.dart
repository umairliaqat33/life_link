import 'package:life_link/UI/screens/onboarding_screen/onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Welcome to Life Link",
        description:
            "Your essential tool for emergency medical assistance and real-time hospital bed availability",
        image: "assets/images/Screen3.png"),
    OnboardingInfo(
        title: "Real-Time Bed",
        description:
            "An up-to-date overview of bed availability in nearby hospitals, ensuring you can find the care you need without unnecessary delays.",
        image: "assets/images/Screen2.jpg"),
    OnboardingInfo(
        title: "Accurate location",
        description:
            "Get precise directions to the nearest hospital and track ambulance arrival, GPS map with a route from the user's location to the hospital",
        image: "assets/images/Screen1.jpg"),
  ];
}
