import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_netflix_clone/Screen/netflix_home_screen.dart';

class AppNavbarScreen extends StatelessWidget {
  const AppNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(bottomNavigationBar: Container(
        color: Colors.black,
        height: 70,
        child: TabBar(
          tabs: [
            Tab(icon: Icon(Iconsax.home5), text: "Home"),
            Tab(icon: Icon(Iconsax.search_normal), text: "Search"),
            Tab(icon: Icon(Iconsax.home5), text: "Hot News"),
          ],
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorColor: Colors.transparent,
        ),
      ),
        body: TabBarView(children: [NetflixHomeScreen(), Scaffold(), Scaffold()]),
      ),
    );
  }
}
