import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/constant.dart';
import 'package:shop_app/shared/network/local/hive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class pageView {
  String image;
  String title;
  String body;

  pageView({required this.title, required this.body, required this.image});
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreen();
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  var controll = PageController();

  List<pageView> item = [
    pageView(
        title: "Screen 1",
        body: "Body of Screen 1",
        image: 'assets/images/shoppingPic.png'),
    pageView(
        title: "Screen 2",
        body: "Body of Screen 2",
        image: 'assets/images/shoppingPic.png'),
    pageView(
        title: "Screen 3",
        body: "Body of Screen 3",
        image: 'assets/images/shoppingPic.png'),
  ];

  bool isLast = false;

  void finishOnboarding() {
    CacheHelper.putHiveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder:(context)=> LoginScreen()),
              (route) => false
      );
    }).catchError((error)
    {
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              finishOnboarding();
            },
            child: const Text(
              'SKIP',
              style: TextStyle(
                color: defaultColorLightMode,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index)
                {
                  if(index == item.length - 1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                  else
                    {
                      setState(() {
                        isLast = false;
                      });
                    }
                },
                controller: controll,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => shopView(item[index]),
                itemCount: item.length,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColorLightMode,
                    expansionFactor: 2,
                  ),
                  controller: controll,
                  count: item.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                      {
                        finishOnboarding();
                      }
                    else
                      {
                        controll.nextPage(
                          duration: const Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.easeInBack,
                        );
                      }
                  },
                  child: const Icon(Icons.navigate_next_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget shopView(pageView item) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(item.image),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            item.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            item.body,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ],
      );
}
