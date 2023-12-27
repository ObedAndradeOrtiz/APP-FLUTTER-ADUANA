// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:app_universal/global/constants.dart';
import 'package:app_universal/widget/widget_loging.dart';
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

dynamic pdf;
String name="";
class Mypdf extends StatefulWidget {
  Mypdf(_pdf,_name,int i, {this.progressExample = false}) {
    pdf = _pdf;
    name=_name;
    clera(i);
  }
 void clera(int i)async {
  final status = await Permission.storage.request();
    if (status.isGranted) {
   dynamic externalDir = await getExternalStorageDirectory();
       var pdf= await FlutterDownloader.enqueue(
          fileName:  listaarchivosCliente[i]["nombre"],
          url: url +
              "/downloadarchivos?direccion=" +
               listaarchivosCliente[i]["direccion"] +
              "&name=" +
               listaarchivosCliente[i]["nombre"],
          savedDir: externalDir.path,
          openFileFromNotification: true,
          showNotification: false,
          saveInPublicStorage: false);
    }
    }
  final bool progressExample;

  @override
  State<Mypdf> createState() {
    if (progressExample) return _MyAppStateWithProgress();
    return _MyAppState();
  }
}

class _MyAppStateWithProgress extends State<Mypdf> {
  bool _isLoading = true;
  late PDFDocument document;
  late DownloadProgress downloadProgress;
 static downloadingCallBack(id, status, progress) {
  print(id+status);
 }
  @override
  void initState() {
    loadDocument();
    super.initState();
     FlutterDownloader.registerCallback(downloadingCallBack);
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void loadDocument() async {
    /// Clears the cache before download, so [PDFDocument.fromURLWithDownloadProgress.downloadProgress()]
    /// is always executed (meant only for testing).
    await DefaultCacheManager().emptyCache();

    PDFDocument.fromURLWithDownloadProgress(
      pdf,
      downloadProgress: (downloadProgress) => setState(() {
        this.downloadProgress = downloadProgress;
      }),
      onDownloadComplete: (document) => setState(() {
        this.document = document;
        _isLoading = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: _isLoading
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                )
              : PDFViewer(
                  document: document,
                ),
        ),
      ),
    );
  }
}

class _MyAppState extends State<Mypdf> {
  bool _isLoading = true;
  late PDFDocument document;

  @override
  void initState() {
    super.initState();
    changePDF();
  }

  changePDF() async {
    setState(() => _isLoading = true);
    
    document = await PDFDocument.fromURL(
      pdf,
    );

    // CacheManager(
    //   Config(
    //     "customCacheKey",
    //     stalePeriod: const Duration(days: 2),
    //     maxNrOfCacheObjects: 10,
    //   ),
    // );

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Vista Documento",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ]),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: _isLoading
              ? Center(child: loging(context))
              : Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    RaisedButton(
                      onPressed: () {
                        // use the email provided here
                        shareFile();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50.0,
                        width: size.width * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 38, 47, 119),
                              Color.fromARGB(200, 25, 150, 211)
                            ])),
                        padding: const EdgeInsets.all(0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Compartir",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height/1.3, child:
                    PDFViewer(
                      document: document,
                      lazyLoad: false,
                      zoomSteps: 1,
                      //uncomment below line to preload all pages
                      // lazyLoad: false,
                      // uncomment below line to scroll vertically
                      // scrollDirection: Axis.vertical,

                      //uncomment below code to replace bottom navigation with your own
                      navigationBuilder: (context, page, totalPages, jumpToPage,
                          animateToPage) {
                        return ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.first_page),
                              onPressed: () {
                                //jumpToPage()(page: 0);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                animateToPage(page: page! - 2);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                animateToPage(page: page);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.last_page),
                              onPressed: () {
                                jumpToPage(page: totalPages! - 1);
                              },
                            ),
                          ],
                        );
                      },
                    ))
                  ],
                ),
        ));
  }
  Future<void> shareFile() async {
//List<dynamic> docs = await DocumentsPicker.pickDocuments;
    // if (docs == null || docs.isEmpty) return null;

    // await FlutterShare.shareFile(
    //   title: 'Example share',
    //   text: 'Example share text',
    //   filePath: docs[0] as String,
    // );
    
    dynamic externalDir = await getExternalStorageDirectory();
    await FlutterShare.shareFile(
      title: 'Compartir archivo Universal',
      text: 'LINK DE DESCARGA:',
      filePath: "/storage/emulated/0/Android/data/com.agora.app_imex_cliente/files/"+name
    );
  }
}

// // ignore_for_file: deprecated_member_use

// import 'package:app_universal/global/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_share/flutter_share.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
// String localPath = "";
// String name = "";
// dynamic dir = getExternalStorageDirectory();

// class PdfViewerPage extends StatefulWidget {
//   PdfViewerPage(String _path, String _name) {
//     name = _name;
//     localPath = _path;
//   }
//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }

// class _PdfViewerPageState extends State<PdfViewerPage> {
//   bool _isLoading = true;
//     late PDFDocument document;
//     late DownloadProgress downloadProgress;
//      void loadDocument() async {

//     /// Clears the cache before download, so [PDFDocument.fromURLWithDownloadProgress.downloadProgress()]
//     /// is always executed (meant only for testing).
//     await DefaultCacheManager().emptyCache();

//     PDFDocument.fromURLWithDownloadProgress(
//       'https://www.ecma-international.org/wp-content/uploads/ECMA-262_12th_edition_june_2021.pdf',
//       downloadProgress: (downloadProgress) => setState(() {
//         downloadProgress = downloadProgress;
//       }),
//       onDownloadComplete: (document) => setState(() {
//         document = document;
//         _isLoading = false;
//       }),
//     );
//   }
//   @override
//   void initState() {
//     super.initState();
//      loadDocument();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
    

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Text(
//               "Vista Documento",
//               style:
//                   TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//           ]),
//           backgroundColor: primaryColor,
//         ),
//         body: Column(
//           children: [
//             SizedBox(
//               height: 15,
//             ),
//             RaisedButton(
//               onPressed: () {
//                 // use the email provided here
//                 shareFile();
//               },
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(80.0)),
//               textColor: Colors.white,
//               padding: const EdgeInsets.all(0),
//               child: Container(
//                 alignment: Alignment.center,
//                 height: 50.0,
//                 width: size.width * 0.5,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(15.0),
//                     gradient: const LinearGradient(colors: [
//                       Color.fromARGB(255, 38, 47, 119),
//                       Color.fromARGB(200, 25, 150, 211)
//                     ])),
//                 padding: const EdgeInsets.all(0),
//                 child:
//                     Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                   Icon(Icons.share),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     "Compartir",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                 ]),
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 1.3,
//               width: MediaQuery.of(context).size.width / 1,
//               child: PDFView(
//                 filePath:
//                     "/storage/emulated/0/Download/" +
//                         name,
//               ),
//             ),
//           ],
//         ));
//   }

  

