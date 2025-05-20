import 'package:flutter/material.dart';
class Lifecycle extends StatefulWidget {
  final String title;

  const Lifecycle({Key? key, required this.title}) : super(key: key);

  @override
  State<Lifecycle> createState() => _LifecycleMainScreenState();
}

class _LifecycleMainScreenState extends State<Lifecycle> with WidgetsBindingObserver {
  int _tapCount = 0;
  String status = "App is running";
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print("initState called");
    WidgetsBinding.instance.addObserver(this);
    status = "App initialized";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies called");
  }

  @override
  void didUpdateWidget(covariant Lifecycle oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget called");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("AppLifecycleState changed to $state");

    setState(() {
      if (state == AppLifecycleState.resumed) {
        status = "App is in RESUMED state";
      } else if (state == AppLifecycleState.inactive) {
        status = "App is in INACTIVE state";
      } else if (state == AppLifecycleState.paused) {
        status = "App is in PAUSED state";
      } else if (state == AppLifecycleState.detached) {
        status = "App is in DETACHED state";
      }
    });
  }

  @override
  void dispose() {
    print("dispose called");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(16),
            height: 150,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("This is a bottom sheet"),
              ],
            ),
          );
        });
  }



  void  _showDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Status Of the App"),
            content: Text(status),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  void showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("You tapped $_tapCount times."),
      duration: Duration(seconds: 2),
    ));
  }

  Widget BCard() {
    return Card(
      color: Colors.greenAccent,
      margin: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Column(
          children: [
            Text("App LifeCycle", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 8),
            Text(status, style: TextStyle(color: Colors.deepPurple)),],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;

      if (index == 1) {
        _showDialog();
      } else if (index == 2) {
        showBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build method called");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('App lifeCycle'),
        actions: [
          IconButton(
              onPressed: showSnackBar,
              icon: Icon(Icons.info_outline), tooltip: 'Show SnackBar')
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            BCard(),
            SizedBox(height: 20),
            Image.asset("assets/images/fast food.jpg", width: 200, height: 150, fit: BoxFit.cover,),
            SizedBox(height: 20),
            Text("Tap Counter: $_tapCount", style: TextStyle(fontSize: 20, color: Colors.black)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _tapCount++;
                  print("Tap button pressed: $_tapCount");
                });
              },
              child: Text("Click me"),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  backgroundColor: Colors.cyan),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Message'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sheet'),
        ],
      ),
    );
  }
}
