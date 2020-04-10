import 'package:flutter/material.dart';
import 'package:my_commerce_app/models/app_state.dart';
import 'package:my_commerce_app/models/product.dart';
import 'package:my_commerce_app/pages/product_detail_page.dart';
import 'package:my_commerce_app/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItem extends StatelessWidget {
  final Product item;
  ProductItem({this.item});

  bool _isInCart(AppState state, String id) {
    final List<Product> cartProducts = state.cartProducts;
    return cartProducts.indexWhere((cartProduct) => cartProduct.id == id) > -1;
  }

  hexStringToHexInt(String hex) {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? 'ff' + hex : hex;
    int val = int.parse(hex, radix: 16);
    return val;
  }

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = 'http://localhost:1337${item.picture['url']}';
    final String colorPick = '${item.color}';
    final int hexedColor = hexStringToHexInt(colorPick);
    return InkWell(
        onTap: () =>
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return ProductDetailPage(item: item);
            })),
        child: GridTile(
          child: Container(
            child: Align(
                alignment: FractionalOffset.topCenter,
                child: GridTileBar(
                    title: FittedBox(
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            margin: EdgeInsets.only(left: 22, top: 20),
                            child: Text(item.name,
                                style: GoogleFonts.roboto(
                                    textStyle:
                                        Theme.of(context).textTheme.display1,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.deepPurple[900])))),
                    subtitle: Container(
                        margin: EdgeInsets.only(left: 22),
                        child: Text("\$${item.price}",
                            style: GoogleFonts.roboto(
                                textStyle: Theme.of(context).textTheme.display1,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: Colors.grey[500]))),
                    trailing: StoreConnector<AppState, AppState>(
                        converter: (store) => store.state,
                        builder: (_, state) {
                          return state.user != null
                              ? IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  color: _isInCart(state, item.id)
                                      ? Colors.lime[500]
                                      : Colors.deepPurple[900],
                                  onPressed: () {
                                    StoreProvider.of<AppState>(context)
                                        .dispatch(
                                            toggleCartProductAction(item));
                                  })
                              : Text('');
                        }))),
            decoration: BoxDecoration(
                color: Color(hexedColor),
                image: DecorationImage(
                  image: new NetworkImage(pictureUrl),
                  fit: BoxFit.scaleDown,
                )),
          ),

          /* child: Hero(
                tag: item,
                child: Image.network(pictureUrl, fit: BoxFit.cover)) */
        ));
  }
}
