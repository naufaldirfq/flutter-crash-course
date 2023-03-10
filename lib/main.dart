import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crash_course/values/colors.dart';
import 'package:flutter_crash_course/values/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      _homePage(),
      const Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      const Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Account',
          ),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryRed,
        onTap: _onItemTapped,
      ),
      body: widgetOptions.elementAt(_selectedIndex),
    );
  }

  Widget _homePage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: primaryRed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 8),
                    child: Text(
                      "PT. Mid Solusi Nusantara",
                      style: captionWhite,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jack Wolfskin",
                            style: headingWhite,
                          ),
                          Text(
                            "Product Manager",
                            style: subtitleWhite,
                          )
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  _requestShortcutCard()
                ],
              ),
            ),
          ),
          Container(height: 18, color: lightGrey,),
          _dashboardMenu()
        ],
      ),
    );
  }

  Widget _requestShortcutCard() {
    var requests = RequestShortcut.values;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          requests.length,
          (index) => Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Row(
              children: [
                Image(
                    image: AssetImage('assets/images/${requests[index].icon}')),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Request"), Text(requests[index].title)],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _dashboardMenu() {
  var dashboardMenu = DashboardMenu.values;
  return Container(
    height: 225,
    color: lightGrey,
    child: GridView.count(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      crossAxisCount: 2,
      children: List.generate(dashboardMenu.length, (index) {
        return Column(
          children: [
            Image(image: AssetImage('assets/images/${dashboardMenu[index].icon}')),
            const SizedBox(height: 8),
            Text(dashboardMenu[index].title)
          ],
        );
      }),
    ),
  );
}

enum RequestShortcut {
  reimbursement("Reimbursement", "request-reimbursement.png"),
  timeoff("Time Off", "request-timeoff.png"),
  attendance("Attendance", "request-attendance.png"),
  shift("Change Shift", "request-shift.png"),
  overtime("Overtime", "request-overtime.png");

  final String title;
  final String icon;

  const RequestShortcut(this.title, this.icon);
}

enum DashboardMenu {
  reimbursement("Reimbursement", "reimbursement.png"),
  timeoff("Time Off", "timeoff.png"),
  attendanceLog("Attendance Log", "attendance-log.png"),
  liveattendance("Live Attendance", "live-attendance.png"),
  flex("Mekari Flex", "flex.png"),
  overtime("Overtime", "overtime.png"),
  payslip("My Payslip", "payslip.png"),
  files("My Files", "file.png"),
  forms("Forms", "forms.png");

  final String title;
  final String icon;

  const DashboardMenu(this.title, this.icon);
}
