import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.title, required this.child});
  final String title; final Widget child;
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title), actions: [IconButton(onPressed: () => context.go('/settings'), icon: const Icon(Icons.settings_outlined))]), drawer: NavigationDrawer(children: [const DrawerHeader(child: Text('AI Real Estate', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))), ...{'Home':'/','Predict':'/predict','Dashboard':'/dashboard','Compare':'/compare','History':'/history','Favorites':'/favorites','Reports':'/reports','Map':'/map'}.entries.map((e) => ListTile(title: Text(e.key), onTap: () => context.go(e.value))) ]), body: SafeArea(child: child));
}
