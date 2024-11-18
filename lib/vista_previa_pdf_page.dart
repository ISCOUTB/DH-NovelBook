// vista_previa_pdf_page.dart
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class VistaPreviaPDFPage extends StatefulWidget {
  final String urlPDF;
  const VistaPreviaPDFPage({super.key, required this.urlPDF});

  @override
  // ignore: library_private_types_in_public_api
  _VistaPreviaPDFPageState createState() => _VistaPreviaPDFPageState();
}

class _VistaPreviaPDFPageState extends State<VistaPreviaPDFPage> {
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.urlPDF), // Usa openAsset si tienes archivos locales, o revisa si hay un método equivalente para URLs.
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vista Previa del PDF'),
      ),
      body: PdfViewPinch(
        controller: _pdfController,
      ),
    );
  }
}
