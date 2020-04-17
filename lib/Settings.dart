import 'package:flutter/material.dart';
import './main.dart';
import 'package:http/http.dart' as http;


class Settings extends StatefulWidget {
  final String text;
  Settings({@required this.text});

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  TextEditingController ssidController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  String ssid = "";
  String password = "";
  double elevation = 0.0;
  bool isLoading = false;

  @override
  void initState() {
    //refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(55, 55, 55, 0.80),
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Color.fromRGBO(130, 16, 16, 0.95),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return ListView(children: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: TextFormField(
              controller: ssidController,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
              maxLength: 32,
              onChanged: (text) {
                ssid = text;
              },
              decoration: InputDecoration(
                fillColor: Colors.black26,
                filled: true,
                prefixIcon: Icon(
                  Icons.wifi,
                  color: Colors.white,
                ),
                labelText: 'Enter your network name',
                labelStyle:
                TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: TextFormField(
              controller: passController,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20,
              ),
              maxLength: 32,
              obscureText: true,
              onChanged: (text) {
                password = text;
              },
              decoration: InputDecoration(
                fillColor: Colors.black26,
                filled: true,
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Colors.white,
                ),
                labelText: 'Enter your network password',
                labelStyle:
                TextStyle(fontWeight: FontWeight.w300, color: Colors.grey),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            // When the user presses the button, show an alert dialog containing the
            // text that the user has entered into the text field.

            onPressed: () async {
              String output = "The network changed successfully to " + ssid;
              if (ssid.contains(" ")) {
                output =
                "The name can't contain spaces, please edit the name to a valid one.";
              } else if (ssid.length == 0) {
                output =
                "The name can't be empty, please edit the name to a valid one.";
              } else if (password.contains(" ")) {
                output =
                "The password can't contain spaces, please edit the password to a valid one.";
              } else if (password.length < 8) {
                output =
                "The password can't be less than 8 charchters, please edit the password to a valid one.";
              } else {
                setState(() {
                  isLoading = true;
                });

                try {
                  response = await http.get(
                      urlSettings + 'set?ssid=$ssid&pass=$password',
                      headers: {"Accept": "plain/text"});
                  ssidController.clear();
                  passController.clear();
                } catch (e) {
                  output =
                  "Couldn't connect to the network, Please follow the below steps to change network.";
                }
                setState(() {
                  isLoading = false;
                });
              }
              FocusScope.of(context).requestFocus(FocusNode());
              return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(output),
                  );
                },
              );
            },
            tooltip: 'Update',
            child: Icon(Icons.send),
          ),
          SizedBox(
            height: 20,
          ),
          isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Column(),
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        "\n\nTo change the network successfully, do the following:",
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        )),
                    Text(
                        "1- Turn off your router\n"
                            "2- Restart The $companyName device\n"
                            "3- A new wifi network will show up with\n         Name ($hotspotName) and Password ($hotspotPassword)\n"
                            "4- Connect your mobile to this network\n"
                            "5- Enter the new name and password here and click send\n"
                            "6- If the red led in $companyName device is turned off, repeat step 1,2\n",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                  ]))
        ]);
      }),
    );
  }

}
