import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFPreview extends StatefulWidget {
  final String pdf;
  const PDFPreview({Key? key, required this.pdf}) : super(key: key);

  @override
  State<PDFPreview> createState() => _PDFPreviewState();
}

class _PDFPreviewState extends State<PDFPreview> {
  // PdfScrollDirection selectedOption = PdfScrollDirection.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
          actions: [
            // PopupMenuButton<PdfScrollDirection>(
            //   icon: Icon(
            //     Icons.menu,
            //     color: Colors.grey,
            //   ),
            //   onSelected: (value) {
            //     setState(() {
            //       selectedOption = value;
            //     });
            //   },
            //   itemBuilder: (BuildContext context) => [
            //     PopupMenuItem<PdfScrollDirection>(
            //       value: PdfScrollDirection.horizontal,
            //       child: Text('Horizontal View'),
            //     ),
            //     PopupMenuItem<PdfScrollDirection>(
            //       value: PdfScrollDirection.vertical,
            //       child: Text('Vertical View'),
            //     ),
            //   ],
            // ),
          ]),
      // body: Container(
      //     child: SfPdfViewer.network(widget.pdf,
      //         scrollDirection: selectedOption))

      body: PDF().cachedFromUrl(
        widget.pdf,
        placeholder: (progress) =>
            Center(child: Text('$progress %  downloading ......')),
        errorWidget: (error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
