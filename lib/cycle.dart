import 'package:flutter/material.dart';

class LifeCycle extends StatefulWidget {
  final String title;

  LifeCycle({Key? key, required this.title}) : super(key: key);

  @override
  _LifeCycleExampleState createState() {
    print('createState called');
    return _LifeCycleExampleState();
  }
}

class _LifeCycleExampleState extends State<LifeCycle> {
  int counter = 0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print('initState called');
    counter = 1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies called');
  }

  @override
  void didUpdateWidget(covariant LifeCycle oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget called');
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('BottomNavigationBar item $index tapped');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build called');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Counter value is: $counter'),
            SizedBox(height: 20),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image.asset("assets/images/fast food.jpg", fit: BoxFit.cover,),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                  print('setState called');
                });
              },
              child: Text('Click here'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
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
    print('dispose called');
    super.dispose();
  }
}