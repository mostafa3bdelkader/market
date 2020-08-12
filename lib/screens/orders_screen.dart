import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/orders.dart' show Orders;
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoaded = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoaded = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
      setState(() {
        _isLoaded = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MainDrawer(),
      body: _isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) => OrderItem(orderData.orders[i])),
    );
  }
}
