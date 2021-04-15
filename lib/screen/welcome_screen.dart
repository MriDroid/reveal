import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Widgets
import '../widget/welcome_screen/welcome_widget.dart';

// Screen
import './cam_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome_screen';
  @override
  State<StatefulWidget> createState() {
    return _Welcome();
  }
}

class _Welcome extends State<WelcomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Widget> _welcomes = [
      WelcomeWidget(
        'Welcome to Reveal..\n  To listen to the documentation, please tap the screen.\n To continue, please swipe the screen to the left',
        'images/Reveal.png',
        'Welcome to Reveal..\n',
        '  To listen to the documentation, please tap the screen.\n To continue, please swipe the screen to the left.',
        () {},
      ),
      WelcomeWidget(
        'Reveal is an app that helps you to know the things around you and their directions',
        'images/1.png',
        'Reveal..\n',
        ' is an app that helps you to know the things around you and their directions.',
        () {},
      ),
      WelcomeWidget(
        'How can Reveal helps you?\n Reveal works on describing and explaining the things surrounding you with the sound in order to help you identify them easily.',
        'images/2.png',
        'How can Reveal helps you?\n',
        '  Reveal works on describing and explaining the things surrounding you with the sound in order to help you identify them easily.',
        () {},
      ),
      WelcomeWidget(
        '''How to use Reveal?\n you must hold the screen and say "classify" for classification or "reveal" for detection.
      The recording process ends as soon as you listen to a simple ring, and at this time you can release your hand.
      If you did not say it correctly, you must repeat it again.\n To start, please tap the screen twice.''',
        'images/3.png',
        'How to use Reveal?\n',
        ''' you must hold the screen and say 'classify' for classification or 'reveal' for detection.
      The recording process ends as soon as you listen to a simple ring, and at this time you can release your hand.
      If you did not say it correctly, you must repeat it again.\nTo start, please tap the screen twice''',
        () async {
          Navigator.of(context).pushReplacementNamed(CamScreen.routeName);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("first_time", false);
        },
      ),
    ];
    PageController pageController = PageController(initialPage: 0);
    return Scaffold(
      body: PageView(
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: pageController,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 10),
            child: CarouselSlider.builder(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height,
                disableCenter: true,
                enableInfiniteScroll: false,
                viewportFraction: 1,
              ),
              itemCount: _welcomes.length,
              itemBuilder: (BuildContext context, int itemIndex, int x) =>
                  _welcomes[itemIndex],
            ),
          ),
        ],
      ),
    );
  }
}
