import 'package:intl/intl.dart';

final usd = NumberFormat.simpleCurrency(name: 'USD');

String formatUsd(num value) => usd.format(value);
