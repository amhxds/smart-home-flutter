import 'package:flutter/material.dart';
import './main.dart';
import 'package:http/http.dart' as http;

class Room1 extends StatefulWidget {
  final String text;
  Room1({@required this.text});

  @override
  State<StatefulWidget> createState() => Room1State();
}

class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}


class Room1State extends State<Room1> {
  static int startSource = 1;
  static int endSource = 5;
  bool notCompleted = true;
  List<bool> status = List.filled((endSource - startSource + 2), false);
  bool zipy = false;
  int counter = 0;
  bool incrementCounter() {
    if (counter >= endSource) counter = 0;
    counter++;
    return true;
  }

  double elevation = 0.0;

  Item selectedStatus;
  List<Item> statusItems = <Item>[
    const Item('On',Icon(Icons.power_settings_new,color: Colors.green,)),
    const Item('Off',Icon(Icons.power_settings_new,color: Colors.red,)),
  ];


  @override
  void initState() {
    setState(() {
      zipy = true;
    });
    refresh();
    setState(() {
      zipy = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Room 1"),
        backgroundColor: Color.fromRGBO(130, 16, 16, 0.95),
        centerTitle: true,
      ),
      body: Builder(builder: (BuildContext context) {
        scaffoldContext = context;
        return ListView(
          children: <Widget>[
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
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  OutlineButton(
                      onPressed: () {
                        setState(() {
                          zipy = true;
                        });
                        refresh();
                        setState(() {
                          zipy = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.refresh,
                              color: isConnected ? Colors.green : Colors.red,
                            ),
                            SizedBox(width: 20),
                            Text(isConnected ? "Connected" : "Not Connected",
                                style: TextStyle(
                                  fontSize: 20,
                                  color:
                                  isConnected ? Colors.green : Colors.red,
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      turnAll(1);
                    },
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.green,
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
                                image: AssetImage("assets/on.png"),
                                height: 50.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(width: 20),
                  FlatButton(
                    onPressed: () {
                      turnAll(1);
                    },
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
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
                                image: AssetImage("assets/switch.png"),
                                height: 80.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(width: 20),
                  FlatButton(
                    onPressed: () {
                      turnAll(0);
                    },
                    //color: Colors.blueGrey,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.red,
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
                                height: 50.0),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            zipy
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Column(),
            Container(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: incrementCounter()
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      sendCommand(1, 2);
                    },
                    padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                    splashColor: Colors.grey,
                    color: Color.fromRGBO(55, 55, 55, 0.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(
                                Icons.power_settings_new,
                                color:
                                status[counter] ? Colors.green : Colors.red,
                              ),
                              iconSize: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                room1Names[counter - 1],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: new Icon(
                      Icons.timer,
                      size: 60,
                      color: Color.fromRGBO(55, 55, 55, 0.80),
                    ),
                    onPressed: () {

                      showDialog(
                        context: context,
                        builder: (context) {
                          Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                            elevation: 16,
                            child:
                            Container(
                              height: 400.0,
                              width: 360.0,
                              child: timerDialog(source: 1),
                            ),
                          );



                          return;
                        },
                      );


                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: incrementCounter()
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      sendCommand(2, 2);
                    },
                    padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                    splashColor: Colors.grey,
                    color: Color.fromRGBO(55, 55, 55, 0.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(
                                Icons.power_settings_new,
                                color:
                                status[counter] ? Colors.green : Colors.red,
                              ),
                              iconSize: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                room1Names[counter - 1],
                                style: TextStyle(
                                  fontSize: 20,
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
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: incrementCounter()
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      sendCommand(3, 2);
                    },
                    padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                    splashColor: Colors.grey,
                    color: Color.fromRGBO(55, 55, 55, 0.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(
                                Icons.power_settings_new,
                                color:
                                status[counter] ? Colors.green : Colors.red,
                              ),
                              iconSize: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                room1Names[counter - 1],
                                style: TextStyle(
                                  fontSize: 20,
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
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: incrementCounter()
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      sendCommand(4, 2);
                    },
                    padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                    splashColor: Colors.grey,
                    color: Color.fromRGBO(55, 55, 55, 0.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(
                                Icons.power_settings_new,
                                color:
                                status[counter] ? Colors.green : Colors.red,
                              ),
                              iconSize: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                room1Names[counter - 1],
                                style: TextStyle(
                                  fontSize: 20,
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
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: incrementCounter()
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      sendCommand(5, 2);
                    },
                    padding: EdgeInsets.fromLTRB(15, 10, 25, 10),
                    splashColor: Colors.grey,
                    color: Color.fromRGBO(55, 55, 55, 0.80),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Column(children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              icon: new Icon(
                                Icons.power_settings_new,
                                color:
                                status[counter] ? Colors.green : Colors.red,
                              ),
                              iconSize: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                room1Names[counter - 1],
                                style: TextStyle(
                                  fontSize: 20,
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
          ],
        );
      }),
    );
  }
  Widget timerDialog ({int source}) {
    int timerStatus = -1;
    int timeMin = -1;
    int timeHr = -1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(width: 12),
              Text("LOL"),


            ],


          ),
          DropdownButton<Item>(
            hint:  Text("Select item"),
            value: selectedStatus,
            onChanged: (Item value) {
              //timerStatus = int.parse(value.toString());
              setState(() {
                selectedStatus = value;
                Navigator.pop(context);
                print("LOOOOOOOOL");
              });
            },
            items: statusItems.map((Item user) {
              return  DropdownMenuItem<Item>(
                value: user,
                child: Row(
                  children: <Widget>[
                    user.icon,
                    SizedBox(width: 10,),
                    Text(
                      user.name,
                      style:  TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

        ],
      ),
    );
  }




  testConnection() async {
    try {
      response = await http.get(url, headers: {"Accept": "plain/text"});
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      setState(() {
        isConnected = false;
      });
    }
  }

  sendCommand(int source, int command) async {
    try {
      response = await http.get(url + 'command?source=$source&command=$command',
          headers: {"Accept": "plain/text"});
      print(response.body);
      if (response.body == "1")
        setState(() {
          status[source] = true;
          isConnected = true;
        });
      else
        setState(() {
          status[source] = false;
          isConnected = true;
        });
    } catch (e) {
      setState(() {
        isConnected = false;
      });
    }
  }

  turnAll(int command) {
    for (int source = startSource; source <= endSource; source++) {
      sendCommand(source, command);
    }
  }

  refresh() {
    testConnection();
    if (isConnected)
      for (int source = startSource; source <= endSource; source++) {
        sendCommand(source, 3);
      }
  }

}
