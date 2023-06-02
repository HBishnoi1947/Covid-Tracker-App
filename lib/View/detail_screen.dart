import 'package:covid_tracker/View/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  final String image, name;
  final int totalCases, totalDeaths, totalRecovered, activeCases, todayCases, todayDeaths;

  const DetailScreen({super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.activeCases,
    required this.todayCases,
    required this.todayDeaths
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: Card(
                  child: Column(children: [
                    SizedBox(height: MediaQuery.of(context).size.height*.05),
                    ReusableRow(title: "Total Cases", value: widget.totalCases.toString()),
                    ReusableRow(title: "Total Recovered", value: widget.totalRecovered.toString()),
                    ReusableRow(title: "Total Deaths", value: widget.totalDeaths.toString()),
                    ReusableRow(title: "Active Cases", value: widget.activeCases.toString()),
                    ReusableRow(title: "Today Cases", value: widget.todayCases.toString()),
                    ReusableRow(title: "Today Deaths", value: widget.todayDeaths.toString()),
                  ]),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
      ],),
    );
  }
}