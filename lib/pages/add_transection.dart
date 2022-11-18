import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/controllers/db_helper.dart';

import '../static.dart';

class AddTransection extends StatefulWidget {
  const AddTransection({Key? key}) : super(key: key);

  @override
  State<AddTransection> createState() => _AddTransectionState();
}

class _AddTransectionState extends State<AddTransection> {
  int? amount;
  String note = 'Some Expance';
  String type = 'Income';
  DateTime selectedDate = DateTime.now();
  List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  Future<void> _selectDate(BuildContext context)async{
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 12),
        lastDate: DateTime(2100, 01),
    );
    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe2e7ef),
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 20,),
          const Text('Add Transaction',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),),
          const SizedBox(height: 20,),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: PrimaryColor,
                  borderRadius: BorderRadius.circular(16)
                ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.attach_money,
                  size: 24,
                  color: Colors.white,)
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: '0',
                    border: InputBorder.none
                  ),
                  style: const TextStyle(
                    fontSize: 24
                  ),
                  onChanged: (val){
                    try{
                      amount = int.parse(val);
                    }catch(e){

                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(16)
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.description,
                    size: 24,
                    color: Colors.white,)
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: 'Note on Transaction',
                      border: InputBorder.none
                  ),
                  style: const TextStyle(
                      fontSize: 24
                  ),
                  onChanged: (val){
                    note = val;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(16)
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.moving_sharp,
                    size: 24,
                    color: Colors.white,)
              ),
              const SizedBox(width: 12,),
              ChoiceChip(
                label: Text('Income',
                style: TextStyle(fontSize: 16,
                color: type=='Income'? Colors.white: Colors.black),),
                selectedColor: PrimaryColor,
                selected: type == 'Income'? true : false,
                onSelected: (val){
                  if(val){
                    setState(() {
                      type = 'Income';
                    });
                  }
                },
              ),
              const SizedBox(width: 12,),
              ChoiceChip(
                label: Text('Expence',
                  style: TextStyle(fontSize: 16,
                      color: type=='Expence'? Colors.white: Colors.black),),
                selectedColor: PrimaryColor,
                selected: type == 'Expence'? true : false,
                onSelected: (val){
                  if(val){
                    setState(() {
                      type = 'Expence';
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 50,
            child: TextButton(
              onPressed: (){
                _selectDate(context);
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)
              ),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: PrimaryColor,
                          borderRadius: BorderRadius.circular(16)
                      ),
                      padding: const EdgeInsets.all(12),
                      child: const Icon(Icons.calendar_today,
                        size: 24,
                        color: Colors.white,)
                  ),
                  const SizedBox(width: 12,),
                  Text(
                    '${selectedDate.day} ${months[selectedDate.month - 1]}',
                    style: const TextStyle(
                        fontSize: 20,
                    ),),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: (){
                if(amount !=null && note.isNotEmpty){
                  DbHelper dbHelper = DbHelper();
                  dbHelper.addData(amount!, selectedDate!, note, type);
                }else{
                  print('Not All values provided !');
                }
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          )
        ],
      )
      );
  }
}
