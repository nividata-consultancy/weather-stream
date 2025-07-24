import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_stream/data/model/callingFromId.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_stream/theme/fontsize.dart';

import '../../data/model/suggestion.dart';
import '../../data/prefrences/shared_preference.dart';
import 'home_view.dart';

class DrawerScreen extends StatefulWidget {
  final SharedPreference sharedPreferenceHelper;
  final Function(double, double) refreshApi;
  final Function(double, double) refreshApiForest;
  final Function clearSearch;
  final Function clearSingleSearch;
  final double drawerLat;
  final double drawerLon;
  final String currentCity;
  const DrawerScreen({
    Key? key,
    required this.sharedPreferenceHelper,
    required this.refreshApi,
    required this.clearSearch,
    required this.clearSingleSearch,
    required this.drawerLat,
    required this.currentCity,
    required this.drawerLon,
    required this.refreshApiForest,
  }) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List<Predictions> suggestions = [];
  late Location locations;

  void geoCodingCalling(String value, String sessionToken) async {
    var x = await api.fetchSuggestions(value, sessionToken);
    setState(() {
      suggestions = x;
    });
  }

  final myController = TextEditingController();
  bool searchStatus = false;

  void getLatLon(String value) async {
    var x = await api.requestFromPlaceId(value);

    widget.refreshApi(x!.lat.toDouble(), x.lng.toDouble());
    widget.refreshApiForest(x.lat, x.lng.toDouble());
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 36.0 + MediaQuery.of(context).padding.top),
          child: Image.asset(
            'assets/weathericon/main.png',
            height: 56,
            width: 56,
          ),
        ),
        const SizedBox(height: 17),
        Text(
          'Weather Forecast',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontSize: heading, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Theme.of(context).brightness == Brightness.light
                ? const Color(0x92d2d2d2)
                : const Color(0x92d2d2d2),
          ),
          margin: const EdgeInsets.only(left: 24, top: 0, right: 24),
          height: 44,
          child: Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Location Search',
                border: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: Theme.of(context).brightness == Brightness.light
                      ? const Color(0xFF37474F)
                      : const Color(0xFFf9f9f9),
                  size: 20,
                ),
                labelStyle: TextStyle(
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFF616161)
                        : const Color(0xFFececec),
                    fontSize: 12),
              ),
              onChanged: (value) {
                if (value.length > 3) {
                  final sessionToken = const Uuid().v4();
                  setState(() {
                    searchStatus = true;
                  });
                  geoCodingCalling(value, sessionToken);
                }
              },
            ),
          ),
        ),
        (searchStatus)
            ? suggestions.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 0.0, bottom: 10),
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        semanticsLabel: 'Linear progress indicator',
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount:
                            (suggestions.length > 3) ? 4 : suggestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 47,
                            margin:
                                EdgeInsets.only(left: 24, right: 24, bottom: 7),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? const Color(0x92d2d2d2)
                                  : const Color(0x92d2d2d2),
                            ),
                            child: ListTile(
                              dense: true,
                              autofocus: true,
                              onTap: () {
                                getLatLon(
                                  suggestions[index].placeId,
                                );
                                // Navigator.of(context).pop();
                              },
                              focusColor: const Color(0x92d2d2d2),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    left: 14.0, right: 10),
                                child: Text(
                                  suggestions[index].description,
                                  maxLines: 3,
                                  softWrap: false,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
            : Container(
                decoration: const BoxDecoration(color: Color(0x92d2d2d2)),
              ),
        Padding(
          padding:
              const EdgeInsets.only(top: 16, left: 35, right: 24, bottom: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Search',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: smallSize, fontStyle: FontStyle.italic),
              ),
              InkWell(
                onTap: () {
                  widget.clearSearch();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).brightness == Brightness.light
                        ? const Color(0xFFffc107)
                        : const Color(0xFFffc107),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Clear Search',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? const Color(0xFFF9FAFA)
                                  : const Color(0xFFF9FAFA),
                          fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              ...widget.sharedPreferenceHelper
                  .getPlaceList()
                  .map((e) => InkWell(
                        onTap: () {
                          widget.refreshApi(e.lat, e.lon);
                          widget.refreshApiForest(e.lat, e.lon);
                          Navigator.of(context).pop();
                        },
                        child: Dismissible(
                          key: Key(e.name),
                          direction:
                              (widget.drawerLat.toInt() == e.lat.toInt() &&
                                      widget.drawerLon.toInt() == e.lon.toInt()
                                  ? DismissDirection.none
                                  : DismissDirection.startToEnd),
                          onDismissed: (direction) {
                            setState(() {
                              widget.clearSingleSearch(e);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.name + ' dismissed')));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/weathericon/' + e.imageUrl + '.svg',
                                    height: 47,
                                    width: 50,
                                    color: Theme.of(context).iconTheme.color,
                                    semanticsLabel: 'A red up arrow'),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: menuPara,
                                                fontWeight: FontWeight.w500),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                    Text(
                                      e.country,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: smallSize,
                                          ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  e.temp.toStringAsFixed(1).toString() + ' °',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: heading,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ],
    ));
  }
}
