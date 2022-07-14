import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mal_app/services/apptheme.dart';
import 'package:my_mal_app/views/animepage.dart';
import 'package:my_mal_app/views/explorepage.dart';
import 'package:my_mal_app/views/home.dart';
import 'package:my_mal_app/views/profilepage.dart';

void main() {
  runApp(DynamicColorBuilder(
    builder: (lightDynamic, darkDynamic) {
      return MaterialApp(
        theme: AppTheme.lightTheme(lightDynamic),
        darkTheme: AppTheme.darkTheme(darkDynamic),
        debugShowCheckedModeBanner: false,
        home: MainPage(),
        initialRoute: '/',
        routes: {
          '/animepage': (context) => AnimePage(),
        },
      );
    },
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final screens = [
    ProfilePage(),
    Home(),
    ExplorePage(),
  ];
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            // indicatorColor: Colors.blue[100],
            labelTextStyle: MaterialStateProperty.all(
          GoogleFonts.openSans(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            fontSize: 15,
            letterSpacing: 0.3,
          ),
        )),
        child: NavigationBar(
          // backgroundColor: Color.fromARGB(255, 233, 249, 252),
          height: 80,
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'Explore',
            ),
          ],
        ),
      ),
    );
  }
}
