import 'package:flutter/material.dart';
class LifeCyclePage extends StatefulWidget {
  final String title;

  LifeCyclePage({Key? key, required this.title}) : super(key: key);

  @override
  _LifeCyclePageState createState() {
    print('createState triggered');
    return _LifeCyclePageState();
  }
}

class _LifeCyclePageState extends State<LifeCyclePage> with WidgetsBindingObserver,SingleTickerProviderStateMixin {
  int _counter = 0;
  int _selectedIndex = 0;
  String _appState = "App started";
  late TabController _tabController;
  String _gender = 'Male';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    print('initState called');
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies called');
  }

  @override
  void didUpdateWidget(covariant LifeCyclePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget called');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      switch (state) {
        case AppLifecycleState.resumed:
          print('app resumed');
          break;
        case AppLifecycleState.paused:
          print('app paused');
          break;
        case AppLifecycleState.inactive:
          print('app inactive');
          break;
        case AppLifecycleState.detached:
        default:
          print('app detached');
          break;
      }
    });
    print('AppLifecycleState changed to: $state');
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Counter increased to $_counter'),
      duration: Duration(seconds: 1),
    ));
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build method called');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorAnimation: TabIndicatorAnimation.elastic,
          controller: _tabController,
          tabs: [
            Tab(text: "Home"),
            Tab(text: "Orders"),
            Tab(text: "Favourite"),
            Tab(text: "Profile"),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text("MENU", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              title: Text("Click here"),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Here is a Alert Box"),
                    content: Text("Hello foodie"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text("OK"),
                      )
                    ],
                  ),
                );},
            )],
        ),),
      body: TabBarView(
        controller: _tabController,
        children: [
         Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Lifecycle Status: $_appState", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                SizedBox(height: 10),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text("You clicked $_counter times.", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 12),
                        Image.asset("assets/images/fast food.jpg", height: 180, fit: BoxFit.cover),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _incrementCounter,
                          child: Text("Click here",style: TextStyle(color: Colors.blueGrey),),

                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
        color: Colors.greenAccent.shade100,
        margin: EdgeInsets.all(16),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(

        children: [


        ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
        'assets/images/fast food.jpg',
        height: 300,
        width: double.infinity,
        fit: BoxFit.cover,
        ),
        ),
    SizedBox(height: 16),

    Text(
    "Pizza Order Details",
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 12),


    Align(
    alignment: Alignment.centerLeft,
    child: Text("Select Gender:", style: TextStyle(fontWeight: FontWeight.bold)),
    ),
    Row(
    children: [
    Radio<String>(
    value: "Male",
    groupValue: _gender,
    onChanged: (val) {
    setState(() {
    _gender = val!;
    });
    },
    ),
    Text("Male"),
    Radio<String>(
    value: "Female",
    groupValue: _gender,
    onChanged: (val) {
    setState(() {
    _gender = val!;
    });
    },
    ),
    Text("Female"),
    ],
    ),
    ],),),),
         CircleAvatar(
           radius: 6,
           child: Text("Hello Foodie",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
           backgroundColor: Colors.brown,
         ),
          Center(child: Text('Hello'),)
          

        ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Info"),
        ],
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    print('dispose called');
    super.dispose();
  }
}
