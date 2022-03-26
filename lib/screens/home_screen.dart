import 'package:cryptocurrency/Data/importent_symbols.dart';
import 'package:cryptocurrency/models/crypto_coins.dart';
import 'package:cryptocurrency/services/data_connection_check.dart';
import 'package:cryptocurrency/services/networking.dart';
import 'package:cryptocurrency/widgets/cl_frame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List listOfData = [];

var selectedValue;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // NetworkHelper getListOfSymbolsSupported =
  //     NetworkHelper('https://api.exchangerate.host/symbols');
  //
  //  NetworkHelper networkHelper =
  //     NetworkHelper('https://api.exchangerate.host/convert?from=USD&to=BTC');
  // var _value;
  // var dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282539),
      body: Column(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.6,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/curve.png'),
                  ),
                // gradient: LinearGradient(
                //     end: Alignment.centerRight,
                //     begin: Alignment.centerLeft,
                //     colors: [
                //       Color(0xFFEE3455),
                //       Color(0xFFE26685),
                //     ]),
              ),
              child: ClFrame()),

          ///texting code only
          // TextButton(onPressed: ()async{
          //   var data = await getListOfSymbolsSupported.getData();
          //   print(data);
          //
          //   List<String> listAdd=[];
          //   List list =data['symbols'].keys.toList();
          //   for (int i=100 ; i <=170;i++) {
          //    listAdd.add('"${list[i]}"');
          //   }
          //
          // print(listAdd);
          //   for (int i=0 ; i <=99;i++) {
          //     listAdd.add('"${list[i]}"');
          //   }
          //
          //   print(listAdd);
          //
          //   }, child: Text("fuck"))
          ///end
          Expanded(
            child: FutureBuilder(
                future: fetch(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: Text(
                      "Loding ....",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      print(snapshot.error);
                    } else {
                      return ListView.builder(
                        itemCount: 10,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          listOfData[index].fromImage,
                                          errorBuilder:
                                              (context, exception, stackTrace) {
                                            return Image.asset(
                                                'assets/images/btc.png');
                                          },
                                        ),
                                        //   child: Image(image: AssetImage(listOfData[index].fromImage),height: MediaQuery.of(context).size.width*0.1,),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "1 ${listOfData[index].from} = ",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Image(
                                        image: AssetImage(
                                            listOfData[index].toImage),
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                          child: Text(
                                        "${listOfData[index].value} ${listOfData[index].to}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold),
                                      ))
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      end: Alignment.centerRight,
                                      begin: Alignment.centerLeft,
                                      colors: [
                                        Color(0xFFEE3455),
                                        Color(0xFFE26685),
                                      ]),
                                  // image: DecorationImage(
                                  //   fit: BoxFit.fill,
                                  //   image: AssetImage('assets/images/a.png')
                                  // ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: MediaQuery.of(context).size.width * 0.3,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }

                  return Container();
                }),
          ),
        ],
      ),
    );
  }

  fetch() async {
    List<CryptoCoin> result = [];
    for (int i = 0; i < 10; i++) {
      NetworkHelper networkHelper = NetworkHelper(
          'https://api.exchangerate.host/convert?from=${list[i]}&to=USD');
      var data = await networkHelper.getData();

      String from = data['query']['from'];
      String to = data['query']['to'];
      double value = data['result'];
      String fromImage = "assets/images/${from.toLowerCase()}.png";
      String toImage = "assets/images/${to.toLowerCase()}.png";
      // if(from=="BTC"){
      //   resultCl=value;
      //   print(resultCl);
      // }
      result.add(CryptoCoin(
          fromImage: fromImage,
          toImage: toImage,
          from: from,
          to: to,
          value: value));
      value = 0;
    }
    listOfData = result;
    return result;
  }
}
