import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:timer_snackbar/timer_snackbar.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/Login.dart';

class OCRscreen extends StatefulWidget {
  const OCRscreen({Key? key}) : super(key: key);

  @override
  State<OCRscreen> createState() => _OCRscreenState();
}

List<Asset> images = <Asset>[];

class _OCRscreenState extends State<OCRscreen> {
  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = '';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarColor: "#FFBEB2",
          statusBarColor: "#FFBEB2",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Future<File> generatePDFFile(XFile imageFile) async {
    final pdf = pw.Document();

    final image = pw.MemoryImage(
      await imageFile.readAsBytes(),
    );

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ),
    );

    final output = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final file = File('${output.path}/image_$timestamp.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  String scannedText = "";
  XFile? imageFile;
  bool textScanning = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OCR"),
        centerTitle: true,
        elevation: 0, // remove the border
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (textScanning) CircularProgressIndicator(),
              if (!textScanning && imageFile == null)
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.grey[300],
                ),
              if (imageFile != null) Image.file(File(imageFile!.path)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        shadowColor: Theme.of(context).primaryColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.image,
                              size: 30,
                            ),
                            Text(
                              "Gallery",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        shadowColor: Theme.of(context).primaryColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.camera,
                              size: 30,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white,
                        shadowColor: Theme.of(context).primaryColor,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // onPressed: () {
                      //   getImage(ImageSource.camera);

                      // },
                      onPressed: () async {
                        if (imageFile != null) {
                          final pdfFile = await generatePDFFile(imageFile!);
                          final output = await getExternalStorageDirectory();
                          final now = DateTime.now();
                          final formatter = DateFormat('yyyy-MM-dd_HH-mm-ss');
                          final fileName = 'image_${formatter.format(now)}.pdf';
                          final file = File('${output!.path}/$fileName');
                          await file.writeAsBytes(await pdfFile.readAsBytes());
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('PDF file saved to ${file.path}'),
                            ),
                          );
                        }
                        if (imageFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('No Image available'),
                            ),
                          );
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.download_rounded,
                              size: 30,
                            ),
                            Text(
                              "Download image",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  scannedText,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    timerSnackbar(
                      context: context,
                      contentText: "Copied to clipboard!",
                      afterTimeExecute: () {},
                      buttonLabel: "",
                      backgroundColor: Color.fromARGB(255, 38, 166, 154),
                      buttonPrefixWidget: null,
                      second: 1,
                    );

                    final data = ClipboardData(text: scannedText);
                    Clipboard.setData(data);
                  },
                  child: Text(
                    "Copy to clipboard",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        textScanning = true;
        imageFile = pickedImage;
        setState(() {});
        getRecognizedText(pickedImage);
        final bytes = await pickedImage.readAsBytes();
      }
    } catch (e) {
      textScanning = false;
      imageFile = null;
      setState(() {});
      scannedText = "Error occured while scanning";
    }
  }

  void getRecognizedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    RecognizedText recognizedText = await textDetector.processImage(inputImage);
    await textDetector.close();
    scannedText = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        scannedText = scannedText + line.text + "\n";
      }
    }
    textScanning = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }
}
