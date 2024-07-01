import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedPageIndex = 0;

  void _setPageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = _selectedPageIndex == 0 ? 'My Learning' : 'Insights';

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: const Placeholder(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _setPageIndex(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.code_rounded), label: 'My Learning'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph_rounded), label: 'Insights')
        ],
      ),
    );
  }
}
