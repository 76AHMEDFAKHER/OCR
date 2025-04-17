import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr/constant.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: GoogleFonts.anton(
        textStyle: TextStyle(color: AppColors.secondary),
      ),
    ),
    Text(
      'Index 1: Business',
      style: GoogleFonts.anton(
        textStyle: TextStyle(color: AppColors.secondary),
      ),
    ),
    Text(
      'Index 2: School',
      style: GoogleFonts.anton(
        textStyle: TextStyle(color: AppColors.secondary),
      ),
    ),
  ];

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      drawer: Drawer(
        width: 250,
        elevation: 10,
        backgroundColor: AppColors.accent,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.primary),
              child: Stack(
                children: [
                  ImageIcon(
                    AssetImage(
                      'assets/images/Screenshot 2025-04-10 112820.png',
                    ),
                  ),
                  Text('Drawer Header'),
                ],
              ),
            ),
            ListTile(
              iconColor: AppColors.secondary,
              selected: selectedIndex == 0,
              leading: Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);

                _onItemTapped(0);
              },
            ),
            ListTile(
              selected: selectedIndex == 1,
              iconColor: AppColors.secondary,
              leading: const Icon(Icons.camera_rounded),
              title: const Text('Take a text'),
              onTap: () {
                Navigator.pop(context);
                context.go('/camera');
                _onItemTapped(1);
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Row(
            spacing: 50,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Builder(
                  builder:
                      (context) => IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: AppColors.secondary,
                          size: 60,
                        ),
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.asset('assets/images/Asset 1@2x.png', width: 140),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 30),
                child: CircleAvatar(
                  radius: 20,
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Image.asset(
                      'assets/images/Generated Image April 10, 2025 - 11_45AM.jpeg',
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Text(
                  'CATEGORIES',
                  style: GoogleFonts.anton(
                    textStyle: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 150,
                  width: 150,
                  child: Icon(Icons.car_crash_outlined),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 150,
                  width: 150,
                  child: Icon(Icons.wash),
                ),
              ),
            ],
          ),
          SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 150,
                  width: 150,
                  child: Icon(Icons.car_crash_outlined),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 300),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 150,
                  width: 150,
                  child: Icon(Icons.car_crash_outlined),
                ),
              ),
            ],
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 150,
                width: 150,
                child: Icon(Icons.add_circle_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
