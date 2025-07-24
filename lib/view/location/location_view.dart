import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather_stream/theme/fontsize.dart';
import '../../data/model/locationscreen_arguments.dart';
import '../home/home_view.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);
  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  Position? _currentPosition;
  bool? complete;
  void getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  void getAddressFromLatLng() async {
    try {
      setState(() {
        Navigator.pushNamed(
          context,
          HomeView.routeName,
          arguments: LocationScreenArguments(
            lat: _currentPosition!.latitude,
            searched: false,
            lon: _currentPosition!.longitude,
          ),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      complete = false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openLocationSettings();
        complete = false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await openAppSettings();
      complete = false;
    }

    complete = true;
    return getCurrentLocation();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const Scaffold(body: Center(child: CircularProgressIndicator())),
          Center(
            child: Opacity(
              opacity: 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/weathericon/map.svg',
                    height: 100,
                    width: 100,
                    allowDrawingOutsideViewBox: true,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Search your Location',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: paraMeter, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Text(
                      'Search and get real time weather \n    information of your Location',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: smallSize, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFf5490f)),
                    ),
                    child: const Text(
                      'Search Location',
                      style: TextStyle(
                        color: Color(0xFFf2f2f2),
                        fontSize: smallSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
