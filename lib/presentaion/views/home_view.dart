import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ocr/constant.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedIndex = 0;
  List<Widget> boxes = [];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void _addbox() {
    setState(() {
      boxes.add(
        Container(
          decoration: BoxDecoration(
            color: AppColors.accent2,
            borderRadius: BorderRadius.circular(20),
          ),
          height: 150,
          width: 150,
        ),
      );
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
                  ImageIcon(AssetImage('assets/images/photo3.png')),
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
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 250),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                Categories(boxicon: Icons.emoji_transportation),
                Categories(boxicon: Icons.blinds_closed_sharp),
                Categories(boxicon: Icons.integration_instructions_rounded),
                Categories(boxicon: Icons.event_busy_rounded),
              ],
            ),
          ),

          // GridView with Add Button
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  Categories({super.key, required this.boxicon});
  IconData boxicon;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondary,
      ),
      height: 100,
      width: 100,
      child: Icon(Icons.category),
    );
  }
}
