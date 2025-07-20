import 'package:book_app/features/books/presentation/pages/favorite_page.dart';
import 'package:flutter/material.dart';

import 'package:book_app/features/books/presentation/pages/book_list_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // These pages will be preserved thanks to IndexedStack
  final List<Widget> _screens = const [
    BookListPage(),
    FavoritesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: Text("Home", style: GoogleFonts.poppins()),
            selectedColor: Colors.deepPurple,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite),
            title: Text("Favorites", style: GoogleFonts.poppins()),
            selectedColor: Colors.deepOrange,
          ),
        ],
      ),
    );
  }
}
