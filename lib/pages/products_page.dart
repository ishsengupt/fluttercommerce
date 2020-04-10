import 'package:flutter/material.dart';
import 'package:my_commerce_app/models/app_state.dart';
import 'package:my_commerce_app/redux/actions.dart';
import 'package:my_commerce_app/widgets/product_item.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:badges/badges.dart';
import 'package:google_fonts/google_fonts.dart';

final gradientBackground = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        stops: [
      0.1,
      0.3,
      0.5,
      0.7,
      0.9
    ],
        colors: [
      Colors.deepOrange[300],
      Colors.deepOrange[400],
      Colors.deepOrange[500],
      Colors.deepOrange[600],
      Colors.deepOrange[700]
    ]));

class ProductsPage extends StatefulWidget {
  final void Function() onInit;
  ProductsPage({this.onInit});

  @override
  ProductsPageState createState() => ProductsPageState();
}

class ProductsPageState extends State<ProductsPage> {
  void initState() {
    super.initState();
    widget.onInit();
  }

  final _appBar = PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
          converter: (store) => store.state,
          builder: (context, state) {
            return AppBar(
                elevation: 0.0,
                centerTitle: true,
                title: SizedBox(
                    child: Container(
                        child: state.user != null
                            ? Text(" ${state.user.username}",
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.deepPurple[900]))
                            : FlatButton(
                                child: Text('Register Here',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.deepPurple[900])),
                                onPressed: () => Navigator.pushNamed(
                                    context, '/register')))),
                leading: state.user != null
                    ? Container(
                        padding: EdgeInsets.only(left: 20.0),
                        child: BadgeIconButton(
                            itemCount: state.cartProducts.length,
                            badgeColor: Colors.lime,
                            badgeTextColor: Colors.deepPurple[900],
                            icon: Icon(Icons.store),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/cart')))
                    : Text(''),
                actions: [
                  Padding(
                      padding: EdgeInsets.only(right: 12.0),
                      child: StoreConnector<AppState, VoidCallback>(
                          converter: (store) {
                        return () => store.dispatch(logoutUserAction);
                      }, builder: (_, callback) {
                        return state.user != null
                            ? IconButton(
                                icon: Icon(Icons.exit_to_app),
                                onPressed: callback)
                            : Text('');
                      }))
                ]);
          }));

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        appBar: _appBar,
        body: Container(
            color: Colors.white,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 32, bottom: 10),
                  child: Text('Sports Shoes',
                      style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.display1,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          color: Colors.deepPurple[900]))),
              Container(
                  margin: EdgeInsets.only(left: 32),
                  alignment: Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(maxHeight: 50.0, minHeight: 20.0),
                    child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text('All (100)',
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.display1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.deepPurple[900]))),
                          Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text('Running (12)',
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.display1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey[500]))),
                          Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text('Fresh (42)',
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.display1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey[500]))),
                          Container(
                              margin: EdgeInsets.only(right: 20),
                              child: Text('Baseball (30)',
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.display1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey[500]))),
                          Container(
                              child: Text('Other (30)',
                                  style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.display1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.grey[500])))
                        ]),
                  )),
              Expanded(
                  child: Container(
                      color: Colors.white,
                      child: StoreConnector<AppState, AppState>(
                          converter: (store) => store.state,
                          builder: (_, state) {
                            return Column(children: [
                              Expanded(
                                  child: Container(
                                      child: SafeArea(
                                          top: true,
                                          bottom: false,
                                          child: GridView.builder(
                                              itemCount: state.products.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount:
                                                          orientation ==
                                                                  Orientation
                                                                      .portrait
                                                              ? 1
                                                              : 2,
                                                      //crossAxisSpacing: 4.0,
                                                      // mainAxisSpacing: 4.0,
                                                      childAspectRatio:
                                                          orientation ==
                                                                  Orientation
                                                                      .portrait
                                                              ? 1.8
                                                              : 0.5),
                                              itemBuilder: (context, i) =>
                                                  ProductItem(
                                                      item:
                                                          state.products[i])))))
                            ]);
                          })))
            ])));
  }
}
