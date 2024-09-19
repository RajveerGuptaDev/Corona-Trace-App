import 'package:flutter/material.dart';
import 'package:virus_app/view/detail_screen.dart';
import 'package:virus_app/view/view_%20screen.dart';
import 'package:shimmer/shimmer.dart';
import 'Model/Countries_list.dart';

class CountriesList extends StatefulWidget {
  CountriesList({super.key});

  CountriesListModel newsListViewModel = CountriesListModel();


  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ViewApi CountriesList = ViewApi();
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Country List ",style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,

        ),),
        leading: const Image(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjVjNgQrncb-GI25gD4e3Wlqs4MUurE-Cofw&")),

      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              cursorColor: Colors.redAccent,
              spellCheckConfiguration: SpellCheckConfiguration(
                misspelledSelectionColor: Colors.green,
                misspelledTextStyle: TextField.materialMisspelledTextStyle,
              ),
              controller: searchController,
              decoration: InputDecoration(
                hoverColor: Colors.red,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search any Country",
                  border : OutlineInputBorder(

                    borderRadius: BorderRadius.circular(50.0),
                  )
              ),
            ),
            Expanded(
                child: FutureBuilder(
                    future: CountriesList.CountriesApi() ,
                    builder: ( context, AsyncSnapshot <List<dynamic>> snapshot ){
                      if(!snapshot.hasData){
                        return ListView.builder(
                            itemCount: 8,
                            itemBuilder: (context ,index ){
                              return Shimmer.fromColors(

                                  baseColor: Colors.black12,
                                  highlightColor: Colors.black38,
                                child:  Expanded(
                                  child: Column(
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Container( height: 10,width: 90, color: Colors.grey,),
                                          subtitle:  Container( height: 10,width: 90, color: Colors.grey,),
                                          leading:  Container( height: 50,width: 50, color: Colors.grey,),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );




                            });
                      }else{
                        return ListView.builder(
                        itemCount: snapshot.data!.length,
                            itemBuilder: (context ,index ){
                          String name = snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return  Expanded(
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          DetailScreen(
            image: snapshot.data![index]['countryInfo']['flag'],
            name: snapshot.data![index]['country'],
            totalCases: snapshot.data![index]['cases'],
            totalRecovered: snapshot.data![index]['recovered'],
            totalDeaths: snapshot.data![index]['deaths'],
            active: snapshot.data![index]['active'],
            test: snapshot.data![index]['tests'],
            todayRecovered: snapshot.data![index]['todayRecovered'],
            critical: snapshot.data![index]['critical'],
          )));  },
         child:
      ListTile(
        title: Text(snapshot.data![index]['country']),
        subtitle: Text(snapshot.data![index]['cases'].toString()),
        leading: Image(
            height: 50,
            width: 50,


            image: NetworkImage(
              snapshot.data![index]['countryInfo']['flag'],

            )
        ),

        )
                                    ),
                                  )
                                ],
                              ),
                            );
                          }else if (name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return  Expanded(
                              child: Column(
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                            DetailScreen(
                                              image: snapshot.data![index]['countryInfo']['flag'],
                                              name: snapshot.data![index]['country'],
                                              totalCases: snapshot.data![index]['cases'],
                                              totalRecovered: snapshot.data![index]['recovered'],
                                              totalDeaths: snapshot.data![index]['deaths'],
                                              active: snapshot.data![index]['active'],
                                              test: snapshot.data![index]['tests'],
                                              todayRecovered: snapshot.data![index]['todayRecovered'],
                                              critical: snapshot.data![index]['critical'],
                                            )));  },
                                      child: ListTile(
                                        title: Text(snapshot.data![index]['country']),
                                        subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        leading: Image(
                                            height: 50,
                                            width: 50,


                                            image: NetworkImage(
                                              snapshot.data![index]['countryInfo']['flag'],

                                            )
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }else{
                            return Container();
                          }



                        });
                      }
                      }

                )

            )
          ],
        ),
      )
    );
  }
}

