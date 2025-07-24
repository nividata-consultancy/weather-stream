import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:weather_stream/theme/fontsize.dart';
import '../../data/model/cityweather_detail.dart';
import '../../utils/currency_peakerutils.dart';

String parseTimeStamp(int value) {
  var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
  var d12 = DateFormat('EEEE, MMMM dd , yyyy').format(date);
  return d12;
}

String parseTimeStamp2(int value) {
  var date = DateTime.fromMillisecondsSinceEpoch(value * 1000);
  var d12 = DateFormat().add_jm().format(date);
  return d12;
}

class CityTimeView extends StatefulWidget {
  const CityTimeView({
    Key? key,
    required this.cityTime,
    required this.date,
    required this.cityWeather,
    required this.iconName,
    required this.refresh,
    required this.sunrise,
    required this.sunset,
  }) : super(key: key);
  final Sys cityTime;

  final List<CityMainWeather> cityWeather;
  final int date;
  final String iconName;

  final int sunrise;
  final int sunset;
  final void Function() refresh;

  @override
  State<CityTimeView> createState() => _CityTimeViewState();
}

class _CityTimeViewState extends State<CityTimeView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: 200,
            child: Text(
              CurrencyPickerUtils.getCountryByIsoCode(widget.cityTime.country),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: paraMeter,
                  ),
            ),
          ),
        ),
        Center(
          child: Text(
            parseTimeStamp(widget.date),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontSize: smallSize, fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/weathericon/' + widget.iconName + '.svg',
                height: 100,
                semanticsLabel: 'A red up arrow',
                color: Theme.of(context).iconTheme.color,
              ),
              Column(
                children: [
                  SvgPicture.asset(
                    'assets/weathericon/sunrise.svg',
                    height: 50,
                    width: 50,
                    semanticsLabel: 'A red up arrow',
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    parseTimeStamp2(widget.sunrise),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: smallSize, fontStyle: FontStyle.italic),
                  ),
                  SvgPicture.asset(
                    'assets/weathericon/sunset.svg',
                    height: 50,
                    width: 50,
                    semanticsLabel: 'A red up arrow',
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    parseTimeStamp2(widget.sunset),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: smallSize, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 9),
          child: Text(
            widget.cityWeather[0].description,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                ),
          ),
        ),
      ],
    );
  }
}
