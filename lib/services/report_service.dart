import 'package:ai_real_estate/models/prediction.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportService {
  const ReportService();

  Future<List<int>> buildPredictionReport(Prediction prediction) async {
    final document = pw.Document();
    document.addPage(
      pw.MultiPage(
        pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(32)),
        build: (context) => [
          pw.Text('AI Real Estate Report', style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 16),
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.blueGrey200),
              borderRadius: pw.BorderRadius.circular(12),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Location: ${prediction.input.location}'),
                pw.Text('Property type: ${prediction.input.propertyType}'),
                pw.Text('Area: ${prediction.input.area.toStringAsFixed(0)} sq ft'),
                pw.Text('Bedrooms: ${prediction.input.bedrooms}'),
                pw.Text('Bathrooms: ${prediction.input.bathrooms}'),
                pw.Text('Parking: ${prediction.input.parking}'),
              ],
            ),
          ),
          pw.SizedBox(height: 16),
          pw.Text('Predicted price: \$${prediction.price.toStringAsFixed(0)}'),
          pw.Text('Confidence: ${(prediction.confidence * 100).toStringAsFixed(0)}%'),
          pw.Text('Estimated range: \$${prediction.low.toStringAsFixed(0)} - \$${prediction.high.toStringAsFixed(0)}'),
          pw.Text('Market rating: ${prediction.rating}'),
          pw.SizedBox(height: 16),
          pw.Text('AI Recommendation', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          pw.Text(prediction.recommendation),
        ],
      ),
    );
    return document.save();
  }
}
