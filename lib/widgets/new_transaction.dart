import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  void submitData() {
    final enteredTitle = titlecontroller.text;
    final enteredAmount = double.parse(amountcontroller.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount,selectedDate);

    Navigator.of(context).pop();
  }

  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  DateTime selectedDate;

  void presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now())
        .then((pickedDate)  {   
        
        if(pickedDate == null){
          return ;
        }
        
        setState(() {
        selectedDate = pickedDate;  
        });
        

        }
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titlecontroller,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[

                    Expanded(
                      
                      child: Text(selectedDate == null? 'No Date chosen !' :DateFormat.yMMMMd().format(selectedDate))),


                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: presentDatePicker,
                      child: Text(
                        "Choose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: submitData)
            ],
          ),
        ),
      ),
    );
  }
}
