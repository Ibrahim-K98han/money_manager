import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/controllers/db_helper.dart';
import 'package:money_manager/pages/add_transection.dart';

import '../static.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: PrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTransection()));
        },
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      body: FutureBuilder<Map>(
        future: dbHelper.fetch(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text('Unexpected Error !'),);
          }if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(
                child: Text('No value found !'),
              );
            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32.0),
                              color: Colors.white70,
                            ),
                            child: CircleAvatar(
                              maxRadius: 32,
                              child: Image.asset(
                                  'images/face.png',
                                  width: 60,
                              ),
                            )
                          ),
                          const SizedBox(width: 8,),
                          Text(
                              'Welcome Ibrahim Khan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: PrimaryMaterialColor[800],
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white70,
                        ),
                        padding: const EdgeInsets.all(12.0),
                        child: Icon(
                            Icons.settings,
                            size: 32,
                            color: Color(0xff3e454c),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: const EdgeInsets.all(
                    12,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          PrimaryColor,
                          Colors.blueAccent
                        ]
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(24)
                      )
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    child: Column(
                      children: [
                        Text(
                          'Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12,),
                        Text(
                          'BDT 2500',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 12,),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardIncome(
                                '1200'
                              ),
                              cardExpense(
                                '900'
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          }else{
            return const Center(
              child: Text('Unexpected Error !'),
            );
          }
        }
      ),
    );
  }

  Widget cardIncome(String value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.arrow_downward,
            size: 20,
            color: Colors.green[700],
          ),
          margin: EdgeInsets.only(right: 10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
            ),
            Text(
             value,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget cardExpense(String value){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.all(6),
          child: Icon(
            Icons.arrow_upward,
            size: 20,
            color: Colors.red[700],
          ),
          margin: EdgeInsets.only(right: 10),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expense',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white
              ),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
            ),
          ],
        )
      ],
    );
  }

}
