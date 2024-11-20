import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';

class SavePdfPage extends StatelessWidget {
  const SavePdfPage({super.key});

  Future<void> _generateAndSavePdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text("Hello, this is a sample PDF!", style: pw.TextStyle(fontSize: 24)),
        ),
      ),
    );

    try {

      final Directory directory = await getApplicationDocumentsDirectory();
      final String path = "${directory.path}/sample.pdf";
      final File file = File(path);

      await file.writeAsBytes( await pdf.save(), flush: true );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("PDF sauvegardé avec succès dans : $path")),
      );
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la sauvegarde du PDF : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sauvegarder PDF")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _generateAndSavePdf(context),
          child: const Text("Générer et sauvegarder PDF"),
        ),
      ),
    );
  }
}
