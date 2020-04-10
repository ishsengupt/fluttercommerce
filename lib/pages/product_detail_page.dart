import 'package:flutter/material.dart';
import 'package:my_commerce_app/models/app_state.dart';
import 'package:my_commerce_app/models/product.dart';
import 'package:my_commerce_app/pages/products_page.dart';
import 'package:my_commerce_app/redux/actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductDetailPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Product item;
  ProductDetailPage({this.item});

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
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        appBar: AppBar(
            title: Container(
                padding: EdgeInsets.only(right: 160.0),
                child: Text("${item.name}".toUpperCase(),
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.deepPurple[900])))),
        body: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Column(children: [
                  Container(
                      padding: EdgeInsets.only(top: 30.0, right: 50.0),
                      child: Text("${item.name}",
                          style: GoogleFonts.roboto(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              fontStyle: FontStyle.normal,
                              color: Colors.deepPurple[900]))),
                  Container(
                      padding: EdgeInsets.only(top: 10, right: 135.0),
                      child: Text("Flyknit Wear",
                          style: GoogleFonts.roboto(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey[500]))),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Stack(children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(left: 90, top: 50),
                            child: Transform.rotate(
                                angle: 3 / 4,
                                child: Container(
                                    height: 300,
                                    width: 300,
                                    color: Color(hexedColor)))),
                        Container(
                            padding: EdgeInsets.only(left: 10.0),
                            margin:
                                const EdgeInsets.only(top: 10.0, left: 40.0),
                            child: Transform.rotate(
                                angle: -1 / 2,
                                child: Hero(
                                    tag: item,
                                    child: Image.network(pictureUrl,
                                        width:
                                            orientation == Orientation.portrait
                                                ? 600
                                                : 250,
                                        height:
                                            orientation == Orientation.portrait
                                                ? 400
                                                : 200,
                                        fit: BoxFit.cover)))),
                        Container(
                            margin: EdgeInsets.only(left: 10, right: 120.0),
                            padding: EdgeInsets.only(left: 10),
                            child: ButtonBar(
                              children: <Widget>[
                                RaisedButton(
                                    color: Colors.white,
                                    onPressed: () {},
                                    child: Text('Rose Gold',
                                        style: GoogleFonts.roboto(
                                            fontSize: 14,
                                            letterSpacing: 0.8,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.grey[700]))),
                                Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: RaisedButton(
                                        color: Colors.white,
                                        onPressed: () {},
                                        child: Text('AMER - 10.5',
                                            style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                letterSpacing: 0.8,
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.grey[700])))),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 70, top: 130.0),
                            child: Text('\$${item.price}',
                                style: GoogleFonts.roboto(
                                    fontSize: 70,
                                    letterSpacing: 0.2,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.deepPurple[900]))),
                      ])),
                  Container(
                      child: Padding(
                          child: Text(item.description.toUpperCase(),
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  letterSpacing: 0.4,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey[700])),
                          padding: EdgeInsets.only(
                              left: 32.0, right: 32.0, bottom: 32.0))),
                  Container(
                      margin: EdgeInsets.only(bottom: 120),
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: StoreConnector<AppState, AppState>(
                              converter: (store) => store.state,
                              builder: (_, state) {
                                return state.user != null
                                    ? RaisedButton(
                                        child: Text('ADD TO CART',
                                            style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                letterSpacing: 0.2,
                                                fontWeight: FontWeight.w500,
                                                fontStyle: FontStyle.normal,
                                                color: Colors.white)),
                                        color: _isInCart(state, item.id)
                                            ? Colors.blue
                                            : Colors.deepPurple[900],
                                        onPressed: () {
                                          StoreProvider.of<AppState>(context)
                                              .dispatch(toggleCartProductAction(
                                                  item));
                                          final snackbar = SnackBar(
                                              duration: Duration(seconds: 2),
                                              content: Text('Cart updated',
                                                  style: TextStyle(
                                                      color: Colors.green)));
                                          _scaffoldKey.currentState
                                              .showSnackBar(snackbar);
                                        })
                                    : Text('');
                              }))),
                ]))));
  }
}
