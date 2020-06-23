import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';

import 'package:flutter_complete_guide/widgets/products_grid.dart';
import 'package:flutter_complete_guide/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/screens/cart_screen.dart';

enum selectedChoice { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var selectedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show All'),
                value: selectedChoice.all,
              ),
              PopupMenuItem(
                child: Text('Favorites Only'),
                value: selectedChoice.favorites,
              )
            ],
            onSelected: (selectedChoice input) {
              setState(() {
                if (input == selectedChoice.all) {
                  selectedValue = false;
                } else {
                  selectedValue = true;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.pageRoute);
              },
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: ProductsGrid(selectedValue),
    );
  }
}
