import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_stream/theme/fontsize.dart';

import '../../data/model/cityweather_detail.dart';
import '../../data/model/forecastweather.dart';
import '../../utils/currency_peakerutils.dart';
import 'home_view.dart';

const String iosKey = 'AIzaSyCe2AX8feMvRO1_Q2fV5eERERm0RAX_1a0';

class BottomBarCard extends StatelessWidget {
  const BottomBarCard({
    Key? key,
    required this.humidity,
    required this.windStatus,
    required this.wind,
    required this.date,
    required this.city,
    required this.country,
    required this.preStatus,
    required this.groundLevel,
    required this.percipiation,
    required this.pod,
    required this.pressure,
    required this.rain,
    required this.seaLevel,
    required this.parameter,
    required this.forestWeatherList,
    required this.cityWeatherList,
    required this.index,
  }) : super(key: key);
  final bool parameter;
  final String city;
  final String country;
  final String date;
  final int humidity;
  final bool windStatus;
  final double pressure;
  final String pod;
  final double rain;
  final double percipiation;
  final double wind;
  final double groundLevel;
  final double seaLevel;
  final bool preStatus;
  final double textsize = 13;
  final double iconsize = 19;
  final double valueSize = 16;
  final int index;
  final ForecastWeather? forestWeatherList;
  final CityWeather? cityWeatherList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 285,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 12.0, left: 11, right: 11, bottom: 8),
        child: Column(
          children: [
            Text(
              city,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: heading),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              CurrencyPickerUtils.getCountryByIsoCode(country),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w400, fontSize: paraMeter),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              decoration: BoxDecoration(
                  color: (parseDateStamp(cityWeatherList!.dt) ==
                          parseDateStamp2(
                              forestWeatherList!.weatherList[index].dtTxt))
                      ? Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFF29ccff)
                          : const Color(0xFF29ccff)
                      : Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFFd9d9d9)
                          : const Color(0xFFd9d9d9),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 6),
                child: Text(
                  DateFormat('EEE ').format(
                          DateFormat("yyyy-MM-dd hh:mm:ss").parse(date)) +
                      DateFormat().add_j().format(
                          DateFormat("yyyy-MM-dd hh:mm:ss").parse(date)),
                  style: TextStyle(
                      fontSize: 11,
                      color: (parseDateStamp(cityWeatherList!.dt) ==
                              parseDateStamp2(
                                  forestWeatherList!.weatherList[index].dtTxt))
                          ? Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : Colors.white
                          : Theme.of(context).brightness == Brightness.light
                              ? const Color(0xFF37474F)
                              : Colors.black87,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                percipiation.toStringAsFixed(2).toString() +
                                    '%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: paraMeter),
                              ),
                              Text(
                                'PRECIPITATION',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: bottomPara),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                humidity.toStringAsFixed(1).toString() + '%',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: paraMeter),
                              ),
                              Text('HUMIDITY',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: bottomPara))
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              (windStatus)
                                  ? Text(
                                      (wind * 2.237)
                                              .toStringAsFixed(2)
                                              .toString() +
                                          ' MPH',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: paraMeter),
                                    )
                                  : Text(
                                      wind.toStringAsFixed(2).toString() +
                                          ' m/s',
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: paraMeter),
                                    ),
                              Text(
                                ' WIND',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: bottomPara),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(rain.toStringAsFixed(0).toString() + ' mm',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          fontSize: paraMeter)),
                              Text(
                                'RAIN VOLUME',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: bottomPara),
                              )
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                pod.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: paraMeter),
                              ),
                              Text(
                                'SYSTEM POD',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: bottomPara),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                (preStatus)
                                    ? pressure.toStringAsFixed(1).toString() +
                                        ' hpa'
                                    : (pressure / 33.863886)
                                            .toStringAsFixed(1)
                                            .toString() +
                                        ' In/HG',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: paraMeter),
                              ),
                              Text(
                                'PRESSURE',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: bottomPara),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            groundLevel.toStringAsFixed(2).toString() +
                                ' in/Hg',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: paraMeter),
                          ),
                          Text(
                            'GROUND-LEVEL',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: bottomPara),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            seaLevel.toStringAsFixed(2).toString() + '%',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: paraMeter),
                          ),
                          Text(
                            'SEA-LEVEL',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: bottomPara),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
