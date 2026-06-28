import 'package:ai_real_estate/providers/prediction_provider.dart';
import 'package:ai_real_estate/services/notification_service.dart';
import 'package:ai_real_estate/services/report_service.dart';
import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final predictions = ref.watch(predictionControllerProvider).valueOrNull ?? [];
    return AppShell(
      title: 'Reports',
      child: predictions.isEmpty
          ? const Center(child: Text('Create a prediction before exporting a professional PDF report.'))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: predictions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final prediction = predictions[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.picture_as_pdf_outlined),
                    title: Text('${prediction.input.location} report'),
                    subtitle: Text('\$${prediction.price.toStringAsFixed(0)} • ${prediction.rating}'),
                    trailing: FilledButton(
                      onPressed: () async {
                        final bytes = await const ReportService().buildPredictionReport(prediction);
                        await Printing.layoutPdf(onLayout: (_) async => bytes);
                        await NotificationService.notify(
                          'Report ready',
                          'Your ${prediction.input.location} report was generated.',
                        );
                      },
                      child: const Text('Export'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
