import 'package:crop/pages/chat.dart';
import 'package:crop/pages/field.dart';
import 'package:crop/pages/view.dart';
import 'package:crop/user.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
 

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
    FieldPage(id: Provider.of<UserProvider>(context).id.toString()),
    const Chat(),
    const ProfileView(),
  ];
    return MaterialApp(
      home: Scaffold(
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