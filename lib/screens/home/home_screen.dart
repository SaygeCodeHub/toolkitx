import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_bloc.dart';
import '../../blocs/home/home_events.dart';
import '../../configs/app_dimensions.dart';
import '../../configs/app_spacing.dart';
import 'widgets/date_time_section.dart';
import 'widgets/modules_grid_layout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(const StartTimer());
    context.read<HomeBloc>().add(const SaveUserDevice());
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(kBodyMargin),
            child: Column(children: [
              const SizedBox(height: xxxSmallerSpacing),
              const DateAndTimeSection(),
              const SizedBox(height: xxxSmallerSpacing),
              Expanded(
                  child: ScrollConfiguration(
                      behavior:
                          const ScrollBehavior().copyWith(overscroll: false),
                      child: const SingleChildScrollView(
                          child: ModulesGridLayout())))
            ])));
  }
}
