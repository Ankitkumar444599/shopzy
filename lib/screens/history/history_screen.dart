import 'package:ai_real_estate/providers/prediction_provider.dart';
import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(predictionControllerProvider);
    return AppShell(
      title: 'Prediction History',
      child: state.when(
        data: (_) {
          final items = ref.read(predictionControllerProvider.notifier).search(query);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: SearchBar(
                  hintText: 'Search by location, type, or rating',
                  onChanged: (value) => setState(() => query = value),
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const Center(child: Text('No matching predictions found.'))
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final prediction = items[index];
                          return Card(
                            child: ListTile(
                              title: Text('\$${prediction.price.toStringAsFixed(0)} • ${prediction.input.location}'),
                              subtitle: Text(prediction.recommendation),
                              trailing: Wrap(
                                children: [
                                  IconButton(
                                    icon: Icon(prediction.favorite ? Icons.favorite : Icons.favorite_border),
                                    onPressed: () => ref.read(predictionControllerProvider.notifier).favorite(prediction.id),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline),
                                    onPressed: () => ref.read(predictionControllerProvider.notifier).delete(prediction.id),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
      ),
    );
  }
}
