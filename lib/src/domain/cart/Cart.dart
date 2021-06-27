import 'package:shopping_cart_flutter/src/domain/cart/CartItem.dart';

class Cart {
  final List<CartItem> items;

  final double totalPrice;
  final int totalItems;

  Cart(this.items)
      : totalPrice = _calculateTotalPrice(items),
        totalItems = _calculateTotalItems(items);

  factory Cart.createEmpty() {
    return Cart([]);
  }

  Cart addItem(CartItem item) {
    final existedItem =
        items.firstWhere((i) => i.id == item.id, orElse: () => null);

    if (existedItem != null) {
      final newItems = items.map((oldItem) {
        if (oldItem.id == item.id) {
          return CartItem(oldItem.id, oldItem.image, oldItem.title,
              oldItem.price, oldItem.quantity + item.quantity);
        } else {
          return oldItem;
        }
      }).toList();

      return Cart(newItems);
    } else {
      final newItems = List.of(items);
      newItems.add(item);
      return Cart(newItems);
    }
  }

  Cart removeItem(CartItem itemToRemove) {
    final newItems = items.where((item) => item.id != itemToRemove.id).toList();

    return Cart(newItems);
  }

  Cart editItem(CartItem item, int quantity) {
    final newItems = items.map((oldItem) {
      if (oldItem.id == item.id) {
        return CartItem(
            oldItem.id, oldItem.image, oldItem.title, oldItem.price, quantity);
      } else {
        return oldItem;
      }
    }).toList();

    return Cart(newItems);
  }

  static double _calculateTotalPrice(List<CartItem> items) {

    final books = List<int>.filled(5, 0);

    for (var item in items) {
      books[int.parse(item.id) - 1] = item.quantity;
    }

    // sort
    books.sort((a, b) => b.compareTo(a));
    
    // max groups
    var groups = List<int>.filled(books[0], 0);

    // distribute
    for (var numBooks in books) {
        
        for (var i = 0; i < groups.length && numBooks != 0; ++i) {
            // we select 4, 4 rather than 5, 3 as 4, 4 give maximum discount
            if ((i + 1) < groups.length && groups[i] == 4 && groups[i + 1] == 3) {
                groups[i + 1]++;
                numBooks--;
            } else {
                groups[i]++;
                numBooks--;
            }
        }
    }

    // cost
    var cost = .0;
    
    print(groups);

    // final cost 
    for (var group in groups) {
        switch(group) {
            case 5:
                cost += 40 - 40 * .25;
                break;
        
            case 4:
                cost += 32 - 32 * .2;
                break;
            case 3:
                cost += 24 - 24 * .1;
                break;
            case 2:
                cost += 16 - 16 * .05;
                break;
            default:
                cost += 8;
                break;
        }
    }

    return double.parse(cost.toStringAsFixed(2));
  }

  static int _calculateTotalItems(List<CartItem> items) {
    return items.fold(0, (accumulator, item) => accumulator + item.quantity);
  }
}
