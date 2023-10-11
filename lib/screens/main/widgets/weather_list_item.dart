import 'package:flutter/material.dart';
import 'package:weather_app/core/constants/asset_paths.dart';
import 'package:weather_app/core/models/weather_days_model.dart';
import 'package:weather_app/core/models/weather_hours_model.dart';
import 'package:weather_app/screens/main/widgets/temp_banner.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/color_constants.dart';

import '../../../widgets/svg_widget.dart';


class WeatherListItem extends StatefulWidget {
  final model;
  final bool isDay;
  const WeatherListItem({
    super.key,
    required this.model,
    required this.isDay,
  });

  @override
  State<WeatherListItem> createState() => _WeatherListItemState();
}

class _WeatherListItemState extends State<WeatherListItem> {
  @override
  void initState() {
    check();
    super.initState();
  }

  bool _isOrange = false;
  String FormatDate(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate =
        "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  void check() {
    final nowDate = widget.isDay
        ? DateFormat("EE").format(DateTime.now())
        : DateFormat("ka").format(DateTime.now());
    final listDate = widget.isDay
        ? DateFormat('EEE').format(widget.model?.dateTime)
        : DateFormat("ka").format(widget.model?.dateTime);

    if (listDate == nowDate) {
      setState(() {
        _isOrange = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // print("zsd ${widget.model?.dateTime }");
    return Stack(
      children: [
        Container(
          width: 50,
          height: 100,
          decoration: BoxDecoration(
              color: _isOrange ? ColorConstants.rRedColor : Colors.transparent,
              borderRadius: BorderRadius.circular(11)),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 5,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: 37,
                    height: 37,
                    decoration: BoxDecoration(
                        color: ColorConstants.backgroundColor,
                        borderRadius: BorderRadiusDirectional.circular(8)),
                    child: const SvgWidget(
                      AssetPathSvg.rainyWeather,
                      padding: EdgeInsets.only(bottom: 3.0),
                      size: 50.0,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TempBanner(
                      right: -8,
                      top: -2,
                      circleWidth: 1,
                      temp: widget.model?.temp.toStringAsFixed(0) ?? '0',
                      style: theme.textTheme.bodyMedium!.copyWith(height: 1),
                      width: 6),
                  // Text(
                  //   widget.model?.temp.toStringAsFixed(0) ?? '0',
                  //   style: theme.textTheme.bodySmall,
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.isDay
                      ? Text(
                          DateFormat('EEE').format(widget.model?.dateTime),
                          // getDayOfWeek(

                          //     DateTime.parse('${widget.model?.dateTime}')
                          //         .weekday),
                          style: theme.textTheme.bodyMedium,
                        )
                      : Text(
                          DateFormat('ka').format(widget.model?.dateTime),
                          // '${DateTime.parse('${widget.model?.dateTime}').hour}',
                          style: theme.textTheme.bodyMedium,
                        )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
