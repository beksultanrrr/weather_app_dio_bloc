import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/asset_paths.dart';
import 'package:weather_app/core/models/weather_days_model.dart';
import 'package:weather_app/core/models/weather_hours_model.dart';

import 'package:weather_app/screens/main/bloc/main_bloc.dart';
import 'package:weather_app/screens/main/widgets/temp_banner.dart';
import 'package:weather_app/screens/main/widgets/weather_list_item.dart';

import '../../core/constants/color_constants.dart';

import '../../widgets/png_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late final AnimationController _controller;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 16))
          ..repeat();
    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  double turns = 0.0;
  void _changeRotation() {
    setState(() => turns += 1.0 / 8.0);
  }

  @override
  Widget build(BuildContext context) {
    final Size phoneSize = MediaQuery.of(context).size;

    final width = phoneSize.width / 3;
    final height = phoneSize.height - 200;
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        BlocConsumer<MainBloc, MainState>(
            listener: (context, state) {},
            builder: (BuildContext context, MainState state) {
              final bloc = context.read<MainBloc>();

              return Scaffold(
                body: RefreshIndicator(
                  onRefresh: () async => bloc.add(InitialMainEvent()),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.55,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  right: -(phoneSize.width * 0.35),
                                  top: -120.0,
                                  child: Transform.rotate(
                                    angle: _controller.value * 2 * 3.14,
                                    child: const PngWidget(
                                      AssetPathPng.cloudWeather,
                                      size: 350,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: height * 0.45,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: Column(
                                    children: [
                                      TempBanner(
                                        style: theme.textTheme.titleLarge!
                                            .copyWith(height: 1),
                                        temp: state.weather?.temp
                                                .toStringAsFixed(0) ??
                                            '0',
                                        width: 18,
                                        right: -20,
                                        top: -10,
                                        circleWidth: 5,
                                      ),
                                      Text(state.weather?.condition ?? "",
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(height: 0.8)),
                                      const SizedBox(height: 24.0),
                                      Text(
                                        state.weather?.city ?? '',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.titleSmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 48,
                                child: TabBar(
                                  isScrollable: true,
                                  controller: _tabController,
                                  indicatorColor: ColorConstants.rRedColor,
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 0),
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: theme.textTheme.bodyMedium,
                                  tabs: [
                                    SizedBox(
                                      width: width,
                                      child: const Tab(
                                        text: "Today",
                                      ),
                                    ),
                                    SizedBox(
                                      width: width,
                                      child: const Tab(
                                        text: 'Tomorrow',
                                      ),
                                    ),
                                    SizedBox(
                                      width: width,
                                      child: const Tab(
                                        text: "Next 7 days",
                                      ),
                                    ),
                                  ],
                                  labelColor: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                // color: Colors.yellow,
                                height: 137,
                                child: TabBarView(
                                    controller: _tabController,
                                    children: [
                                      TapBarSevenDaysItem(
                                        model: state.weatherToday,
                                        isDay: false,
                                      ),
                                      TapBarSevenDaysItem(
                                        model: state.weatherTomorrow,
                                        isDay: false,
                                        isOrange: false,
                                      ),
                                      TapBarSevenDaysItem(
                                        model: state.weather7Days,
                                        isDay: true,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}

class TapBarSevenDaysItem extends StatelessWidget {
  final List model;
  final bool isDay;
  final bool? isOrange;
  const TapBarSevenDaysItem(
      {super.key, required this.model, required this.isDay, this.isOrange});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: model.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          final item = model[index];
          return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: WeatherListItem(
                isOrange: isOrange,
                model: item,
                isDay: isDay,
              ));
        });
  }
}
