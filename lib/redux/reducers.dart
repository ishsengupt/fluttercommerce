import 'package:my_commerce_app/models/app_state.dart';
import 'package:my_commerce_app/models/order.dart';
import 'package:my_commerce_app/models/product.dart';
import 'package:my_commerce_app/models/user.dart';
import 'package:my_commerce_app/redux/actions.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      user: userReducer(state.user, action),
      products: productsReducer(state.products, action),
      cartProducts: cartProducts(state.cartProducts, action),
      cards: cardsReducer(state.cards, action),
      cardToken: cardTokenReducer(state.cardToken, action),
      orders: ordersReducer(state.orders, action));
}

User userReducer(User user, dynamic action) {
  if (action is GetUserAction) {
    return action.user;
  } else if (action is LogoutUserAction) {
    return action.user;
  }
  return user;
}

List<Product> productsReducer(List<Product> products, dynamic action) {
  if (action is GetProductsAction) {
    return action.products;
  }
  return products;
}

List<Product> cartProducts(List<Product> cartProducts, dynamic action) {
  if (action is GetCartProductsAction) {
    return action.cartProducts;
  } else if (action is ToggleCartProductAction) {
    return action.cartProducts;
  } else if (action is ClearCartProductsAction) {
    return action.cartProducts;
  }
  return cartProducts;
}

List<dynamic> cardsReducer(List<dynamic> cards, dynamic action) {
  if (action is GetCardsAction) {
    return action.cards;
  } else if (action is AddCardAction) {
    return List.from(cards)..add(action.card);
  }
  return cards;
}

String cardTokenReducer(String cardToken, dynamic action) {
  if (action is GetCardTokenAction) {
    return action.cardToken;
  } else if (action is UpdateCardTokenAction) {
    return action.cardToken;
  }
  return cardToken;
}

List<Order> ordersReducer(List<Order> orders, dynamic action) {
  if (action is GetOrdersAction) {
    return action.orders;
  } else if (action is AddOrderAction) {
    return List.from(orders)..add(action.order);
  }
  return orders;
}
