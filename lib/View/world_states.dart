import 'package:covid_tracker/Model/world_states_model.dart';
import 'package:covid_tracker/Reusable%20%20Widgets/reusable_button.dart';
import 'package:covid_tracker/Reusable%20%20Widgets/reusable_row.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/contries_states.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

List<Color> colorList = [
  const Color(0xff4285F4),
  const Color(0xff1aa260),
  const Color(0xffde5246),
];

class _WorldStateScreenState extends State<WorldStateScreen> {
  // late final AnimationController _controller =
  //     AnimationController(duration: const Duration(seconds: 3), vsync: this)
  //       ..repeat();
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }


  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid 19 Tracker'.toUpperCase()),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Expanded(
              child: FutureBuilder(
                  future: statesServices.fetchWorldStatesRecord(),
                  builder: ((context, AsyncSnapshot<WorldStatesModel> snapshot) {
                      if (!snapshot.hasData) {
                        return const SpinKitDoubleBounce(
                          color: Colors.white,
                          size: 50,
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              PieChart(
                                dataMap:  {
                                  'Total': double.parse(snapshot.data!.cases.toString()),
                                  'Recovered': double.parse(snapshot.data!.recovered.toString()),
                                  'Death': double.parse(snapshot.data!.deaths.toString()),
                                },
                                animationDuration:
                                const Duration(milliseconds: 1200),
                                chartRadius: MediaQuery.of(context).size.width / 3.2,
                                chartType: ChartType.ring,
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true
                                ),
                                colorList: colorList,
                                legendOptions: const LegendOptions(
                                    legendPosition: LegendPosition.left),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height * 0.06, bottom: MediaQuery.of(context).size.height * 0.01),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                      ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                      ReusableRow(title: 'Death', value: snapshot.data!.deaths.toString()),
                                      ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                      ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                      ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                      ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                    ],
                                  ),
                                ),
                              ),
                              ReusableButton(
                                  context: context,
                                  onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesStates())),
                                  text: 'Track Countries')
                            ],
                          ),
                        );
                      }
                    }

                  )),
            ),
          ],
        ),
      ),
    );
  }
}
