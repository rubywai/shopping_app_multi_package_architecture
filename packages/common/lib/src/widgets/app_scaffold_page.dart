import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffoldPage extends StatefulWidget {
  const AppScaffoldPage({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  State<AppScaffoldPage> createState() => _AppScaffoldPageState();
}

class _AppScaffoldPageState extends State<AppScaffoldPage> {
  @override
  Widget build(BuildContext context) {
    StatefulNavigationShell shell = widget.shell;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) {
          shell.goBranch(index);
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.list), label: "Category"),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: "Cart"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
