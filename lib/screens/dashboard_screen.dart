import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skillshunt/providers/user_provider.dart';
import 'package:skillshunt/screens/insights_screen.dart';
import 'package:skillshunt/screens/my_learning_screen.dart';
import 'package:skillshunt/screens/signup_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _selectedPageIndex = 0;

  @override
  void initState() {
    super.initState();
    ref.read(userProvider.notifier).updateUser();
  }

  void _setPageIndex(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String activePageTitle = _selectedPageIndex == 0 ? 'My Learning' : 'Insights';
    Widget activeScreen =
        _selectedPageIndex == 0 ? const MyLearningScreen() : const InsightsScreen();

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(activePageTitle),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
                },
                icon: const Icon(Icons.power_settings_new_rounded))
          ],
        ),
        body: activeScreen,
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
        floatingActionButton: _selectedPageIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () {},
                label: const Text('New skill'),
                icon: const Icon(Icons.add),
              )
            : const SizedBox(),
      ),
    );
  }
}
