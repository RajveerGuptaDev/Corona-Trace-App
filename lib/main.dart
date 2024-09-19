import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:virus_app/Countries_List.dart';
import 'package:virus_app/Model/world_state.dart';
import 'package:virus_app/splashscreen.dart';
import 'package:virus_app/view/view_%20screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.

        useMaterial3: true,
      ),
home: const Splashscreen() ,
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {

 late final AnimationController _controller = AnimationController(
   duration: const Duration(seconds: 5),
     vsync: this)..repeat();
  
  @override
  void dispose (){
    super.dispose();
    _controller.dispose();
  }
 WorldStatesModel newsListViewModel = WorldStatesModel();


  @override

  Widget build(BuildContext context) {
    ViewApi newsListViewModel = ViewApi();
    return Scaffold(
      appBar: AppBar(
        title: const Text(" World Records ",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,

        ),),
        leading: const Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjVjNgQrncb-GI25gD4e3Wlqs4MUurE-Cofw&")),
        
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5,

                ),
                FutureBuilder(
                    future: newsListViewModel.fetchWorldRecords(),
                    builder:( context, AsyncSnapshot<WorldStatesModel> snapshot){
                if( !snapshot.hasData){
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        size: 50,
                        controller: _controller,
                      )
                  );

                }else{
                  return Column(
                    children: [
                       PieChart(dataMap: {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recovered": double.parse(snapshot.data!.recovered.toString()),
                        "Deaths": double.parse(snapshot.data!.deaths.toString()),
                        "Population": double.parse(snapshot.data!.active.toString()),

                      },
                        animationDuration: const Duration(milliseconds: 1200),
                        chartRadius: 120,
                        chartType: ChartType.ring,

                         legendOptions: const  LegendOptions(

                           legendPosition: LegendPosition.right,
                         ),
                        colorList:const  [Colors.orange,
                          Colors.green,
                          Colors.blue,
                          Colors.pink
                        ],
                      ),
                      Card(
                        color: Colors.white54,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ReusableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                              ReusableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              ReusableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              ReusableRow(title: 'Active', value: snapshot.data!.active.toString()),
                              ReusableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                              ReusableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          height: 30,
                          child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  CountriesList()));
                            },
                            child: Container(

                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: const Center(child: Text("Track Your Country")),
                            ),
                          ),
                        ),

                      )
                    ]

                  );
                }
                }
                ,
            ),
          ])
      ),

      )
    );
  }
}



class ReusableRow extends StatelessWidget {

  String title , value ;

  ReusableRow({ super.key , required this.title , required this.value });

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          )
        ],
      ),
    );
  }
}
