import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Room1.dart';
import './Settings.dart';

BuildContext scaffoldContext;
bool isConnected = false;
String companyName = "BBJ73";
String hotspotName = "Name";
String hotspotPassword = "Password";
String url = "http://192.168.1.200:80/";
String urlSettings = "http://192.168.4.1:80/";
String auth = "XytyN4EYgCAPcBLX-XuUylkbV1m2Lw72";

List<String> room1Names = [
  "Source 1",
  "Source 2",
  "Source 3",
  "Source 4",
  "Source 5"
];

var response;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: companyName,
      debugShowCheckedModeBanner: false,
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    testConnection();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(55, 55, 55, 0.80),
      appBar: new AppBar(
        title: new Text(companyName + ' Smart Home'),
        backgroundColor: Color.fromRGBO(130, 16, 16, 0.95),
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(130, 16, 16, 0.95),
              ),
              accountName: new Text('Hasson Elgamed'),
              accountEmail: new Text(companyName),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage("assets/hasson.png"),
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.edit),
              title: new Text('Room 1'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Room1()));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.edit),
              title: new Text('Room 2'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Room1()));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.edit),
              title: new Text('Room 3'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Room1()));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.edit),
              title: new Text('Room 4'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Room1()));
              },
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.settings),
              title: new Text('Settings'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Settings()));
              },
            ),
            new ListTile(
              leading: new Icon(Icons.info),
              title: new Text('About'),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new Room1()));
              },
            ),
          ],
        ),
      ),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return ListView(
          children: <Widget>[
            new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 170,
                  )
                ]),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                          onPressed: () {
                            testConnection();
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text(
                                    isConnected ? "Connected" : "Not Connected",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(
                              color: isConnected ? Colors.green : Colors.red),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)))
                    ],
                  ),
                ),
                Center(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text(
                          isConnected
                              ? "\n\nYou are connected now\n Enjoy our app :)\n\n"
                              : "\n\nYou are not connected! \n\nPlease make sure that your mobile is connected to the same "
                              "network of the $companyName Device, or change it from settings.\n\n",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          )),
                    )),
                Container(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                        onPressed: () {},
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                        splashColor: Colors.grey,
                        borderSide: BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                    image: AssetImage("assets/off.png"),
                                    height: 35.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Close all sources',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                          onPressed: ()  { sendBlynk(1, 1);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("TEST",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(
                              color: isConnected ? Colors.green : Colors.red),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                          onPressed: ()  { sendBlynk(1, 0);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("TEST",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(
                              color: isConnected ? Colors.green : Colors.red),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                          onPressed: ()  { getBlynk(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("TEST",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(
                              color: isConnected ? Colors.green : Colors.red),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OutlineButton(
                          onPressed: ()  { getBlynk(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 20),
                                Text("TEST",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          highlightedBorderColor: Colors.orange,
                          color: Colors.green,
                          borderSide: new BorderSide(
                              color: isConnected ? Colors.green : Colors.red),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)))
                    ],
                  ),
                ),

              ],
            ),
          ],
        );
      }),
    );
  }

  testConnection() async {
    try {
      response = await http
          .get(url + 'test_connection', headers: {"Accept": "plain/text"});
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      setState(() {
        isConnected = false;
      });
    }
  }

  sendBlynk(int pinIndex, int pinValue) async {
    try {
      response = await http.get('http://blynk-cloud.com/$auth/update/V$pinIndex?value=$pinValue',
          headers: {"Accept": "plain/text"});
      setState(() {
        print("-------DONE------------" + response.body);

      });
    } catch (e) {
      setState(() {
        print("xxxxxxxxxxxxxxxNOT DONExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

      });
    }
  }
  Future <int> getBlynk(int pinIndex) async {
    try {
      response = await http.get('http://blynk-cloud.com/$auth/get/V$pinIndex',
          headers: {"Accept": "plain/text"});
      setState(() {
        print("-------DONE------------" + response.body);

      });
    } catch (e) {
      setState(() {
        print("xxxxxxxxxxxxxxxNOT DONExxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

      });
    }
  }

}
