import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/models/cart.dart' show Cart;
import 'package:flutter_complete_guide/widgets/cart_item.dart';
import 'package:flutter_complete_guide/models/orders.dart';

class CartScreen extends StatelessWidget {
  static const pageRoute = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    FlatButton(
                      child: Text('ORDER NOW'),
                      onPressed: () {
                        Provider.of<Orders>(context).addOrder(
                            cart.cartItems.values.toList(), cart.totalAmount);
                        cart.clear();
                      },
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (ctx, i) => CartItem(
                  cart.cartItems.values.toList()[i].id,
                  cart.cartItems.keys.toList()[i],
                  cart.cartItems.values.toList()[i].title,
                  cart.cartItems.values.toList()[i].quantity,
                  cart.cartItems.values.toList()[i].price),
            ),
          )
        ],
      ),
    );
  }
}
