import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_species_detection/BulletList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'details_species.dart';

class SecondPage extends StatefulWidget {
  final int choice;
  const SecondPage({Key? key, required this.choice}) : super(key: key);
  @override
  State<SecondPage> createState() => _SecondPageState(choice: choice);
}

class _SecondPageState extends State<SecondPage> {
  int choice;
  _SecondPageState({required this.choice});
  XFile? _image;
  bool _loading = false;
  List? _outputs;
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    choice == 0 ? getImageCamera() : getImageGallery();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
    );
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true);
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future getImageCamera() async {
    var image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }

  Future getImageGallery() async {
    var image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
  }

  String shortdetails() {
    String sn;
    sn = (_outputs?[0]["label"] ?? "") as String;
    DetailSpecies d1 = DetailSpecies(specieName: sn);
    String shortDetails = d1.shortDetails();
    return shortDetails;
  }

  List longDetails() {
    String sn;
    sn = (_outputs?[0]["label"] ?? "") as String;
    DetailSpecies d1 = DetailSpecies(specieName: sn);
    List longDetails = d1.longDetails();
    return longDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            tooltip: "Back Button",
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black),
        title: Text(
          "Know Your Plant",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.00,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, right: 20),
                child: Image.asset('assets/images/neem-leaf.png'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25, left: 45, right: 42),
                child: Text(
                  shortdetails(),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                      textBaseline: TextBaseline.alphabetic,
                      color: Color(0xFF4A4E4D)),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Remedial usage:",
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, top: 10),
                    child: BulletList(longDetails()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
