import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
import 'package:life_link/UI/screens/onboarding_screen/onboarding_items.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: const Text('Skip'),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(microseconds: 400),
                        curve: Curves.easeIn),
                    effect: WormEffect(
                      dotHeight: SizeConfig.height12(context),
                      dotWidth: SizeConfig.width12(context),
                      activeDotColor: primaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    ),
                    child: const Text('Next'),
                  ),
                ],
              ),
      ),
      body: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                SizedBox(
                  height: SizeConfig.height15(context),
                ),
                Text(
                  controller.items[index].title,
                  style: TextStyle(
                    fontSize: SizeConfig.height15(context) * 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  controller.items[index].description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: SizeConfig.font16(context) + 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }),
    );
  }

  //Get Started button
  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: primaryColor,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: (SizeConfig.height20(context) * 2.5) + 5,
      child: TextButton(
        onPressed: () async {
          final pres = await SharedPreferences.getInstance();
          pres.setBool('onboarding', true);

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        child: const Text(
          'Get Started',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
