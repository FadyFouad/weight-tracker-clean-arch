import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/features/home/presentation/widgets/home_drawer/home_drawer.dart';
import 'package:weight_tracker_demo/features/statistics/presentation/pages/profile_page.dart';
import 'package:weight_tracker_demo/features/weights_history/presentation/pages/posts_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          titleSpacing: -10,
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Home',
              ),
              Tab(
                text: 'Statistics',
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[HistoryPage(), StatisticsPage()],
        ),
      ),
    );
  }
}
