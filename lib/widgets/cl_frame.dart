import 'package:cryptocurrency/Data/crypto_symbols.dart';
import 'package:cryptocurrency/services/data_connection_check.dart';
import 'package:cryptocurrency/services/networking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String selectedValues="Select";
double result=0.00;
class ClFrame extends StatefulWidget {
  const ClFrame({Key? key,}) : super(key: key);

  @override
  _ClFrameState createState() => _ClFrameState();
}

class _ClFrameState extends State<ClFrame> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.4,
          child: DropdownButtonFormField<String>(
            icon: Icon(Icons.arrow_drop_down_sharp,color: Colors.white,size: 28,),
            dropdownColor: Color(0xFF332F48),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                filled: true,
                fillColor: Color(0xFF332F48)),
            value: selectedValues,
            items: symbols.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value=="Select"?"$value":"1$value",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24),),
              );
            }).toList(),
            onChanged: (value)async{
              print(value);

              NetworkHelper networkHelper = NetworkHelper(
                  'https://api.exchangerate.host/convert?from=$value&to=USD');
              var data = await networkHelper.getData();
                setState(()  {
                  result = data['result'];
                  if(value=="Select")
                    result=0.00;
                  print(result);
                });
            },
          ),
        ),
        Text("=",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
        Container(
          child:   Center(child: Text(result==0.00?"_______":"$result USD",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),)),
          width: MediaQuery.of(context).size.width*0.4,
          height: MediaQuery.of(context).size.width*0.16,
          decoration: BoxDecoration(
            color: Color(0xFF332F48),
               borderRadius: BorderRadius.circular(20)
          ),
        )

      ],
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection(context);
  }
}



