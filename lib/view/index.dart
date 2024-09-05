import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lnt_simple_ewallet/view/auth/index.dart';
import 'package:lnt_simple_ewallet/view/home/index.dart';
import 'package:lnt_simple_ewallet/view/transaction/index.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final TextEditingController _keywordController = TextEditingController();

  int _indexMenu = 0;
       
    final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    TransactionView().renderHistory(),
    AuthView().renderProfile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _indexMenu = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Transaction',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _indexMenu,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_indexMenu),
      ),
    );
  }
}