import 'package:flutter/material.dart';
import 'second_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Position _currentPosition;
  String _currentAddress = "";

  void getlocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("Permission not given");
      LocationPermission asked = await Geolocator.requestPermission();
    } else {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      _getAddressFromLatLng();
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = "${place.administrativeArea}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: IconButton(
                  onPressed: () {},
                  tooltip: 'Menu Icon will work soon!',
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 35,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 145),
                  child: IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () {
                      getlocation();
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  _currentAddress,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ]),
            const Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 45),
                child: Text(
                  "Hey, ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000)), //0xFF69F0AE
                ),
              ),
              Text(
                "Hiker",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000)), //0xFF35A8EA
              ),
            ]),
            const Padding(
              padding: EdgeInsets.only(left: 45, top: 20),
              child: Text(
                "Welcome to\nKnow Your Plant",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset('assets/images/plant_image1.png'),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 25, left: 45, right: 42),
                child: Text(
                  "Click or Upload your image to know about it",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A4E4D)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Card(
              color: Colors.greenAccent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15.0),
                  topLeft: Radius.circular(15.0),
                ),
              ),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF65708F),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondPage(
                                        choice: 0,
                                        locationDetail: _currentAddress,
                                      )));
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFF65708F),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SecondPage(
                                        choice: 1,
                                        locationDetail: _currentAddress,
                                      )));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
