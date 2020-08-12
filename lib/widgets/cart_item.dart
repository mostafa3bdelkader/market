import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/models/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  CartItem(this.id, this.productId, this.title, this.quantity, this.price);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Are you sure ?'),
                  content: Text('do you want to remove item ?'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('no'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    FlatButton(
                      child: Text('yes'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    )
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).deleteItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FittedBox(child: Text('\$$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total:\$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
