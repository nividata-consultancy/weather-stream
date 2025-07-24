import 'package:flutter/material.dart';
import 'package:weather_stream/data/model/cityweather_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import "dart:math" show pi;
import 'package:weather_stream/theme/fontsize.dart';

String getCardinalDirection(angle) {
  const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW', 'SE'];
  return directions[((angle / 45) % 8).round()];
}

class CitySkyView extends StatefulWidget {
  const CitySkyView(
      {Key? key,
      required this.cityMain,
      required this.wind,
      required this.preciption,
      required this.cityWeather,
      required this.deg,
      required this.status,
      required this.refresh,
      required this.speed,
      required this.refreshspeed,
      required this.tempMax,
      required this.tempMin})
      : super(key: key);
  final Main cityMain;
  final Wind wind;
  final double deg;
  final double tempMin;
  final double tempMax;
  final Clouds preciption;
  final bool speed;

  final void Function(bool) refreshspeed;
  final bool status;
  final void Function(bool) refresh;
  final List<CityMainWeather> cityWeather;

  @override
  State<CitySkyView> createState() => _CitySkyViewState();
}

class _CitySkyViewState extends State<CitySkyView> {
  String para = 'C';
  late bool isEnabled;
  double iconsize = 24;
  final animationDuration = const Duration(milliseconds: 00);

  TextStyle parameter = const TextStyle(
      color: Color(0xFFf9fafa), fontSize: heading, fontWeight: FontWeight.bold);
  TextStyle headstyle =
      const TextStyle(color: Colors.white70, fontSize: paraMeter);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEnabled = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 8, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (widget.status)
                        ? ((widget.cityMain.temp.toInt() * 9 / 5) + 32)
                            .toStringAsFixed(0)
                            .toString()
                        : widget.cityMain.temp.toStringAsFixed(0).toString(),
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: mainTemp, fontWeight: FontWeight.bold),
                  ),
                  (widget.status)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            '°F',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontSize: heading,
                                    ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '°C',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontSize: heading,
                                    ),
                          ),
                        ),
                ],
              ),
              const SizedBox(
                width: 17,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 18,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // double maximum = _data3!.weatherList.map(
                          // (e) => (parseDateStamp(_data2!.dt) == parseDateStamp2(e.dtTxt))
                          // ? print('yes')
                          //     : print('no'),
                          // ),
                          Text(
                            (widget.status)
                                ? ((widget.tempMax * 9 / 5) + 32)
                                        .toStringAsFixed(0)
                                        .toString() +
                                    '°'
                                : widget.tempMax.toStringAsFixed(0).toString() +
                                    '°',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: heading,
                                    ),
                          ),
                          Text(
                            ' High',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontSize: smallSize,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        size: 18,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (widget.status)
                                ? ((widget.tempMin * 9 / 5) + 32)
                                        .toStringAsFixed(0)
                                        .toString() +
                                    '°'
                                : widget.tempMin.toStringAsFixed(0).toString() +
                                    '°',
                            textAlign: TextAlign.start,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: heading,
                                    ),
                          ),
                          Text(
                            ' low',
                            style:
                                Theme.of(context).textTheme.titleMedium!.copyWith(
                                      fontSize: 12,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: 58,
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
                        height: 28,
                        width: 70,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc107),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: const Color(0xffffc107), width: 1),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '°C',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color(0xFF616161)
                                        : Colors.black,
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 26,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '°F',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color(0xFF616161)
                                        : Colors.black,
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w400,
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
                      curve: Curves.linear,
                      alignment: widget.status
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        width: 30,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          shape: BoxShape.rectangle,
                          color: const Color(0xFF29ccff),
                        ),
                        child: widget.status
                            ? Center(
                                child: Text(
                                '°F',
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.white,
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w300),
                              ))
                            : Center(
                                child: Text(
                                '°C',
                                style: TextStyle(
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.white
                                        : Colors.white,
                                    fontSize: smallSize,
                                    fontWeight: FontWeight.w300),
                              )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Card(
          color: Theme.of(context).cardTheme.color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 12.0, bottom: 12, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.preciption.all.toString() + '%',
                          style: parameter,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'PRECIPITATION',
                          style: headstyle,
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (widget.speed)
                            ? Text(
                                (widget.wind.speed * 2.237)
                                        .toStringAsFixed(2)
                                        .toString() +
                                    ' MPH',
                                style: parameter)
                            : Text(
                                widget.wind.speed
                                        .toStringAsFixed(2)
                                        .toString() +
                                    ' m/s',
                                textAlign: TextAlign.start,
                                style: parameter,
                              ),
                        Text(
                          'WIND',
                          style: headstyle,
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.cityMain.humidity.toString() + '%',
                          style: parameter,
                        ),
                        Text(
                          '     HUMIDITY     ',
                          style: headstyle,
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.rotate(
                              angle: widget.wind.deg * (pi / 180),
                              child: SvgPicture.asset(
                                'assets/weathericon/wi-wind-deg.svg',
                                height: iconsize,
                                semanticsLabel: 'A red up arrow',
                                color: const Color(0xffF9FAFA),
                              ),
                            ),
                            Text(
                              getCardinalDirection(widget.wind.deg),
                              textAlign: TextAlign.start,
                              style: parameter,
                            ),
                          ],
                        ),
                        Text(
                          '   DIRECTION ',
                          style: headstyle,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
