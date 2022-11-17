import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/pages/add_transection.dart';

import '../static.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: PrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTransection()));
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
      body: const Center(
        child: Text('No Data !'),
      ),
    );
  }
}
