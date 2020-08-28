import '../models/transactions.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> _userTransaction;
  final Function deleteTransaction;

  TransactionList(this._userTransaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return  _userTransaction.isEmpty
          ? LayoutBuilder(builder: (context,constraints){
            return
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 28,
                ),
                Text(
                  "No transactions have been added yet !",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  height: constraints.maxHeight*0.4,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );

          },) 
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Text(
                                  _userTransaction[index].amount.toString(),
                                  ),
                                  ),
                                  ),
                    ),
                    title: Text(_userTransaction[index].title , 
                    style: Theme.of(context).textTheme.headline6,),

                    subtitle: Text(DateFormat.yMMMMd().format(_userTransaction[index].date)) ,
                    trailing: 
                    
                    MediaQuery.of(context).size.width > 600? 
                      FlatButton.icon(
                        onPressed: () => deleteTransaction(_userTransaction[index].id),
                       icon: Icon(Icons.delete),
                       
                       textColor: Colors.red,
                        label: Text('Delete'))
                     :IconButton(icon: Icon(Icons.delete), color: Colors.red,
                    onPressed: () => deleteTransaction(_userTransaction[index].id),
                    )
                  ),
                );
                  



                // return Card(
                //     child: Row(children: <Widget>[
                //   Container(
                //     margin: EdgeInsets.symmetric(
                //       vertical: 10,
                //       horizontal: 15,
                //     ),
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //       color: Theme.of(context).primaryColor,
                //       width: 2,
                //     )),
                //     padding: EdgeInsets.all(10),
                //     child: Text(
                //       "\u20B9 " +
                //           '${_userTransaction[index].amount.toStringAsFixed(2)}',
                //       style: TextStyle(
                //         color: Theme.of(context).primaryColor,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Text(
                //         _userTransaction[index].title,
                //         style: TextStyle(
                //           fontFamily: 'Quicksand',
                //           fontWeight: FontWeight.w700,
                //           fontSize: 16,
                //         ),
                //       ),
                //       Text(
                //         DateFormat.yMMMMd()
                //             .format(_userTransaction[index].date),
                //         style: TextStyle(color: Colors.grey),
                //       ),
                //     ],
                //   )
                // ]));
              },
              itemCount: _userTransaction.length,
            );
  }
}
