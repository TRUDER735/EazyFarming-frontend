import 'package:crop/pages/auth/signin.dart';
import 'package:crop/pages/chat.dart';
import 'package:crop/pages/crop_recommandation.dart';
import 'package:crop/pages/field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  static const List<Widget> pages = [ SignInPage(),Chat(), CropRecommendation(), Field()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //     title: const Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       'Welcome Back',
        //       style: TextStyle(
        //         fontFamily: "Linotype",
        //         fontSize: 32.0,
        //       ),
        //     ),
        //     Text(
        //       'Mr Urombo',
        //       style: TextStyle(fontSize: 16.0),
        //     ),
        //   ],
        // )
        // ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          destinations: [
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.house,
                color: Colors.grey[800],
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.seedling,
                color: Colors.grey[800],
              ),
              label: 'Crops',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.message,
                color: Colors.grey[800],
              ),
              label: 'Chat',
            ),
            NavigationDestination(
              icon: Icon(
                FontAwesomeIcons.user,
                color: Colors.grey[800],
              ),
              label: 'Profile',
            ),
          ],
          elevation: 8.0,
        ),
        body: SafeArea(child: pages[currentPageIndex]),
      ),
    );
  }
}

// Column(
//           children: [
//             Container(
//               child: const Text('Soil Water Content : 10%'),
//             )
//           ],
//         )