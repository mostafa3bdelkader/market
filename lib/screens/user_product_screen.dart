import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/models/products.dart';
import 'package:flutter_complete_guide/widgets/user_product_item.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const pageRoute = '/userProducts';

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('your products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditScreen.pageRoute);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refresh(context),
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) => Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (_, i) => UserProductItem(
                                    productData.items[i].title,
                                    productData.items[i].imageUrl,
                                    productData.items[i].id),
                                itemCount: productData.items.length,
                              ),
                            ),
                            Divider()
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
