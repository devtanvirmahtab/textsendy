import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController mobilenum = TextEditingController();
  TextEditingController message = TextEditingController();
  TextEditingController nummessage = TextEditingController();
  var i = 0;

  _getPermission() async => await [
    Permission.sms,
  ].request();

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  _sendMessage(String phoneNumber, String message, {int? simSlot}) async {
    var result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: simSlot);
    if (result == SmsStatus.sent) {
      print("Sent");
    } else {
      print("Failed");
    }
  }

  Future<bool?> get _supportCustomSim async =>
      await BackgroundSms.isSupportCustomSim;


  var numberlist= ['01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    '01764717803','01764717803','01764717803','01764717803','01764717803','01764717803',
    
  ];


  @override
  void initState() {
    super.initState();
  }

  String numberinput = "";
  var numberlistinput = [];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('lets irritate your friend'),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: mobilenum,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Mobile Number'),
                      hintText: 'mobile number',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nummessage,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('number of times'),
                      hintText: 'number of times',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: message,
                    expands: true,
                    maxLines: null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Wright content '),
                      hintText: 'content',
                    ),
                  ),
                ),
                ElevatedButton(onPressed: ()async{

                  //  numberinput = await mobilenum.text;
                  //
                  // print(numberinput);
                  //
                  //
                  //  numberlistinput =await numberinput.split(new RegExp(r","));
                  //
                  //
                  // for(int p = 0; p< numberlistinput.length;p++){
                  //   print(numberlistinput[p]);
                  //
                  // }

                }, child: Text('Add number')),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    numberinput = await mobilenum.text.toString();

                    print(numberinput);


                    numberlistinput = await numberinput.split(new RegExp(r","));
                    print(numberlistinput.length);
                    print(numberlistinput);

                    setState(() {
                      i = int.parse(nummessage.text);
                    });

                    for (int k = 0; k < numberlistinput.length; k++) {

                      await Future.delayed(Duration(milliseconds: 1500));

                      if (await _isPermissionGranted()) {
                        if ((await _supportCustomSim)!){
                          _sendMessage( numberlistinput[k], message.text, simSlot: 2);
                          print(numberlistinput[k]);
                        }
                        else
                          _sendMessage( numberlistinput[k], message.text);
                        print(numberlistinput[k]);
                      } else
                        _getPermission();
                    }
                  },
                  child: Text(
                    'send',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

                Text(mobilenum.text.toString()),

                Container(
                  height: 300,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: numberlistinput.length,
                      itemBuilder: (context,index){
                        return Text(numberlistinput[index]);
                      },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


