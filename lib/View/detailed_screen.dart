import 'package:covid_tracker/Reusable%20%20Widgets/reusable_row.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  String name, totalCases, recovered, death, critical, todayRecovered, imageUrl;

  DetailedScreen(
      {Key? key,
      required this.name,
      required this.totalCases,
      required this.recovered,
      required this.death,
      required this.critical,
      required this.todayRecovered,
      required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                  child: Card(
                      child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
                        child: ReusableRow(title: 'Total Cases', value: totalCases),
                      ),
                      ReusableRow(title: 'Recovered', value: recovered),
                      ReusableRow(title: 'Deaths', value: death),
                      ReusableRow(title: 'Critical', value: critical),
                      ReusableRow(title: 'Today Recovered', value: todayRecovered),
                    ],
                  )),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
