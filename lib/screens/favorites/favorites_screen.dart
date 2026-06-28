import 'package:ai_real_estate/providers/prediction_provider.dart';
import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesScreen extends ConsumerWidget { const FavoritesScreen({super.key}); @override Widget build(BuildContext context, WidgetRef ref) { final favorites = ref.watch(predictionControllerProvider).valueOrNull?.where((e) => e.favorite).toList() ?? []; return AppShell(title: 'Favorites', child: favorites.isEmpty ? const Center(child: Text('Favorite predictions appear here.')) : ListView(padding: const EdgeInsets.all(20), children: favorites.map((p) => Card(child: ListTile(leading: const Icon(Icons.favorite), title: Text(p.input.location), subtitle: Text('\$${p.price.toStringAsFixed(0)}')))).toList())); } }
