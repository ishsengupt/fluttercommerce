import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_commerce_app/models/app_state.dart';
import 'package:my_commerce_app/pages/cart_page.dart';
import 'package:my_commerce_app/redux/actions.dart';
import 'package:my_commerce_app/redux/reducers.dart';
import 'package:my_commerce_app/pages/login_page.dart';
import 'package:my_commerce_app/pages/products_page.dart';
import 'package:my_commerce_app/pages/register_page.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_logging/redux_logging.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: [thunkMiddleware, LoggingMiddleware.printer()]);
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  MyApp({this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Flutter E-Commerce',
          routes: {
            '/': (BuildContext context) => ProductsPage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getUserAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getProductsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCartProductsAction);
                }),
            '/login': (BuildContext context) => LoginPage(),
            '/register': (BuildContext context) => RegisterPage(),
            '/cart': (BuildContext context) => CartPage(onInit: () {
                  StoreProvider.of<AppState>(context).dispatch(getCardsAction);
                  StoreProvider.of<AppState>(context)
                      .dispatch(getCardTokenAction);
                })
          },
          theme: ThemeData(
              appBarTheme: AppBarTheme(
                elevation: 0, // This removes the shadow from all App Bars.
              ),
              brightness: Brightness.dark,
              primaryColor: Colors.white,
              accentColor: Colors.deepOrange[200],
              textTheme: TextTheme(
                  headline:
                      TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                  title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                  body1: TextStyle(fontSize: 18.0))),
        ));
  }
}
