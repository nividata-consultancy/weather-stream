import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:weather_stream/theme/fontsize.dart';

import '../../theme/theme_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen(
      {Key? key,
      required this.refreshAir,
      required this.refresh,
      required this.speed,
      required this.boolStatus,
      required this.refreshspeed,
      required this.air})
      : super(key: key);
  final bool boolStatus;
  final bool speed;
  final bool air;
  final void Function(bool) refresh;
  final void Function(bool) refreshspeed;
  final void Function(bool) refreshAir;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isEnabled;
  late bool speedStatus;
  late bool air;
  final animationDuration = const Duration(milliseconds: 0);

  _launchPlayStore(appPackageName) async {
    try {
      print('yes');
      launchUrlString(
          "https://play.google.com/store/apps/details?id=" + appPackageName);
    } on PlatformException catch (e) {
      print('yes2');
      launchUrlString(
          "https://play.google.com/store/apps/details?id=" + appPackageName);
    } finally {
      print('yes3');
      launchUrlString(
          "https://play.google.com/store/apps/details?id=" + appPackageName);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsFlutterBinding.ensureInitialized();

    isEnabled = widget.boolStatus;
    speedStatus = widget.speed;
    air = widget.air;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              'UNIT & FORMAT',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: heading),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Temperature',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: paraMeter),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 130,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isEnabled = !isEnabled;
                      widget.refresh(isEnabled);
                    });
                  },
                  child: Container(
                    height: 27,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: const Color(0xFF29ccff), width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '°C',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '°F',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: animationDuration,
                  curve: Curves.easeInOutBack,
                  alignment:
                      isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 65,
                    height: 27,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      shape: BoxShape.rectangle,
                      color: const Color(0xFF29ccff),
                    ),
                    child: isEnabled
                        ? const Center(
                            child: Text(
                            '°F',
                            style: TextStyle(
                                color: Color(0xFFf2f2f2), fontSize: smallSize),
                          ))
                        : const Center(
                            child: Text(
                            '°C',
                            style: TextStyle(
                                color: Color(0xFFf2f2f2), fontSize: smallSize),
                          )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Speed',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: paraMeter),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 130,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      speedStatus = !speedStatus;
                      widget.refreshspeed(speedStatus);
                    });
                  },
                  child: Container(
                    height: 27,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: const Color(0xFF29ccff), width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'm/s',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'MPH',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: animationDuration,
                  alignment: speedStatus
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 65,
                    height: 27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        shape: BoxShape.rectangle,
                        color: const Color(0xFF29ccff)),
                    child: speedStatus
                        ? const Center(
                            child: Text(
                            'MPH',
                            style: TextStyle(
                                color: Color(0xFFf2f2f2), fontSize: smallSize),
                          ))
                        : const Center(
                            child: Text(
                            'm/s',
                            style: TextStyle(
                                color: Color(0xFFf2f2f2), fontSize: smallSize),
                          )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Air Pressure',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: paraMeter),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 130,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      air = !air;
                      widget.refreshAir(air);
                    });
                  },
                  child: Container(
                    height: 27,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: const Color(0xFF29ccff), width: 1),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'in/hg',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'hpa',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedAlign(
                  duration: animationDuration,
                  alignment: air ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    width: 65,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      shape: BoxShape.rectangle,
                      color: const Color(0xFF29ccff),
                    ),
                    child: air
                        ? const Center(
                            child: Text(
                            'hpa',
                            style: TextStyle(
                                color: Color(0xFFf2f2f2), fontSize: smallSize),
                          ))
                        : const Center(
                            child: Text(
                              'in/hg',
                              style: TextStyle(
                                  color: Color(0xFFf2f2f2),
                                  fontSize: smallSize),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'Theme',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: paraMeter),
          ),
          const SizedBox(height: 5),
          Consumer<ThemeManager>(
            builder: (context, value, child) => SizedBox(
              width: 130,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      context.read<ThemeManager>().toggleTheme();
                    },
                    child: Container(
                      height: 27,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color(0xFF29ccff), width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 70,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Day',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: smallSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          Container(
                            width: 55,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Night',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: smallSize,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    duration: animationDuration,
                    alignment: value.themeMode == ThemeMode.dark
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: 65,
                      height: 26,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          shape: BoxShape.rectangle,
                          color: const Color(0xFF29ccff)),
                      child: value.themeMode == ThemeMode.dark
                          ? const Center(
                              child: Text(
                              'Night',
                              style: TextStyle(
                                  color: Color(0xFFf2f2f2),
                                  fontSize: smallSize),
                            ))
                          : const Center(
                              child: Text(
                              'Day',
                              style: TextStyle(
                                  color: Color(0xFFf2f2f2),
                                  fontSize: smallSize),
                            )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: Text(
                    'ABOUT US',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: paraMeter,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  onTap: () =>
                      launchUrlString('https://nividata.com/contact-us'),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () {
                    StoreRedirect.redirect(
                      androidAppId: 'com.nividata.weather_forecast',
                      iOSAppId: '',
                    ); // _launchPlayStore('com.nividata.weather_forecast');
                  },
                  child: Text(
                    'RATE US',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: paraMeter,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () => launchUrlString('https://openweathermap.org/'),
                  child: Text(
                    'WEATHER DATA ',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: paraMeter,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 18),
                InkWell(
                  onTap: () {
                    SharePlus.instance.share(ShareParams(
                        uri: Uri.parse(
                            'https://play.google.com/store/apps/details?id=com.nividata.weather_forecast')));
                  },
                  child: Text(
                    'SHARE',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: paraMeter,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Text(
                    'Weather Forecast',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'A NIVIDATA Product',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: paraMeter),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
