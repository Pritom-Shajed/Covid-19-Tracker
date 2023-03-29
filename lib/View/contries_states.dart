import 'package:covid_tracker/View/detailed_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountriesStates extends StatefulWidget {
  const CountriesStates({Key? key}) : super(key: key);

  @override
  State<CountriesStates> createState() => _CountriesStatesState();
}

TextEditingController _searchController = TextEditingController();

class _CountriesStatesState extends State<CountriesStates> {
  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: 'Search with country name'),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.fetchCountriesRecord(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return Shimmer.fromColors(
                    baseColor: Colors.grey.shade700,
                    highlightColor: Colors.grey.shade100,
                    child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Container(height: 10, color: Colors.white),
                              subtitle:
                                  Container(height: 10, color: Colors.white),
                              leading: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white),
                              ));
                        }));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String countryName = snapshot.data![index]['country'];
                      if (_searchController.text.isEmpty) {
                        return InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailedScreen(
                                  name: snapshot.data![index]['country'],
                                  totalCases:
                                      snapshot.data![index]['cases'].toString(),
                                  recovered: snapshot.data![index]['recovered']
                                      .toString(),
                                  death:
                                      snapshot.data![index]['deaths'].toString(),
                                  critical: snapshot.data![index]['critical']
                                      .toString(),
                                  todayRecovered: snapshot.data![index]
                                          ['todayRecovered']
                                      .toString(),
                                  imageUrl: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                ),
                              )),
                          child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle:
                                  Text('${snapshot.data![index]['cases']}'),
                              leading: Container(
                                height: 30,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                      fit: BoxFit.cover,
                                    )),
                              )),
                        );
                      } else if (countryName
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase())) {
                        return ListTile(
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text('${snapshot.data![index]['cases']}'),
                            leading: Container(
                              height: 30,
                              width: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag']),
                                    fit: BoxFit.cover,
                                  )),
                            ));
                      } else {
                        return Container();
                      }
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
