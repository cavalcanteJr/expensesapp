import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(String) onRemove;

  TransactionList(
    this.transaction,
    this.onRemove,
  );

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  Text(
                    'Nenhuma transação cadastrada',
                    style: Theme.of(context).textTheme.headline6,
                    key: Key('noExpenses'),
                  ),
                  SizedBox(height: 20),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ))
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (ctx, index) {
              final tr = transaction[index];
              return Dismissible(
                  key: Key('delete'),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: FittedBox(
                            child: Text(
                              'R\$${tr.value}',
                              key: Key('transaction_value'),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.headline6,
                        key: Key('transaction_title'),
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y').format(tr.date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => onRemove(tr.id),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    onRemove(tr.id);
                  },
                  background: Container(
                    color: Colors.red,
                    child: Icon(Icons.delete),
                    alignment: Alignment.centerRight,
                    key: Key('delete_by_swipe'),
                    padding: EdgeInsets.all(20),
                  ));
            },
          );
  }
}
