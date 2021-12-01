import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mydevapp/theme/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = 'Null, Press Button';
  String Address = 'search';
  final bool _floating = true;

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.subLocality} ${place.locality}';
    setState(() {});
  }

  getUserParmission() async {
    Position position = await _getGeoLocationPosition();
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    await getAddressFromLatLong(position);
  }

  @override
  void initState() {
    getUserParmission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appheight = MediaQuery.of(context).size.height;
    var appWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
            body: SizedBox(
          height: appheight * 0.07,
          width: appWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  Position position = await _getGeoLocationPosition();
                  location =
                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                  await getAddressFromLatLong(position);
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: appWidth * 0.01,
                    ),
                    Icon(
                      Icons.location_on_outlined,
                      color: mainColor,
                      size: 26,
                    ),
                    SizedBox(
                      width: appWidth * 0.01,
                    ),
                    AutoSizeText(
                      Address,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: mainColor,
                      size: 26,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.blur_circular_sharp,
                            color: Colors.black,
                            size: 17,
                          ),
                          SizedBox(
                            width: appWidth * 0.012,
                          ),
                          const Text(
                            "English",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w400),
                          )
                        ],
                      )),
                  SizedBox(
                    width: appWidth * 0.04,
                  ),
                  const CircleAvatar(
                    maxRadius: 15.0,
                    minRadius: 13.0,
                    backgroundColor: Colors.amberAccent,
                  ),
                  SizedBox(
                    width: appWidth * 0.04,
                  ),
                ],
              )
            ],
          ),
        ));
      }),
    );
  }
}
