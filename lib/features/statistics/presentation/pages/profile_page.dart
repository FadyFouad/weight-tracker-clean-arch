import 'package:flutter/material.dart';
import 'package:weight_tracker_demo/core/extenstions/context_ext.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsPage extends ConsumerWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
            child: Container(
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(),
                    series: <LineSeries<PostsData, String>>[
              LineSeries<PostsData, String>(
                  // Bind data source
                  dataSource: <PostsData>[
                    PostsData('Jan', 80),
                    PostsData('Feb', 82),
                    PostsData('Mar', 80),
                    PostsData('Apr', 83),
                    PostsData('May', 80)
                  ],
                  xValueMapper: (PostsData sales, _) => sales.year,
                  yValueMapper: (PostsData sales, _) => sales.sales)
            ]))),
        SizedBox(height: context.getDeviceHeight() * .2),
        const Text('This Is Fake Data'),
      ],
    );
  }
}

class PostsData {
  PostsData(this.year, this.sales);

  final String year;
  final double sales;
}
