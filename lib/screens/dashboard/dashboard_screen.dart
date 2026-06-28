import 'package:ai_real_estate/widgets/app_shell.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget { const DashboardScreen({super.key}); @override Widget build(BuildContext context) => AppShell(title: 'Market Analytics', child: GridView.count(padding: const EdgeInsets.all(20), crossAxisCount: MediaQuery.sizeOf(context).width > 800 ? 2 : 1, childAspectRatio: 1.5, children: ['Price Distribution','Area vs Price','Bedrooms vs Price','Location Comparison','Monthly Trends'].map((title) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), Expanded(child: LineChart(LineChartData(lineBarsData: [LineChartBarData(spots: const [FlSpot(0, 2), FlSpot(1, 3), FlSpot(2, 2.4), FlSpot(3, 4)])])))])))).toList())); }
