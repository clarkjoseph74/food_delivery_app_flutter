import 'package:flutter/material.dart';
import 'package:food_delivery_app/Controllers/home_controller.dart';
import 'package:food_delivery_app/View/widgets/common_widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        body: controller.screens[controller.currentScreenIndex],
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: GNav(
              haptic: true,
              hoverColor: primaryColor,
              gap: 8,
              padding: EdgeInsets.all(10),
              rippleColor: primaryColor,
              textStyle: GoogleFonts.nunito(fontWeight: FontWeight.bold),
              tabBackgroundColor: primaryColor.withOpacity(0.6),
              selectedIndex: controller.currentScreenIndex,
              onTabChange: (value) {
                controller.changeScreenIndex(value);
              },
              tabs: [
                GButton(
                  padding: EdgeInsets.all(10),
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  padding: EdgeInsets.all(10),
                  icon: Icons.restaurant_menu_rounded,
                  text: "Restaurant",
                ),
                GButton(
                  padding: EdgeInsets.all(10),
                  icon: Icons.search,
                  text: "Search",
                ),
                GButton(
                  padding: EdgeInsets.all(10),
                  icon: Icons.person,
                  text: "Profile",
                )
              ]),
        ),
      ),
    );
  }
}
