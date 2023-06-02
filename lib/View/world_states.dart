import 'package:covid_tracker/Services/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
    
  final colorList = <Color> [
    const Color.fromARGB(255, 45, 114, 252),
    const Color.fromARGB(255, 0, 157, 11),
    const Color.fromARGB(255, 246, 2, 2)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .05),
              FutureBuilder(
                future: statesServices.fetchWorldStatesRecords(),
                builder: (context, snapshot){

                  if(!snapshot.hasData){
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      )
                    );
                  }
                  else{
                    return Column(children: [
                      PieChart(
                dataMap: {
                  "Total" : double.parse(snapshot.data!.cases.toString()),
                  "Recovered" : double.parse(snapshot.data!.recovered.toString()),
                  "Deaths" : double.parse(snapshot.data!.deaths.toString()),
                },
                chartValuesOptions: const ChartValuesOptions(
                  showChartValuesInPercentage: true
                ),
                legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                chartRadius: MediaQuery.of(context).size.width /2.5,
                animationDuration: const Duration(seconds: 1),
                chartType: ChartType.ring,
                colorList: colorList,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                child: Card(
                  child: Column(children: [
                    ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                    ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                    ReusableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                    ReusableRow(title: "Active Cases", value: snapshot.data!.active.toString()),
                    ReusableRow(title: "Today Cases", value: snapshot.data!.todayCases.toString()),
                    ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                  ]),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CountriesList()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 12, 113, 64),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text("Track Countries")),
                ),
              )
                    ],);
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 5),
          const Divider()
        ],
      ),
    );
  }
}