import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_constants.dart';
import 'package:hotel_ma/feature/components/onboarding_content.dart';
import 'package:hotel_ma/feature/pages/home_screen.dart';

import '../components/defaut_button.dart';
import '../components/onboarding_dot.dart';

/*
* Onboarding screens for first join by user
*/

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OnboardingBody(),
    );
  }
}

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({Key? key}) : super(key: key);

  @override
  _OnboardingBodyState createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  final controller = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
              flex: 3,
              child: PageView.builder(

                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) => OnboardingContent(
                        image: onboardingData[index]["image"],
                        text: onboardingData[index]["text"],
                        subtext: onboardingData[index]["subtext"],
                      ))),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0), // fix this for adaptive layout
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    OnboardingDot(currentPage: currentPage, controller: controller, length: onboardingData.length),
                    const Spacer(),
                    DefaultButton(
                      press: () {
                        setState(() {
                          controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                          if(controller.page == 2){
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const HomeScreen())
                            );
                            currentPage = 0;
                            controller.initialPage;
                          }
                        });
                      }, //Continue to HomePage()
                    ),
                    const Spacer(),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

List<Map<String, String>> onboardingData = [
  {
    "image": "assets/images/onboarding-1.png",
    "text": "Поиск и бронирование номера",
    "subtext": "Воспользуйтесь фильтрами и поиском, чтобы найти отличное место для отдыха, развлечений и бизнеса",
  },
  {
    "image": "assets/images/onboarding-2.png",
    "text": "Авторизация",
    "subtext": "Авторизируйтесь или зарегистрируйтесь по номеру телефона, чтобы оформить и оплатить номер",
  },
  {
    "image": "assets/images/onboarding-3.png",
    "text": "Оплата выбранного номера",
    "subtext": "Оплатите выбранный номер с желаемыми свободными датами и наслаждайтесь отдыхом",
  },
];
