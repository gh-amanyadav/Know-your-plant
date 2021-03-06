import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_species_detection/BulletList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';
import 'details_species.dart';

class SecondPage extends StatefulWidget {
  final String locationDetail;
  final int choice;
  const SecondPage({Key? key, required this.choice, required this.locationDetail}) : super(key: key);
  @override
  State<SecondPage> createState() => _SecondPageState(choice: choice, locationDetail: locationDetail);
}

class _SecondPageState extends State<SecondPage> {

  String locationDetail;
  int choice;
  _SecondPageState({required this.choice, required this.locationDetail});
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
    iad = (_outputs?[0]["label"] ?? "") as String;
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

  String shortDetails() {
    String sn;
    sn = (_outputs?[0]["label"] ?? "") as String;
    DetailSpecies d1 = DetailSpecies(specieName: sn);
    String shortDetails = d1.shortDetails(locationDetail);
    return shortDetails;
  }

  List longDetails() {
    String sn;
    sn = (_outputs?[0]["label"] ?? "") as String;
    DetailSpecies d1 = DetailSpecies(specieName: sn);
    List longDetails = d1.longDetails();
    return longDetails;
  }

  String iad = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            tooltip: "Back Button",
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black),
        title: const Text(
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
          child: _outputs == null
              ? Column(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 125, top: 250),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset('assets/images/Logo.png'),
                    ),
                  ),
                ])
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, right: 20),
                      child: Image.asset('assets/images/$iad-leaf.png'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 45, right: 42),
                      child: Text(
                        shortDetails(),
                        style: const TextStyle(
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
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Text(
                        "Remedial usage:",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, top: 10),
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
