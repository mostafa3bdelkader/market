import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/models/product.dart';
import 'package:flutter_complete_guide/models/cart.dart';
import 'package:flutter_complete_guide/models/auth.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: productData.id,
            );
          },
          child: Image.network(
            productData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: Icon(productData.isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                productData.favoriteStatus(auth.token, auth.userId);
              },
            ),
          ),
          title: Text(
            productData.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              cart.addItem(
                  productData.id, productData.price, productData.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Added item to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'undo',
                    onPressed: () {
                      cart.removeSingleItem(productData.id);
                    },
                  )));
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
