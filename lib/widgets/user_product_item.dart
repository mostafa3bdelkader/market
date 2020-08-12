import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_complete_guide/models/products.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  UserProductItem(this.title, this.imageUrl, this.id);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(
        context); //we put it in a separate variable because it doesn't work in a future
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditScreen.pageRoute, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id);
                } catch (e) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('deleting failed.'),
                  ));
                }
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
