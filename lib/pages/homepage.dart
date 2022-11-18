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
  int totalBalance = 0;
  int totalIncome = 0;
  int totalExpense = 0;

  getTotalBalance(Map entireData){
    totalExpense = 0;
    totalIncome = 0;
    totalBalance = 0;
    entireData.forEach((key, value) {
      if(value['type'] == 'Income'){
        totalBalance += (value['amount'] as int);
        totalIncome += (value['amount'] as int);
      }else{
        totalBalance -= (value['amount'] as int);
        totalExpense += (value['amount'] as int);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe2e7ef),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: PrimaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddTransection()
          )
          ).whenComplete((){
            setState(() {

            });
          });
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
            return const Center(
              child: Text('Unexpected Error !'),);
          }if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return const Center(
                child: Text('No value found !'),
              );
            }
            getTotalBalance(snapshot.data!);
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
                        child: const Icon(
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
                    decoration: const BoxDecoration(
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
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    child: Column(
                      children: [
                        const Text(
                          'Total Balance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Text(
                          'BDT $totalBalance',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardIncome(
                                totalIncome.toString(),
                              ),
                              cardExpense(
                               totalExpense.toString(),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Recent Expenses',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black87,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    Map dataAtIndex = snapshot.data![index];
                    if(dataAtIndex['type'] == 'Income'){
                      return incomeTile(
                          dataAtIndex['amount'], dataAtIndex['note']
                      );
                    }else{
                      return expenseTile(
                        dataAtIndex['amount'], dataAtIndex['note']
                      );
                    }
                  },
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
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.arrow_downward,
            size: 20,
            color: Colors.green[700],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
            ),
            Text(
             value,
              style: const TextStyle(
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
          padding: const EdgeInsets.all(6),
          margin: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.arrow_upward,
            size: 20,
            color: Colors.red[700],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expense',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white
              ),
            ),
            Text(
              value,
              style: const TextStyle(
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
  Widget expenseTile(int value, String note){
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffced4eb),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                  Icons.arrow_circle_up_outlined,
                size: 25,
                color: Colors.red[700],
              ),
              const SizedBox(width: 4,),
              const Text(
                  'Expense',
                style: TextStyle(
                  fontSize: 18
                ),
              )
            ],
          ),
          Text(
            ' - $value',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700
            ),
          )
        ],
      ),
    );
  }

  Widget incomeTile(int value, String note){
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: const Color(0xffced4eb),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_circle_down_outlined,
                size: 25,
                color: Colors.green[700],
              ),
              const SizedBox(width: 4,),
              const Text(
                'Income',
                style: TextStyle(
                    fontSize: 18
                ),
              )
            ],
          ),
          Text(
            ' + $value',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700
            ),
          )
        ],
      ),
    );
  }
}
