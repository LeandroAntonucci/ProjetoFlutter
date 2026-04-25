import 'package:flutter/material.dart';
import '../screens.dart';
import 'app_bottom_navigation.dart';
import 'custom_app_bar.dart';


class MainScreen extends StatefulWidget {
  final int initialIndex;

  const MainScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _index;

  final List<Widget> _pages = const [
    HomeScreen(),
    ChatScreen(),
    TaskScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
  }

  void _onTap(int i) {
    setState(() {
      _index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: const CustomAppBar(),
      body: IndexedStack(
        index: _index,
        children: _pages,
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _index,
        onTap: _onTap,
      ),
    );
  }
}