// not worked in Flutter web, use filepicker instead

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer_null_safe/flutter_full_pdf_viewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenPage extends StatelessWidget {
  const PdfGenPage({super.key, required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(path: path);
  }
}

class MyPdfHomePage extends StatelessWidget {
  MyPdfHomePage({super.key});

  final pdf = pw.Document();

  writeOnpdf() {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(3.0),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Header(
                level: 0,
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: <pw.Widget>[
                      pw.Text('GMO Flutter', textScaleFactor: 2),
                    ])),
            pw.Header(level: 1, text: 'What is Lorem Ipsum?'),

            pw.Paragraph(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit liberovolutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus molestie nunc non blandit massa. Bibendum enim facilisis gravida neque. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. '),
            pw.Paragraph(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit liberovolutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus molestie nunc non blandit massa. Bibendum enim facilisis gravida neque. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. '),
            pw.Paragraph(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit liberovolutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus molestie nunc non blandit massa. Bibendum enim facilisis gravida neque. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. '),
            pw.Paragraph(
                text:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus vitae aliquet nec. Nibh cras pulvinar mattis nunc sed blandit liberovolutpat. Vitae elementum curabitur vitae nunc sed velit. Nibh tellus molestie nunc non blandit massa. Bibendum enim facilisis gravida neque. Arcu cursus euismod quis viverra nibh cras pulvinar mattis. Enim diam vulputate ut pharetra sit. Tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum. '),
            pw.Padding(padding: const pw.EdgeInsets.all(8.0)),
            // ignore: deprecated_member_use
            pw.Table.fromTextArray(context: context, data: const <List<String>>[
              <String>['Year', 'Sample'],
              <String>['SN0', 'GFG1'],
              <String>['SN1', 'GFG2'],
              <String>['SN2', 'GFG3'],
              <String>['SN3', 'GFG4'],
            ]),
          ];
        },
      ),
    );
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
    file.writeAsBytesSync(pdf.save() as List<int>);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter PDF Preview"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            writeOnpdf();
            savePdf();
            Directory documentDirectory =
                await getApplicationDocumentsDirectory();

            String documentPath = documentDirectory.path;

            String fullPath = "$documentPath/example.pdf";
            print(fullPath);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PdfGenPage(
                          path: fullPath,
                        )));
          },
          child: const Text("Open Pdf"),
        ),
      ),
    );
  }
}
