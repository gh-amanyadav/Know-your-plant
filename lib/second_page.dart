import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_species_detection/BulletList.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'dart:io';

class SecondPage extends StatefulWidget {
  final  int choice;
  const SecondPage({Key? key, required this.choice}) : super(key: key);
  @override
  State<SecondPage> createState() => _SecondPageState(choice: choice);
}

class _SecondPageState extends State<SecondPage> {

  int choice;
  _SecondPageState({required this.choice});

  List? _outputs;
  XFile? _image;
  bool _loading = false;

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
    var image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(File(_image!.path));
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
              const Padding(
                padding: EdgeInsets.only(top: 25, left: 45, right: 42),
                child: Text(
                  "The leaf you have scanned is belongs to Neem Species, which is mainly found in Uttarakhand, India.",
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
                      child: BulletList([
                        "Wound healer: Make a paste out of the neem leaves and dab it on your wounds or insect bites a few times a day till it heals.",
                        "Eye Trouble: Boil some neem leaves, let the water cool completely and then use it to wash your eyes. This will help any kind of irritation, tiredness or redness.",
                        "Boost immunity: Crush some neem leaves and take them with a glass of water to increase your immunity."
                      ])),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
