import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingModel
{
  final String image;
  final String title;
  final String body;
  OnBoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget
{
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List onBoardingData=[
    OnBoardingModel(
      image:"assets/images/onboarding_1.jfif",
      title: "screen 1 title",
      body: "screen 1 body"
    ),
    OnBoardingModel(
        image:"assets/images/onboarding_1.jfif",
        title: "screen 2 title",
        body: "screen 2 body"
    ),
    OnBoardingModel(
        image:"assets/images/onboarding_1.jfif",
        title: "screen 3 title",
        body: "screen 3 body"
    ),
  ];


  bool isLast=false;
  void lastPageAction() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value){
      if(value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ShopLoginScreen()),
          (route) => false,
        );
      }
    });
  }
  @override
  Widget build(BuildContext context)
  {
    var onboardController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){
                lastPageAction();
              },
              child: const Text('Skip',style: TextStyle(color: defaultColor),)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:  [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) => onBoardingItem(onBoardingData[index]),
                itemCount: onBoardingData.length,
                controller: onboardController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if(index == onBoardingData.length-1)
                  {
                    isLast= true;
                    setState(() {});
                  }else{
                    isLast=false;
                    setState(() {});
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children:  [
                Expanded(
                    child: SmoothPageIndicator(
                      controller: onboardController,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        expansionFactor: 4,
                        dotWidth: 10,
                        dotHeight: 15,
                        spacing: 5,
                      ),
                      count: onBoardingData.length,
                    )
                ),
                FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if(isLast==true)
                    {
                      lastPageAction();
                    }else{
                      onboardController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );

  }

  Widget onBoardingItem(OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Expanded(
            child: Image(
                image: AssetImage(model.image)
            )
        ),
        const SizedBox(height: 10),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          model.body,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    );
  }
}
