import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:flutter/material.dart';

class ComparisonScreen extends StatelessWidget { const ComparisonScreen({super.key}); @override Widget build(BuildContext context) => AppShell(title: 'Property Comparison', child: ListView(padding: const EdgeInsets.all(20), children: [DataTable(columns: const [DataColumn(label: Text('Metric')), DataColumn(label: Text('Property A')), DataColumn(label: Text('Property B'))], rows: const [DataRow(cells: [DataCell(Text('Price / sq ft')), DataCell(Text('\$420 ✅')), DataCell(Text('\$510'))]), DataRow(cells: [DataCell(Text('Market rating')), DataCell(Text('Great value')), DataCell(Text('Fair'))]), DataRow(cells: [DataCell(Text('Investment score')), DataCell(Text('92')), DataCell(Text('78'))])])])); }
