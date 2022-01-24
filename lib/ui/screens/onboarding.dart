
import 'package:flutter/material.dart';
import 'package:flutter_app/ui/custoimwidgets/onboarding_widgets.dart';
import 'package:flutter_app/ui/screens/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: OnBoardingView(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  HomeScreen())) ;
      },
        child: Icon(Icons.navigate_next, color: Colors.white,),
      ),
    );
  }
}

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();

    return Stack(
      children: [
        Container(
          color: Colors.grey.shade100,
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView(
                  controller: controller,
                  children: [
                    getPage(1),
                    getPage(2),
                    getPage(3),
                    getPage(4),
                    getPage(5),
                    getPage(6),
                  ],

                ),
              ),

              Expanded(
                flex: 1,
                child: SmoothPageIndicator(controller: controller,
                  count: 6,
                  effect: WormEffect(),),
              ),


            ],
          ),
        ),

      ],
    );
  }

}





