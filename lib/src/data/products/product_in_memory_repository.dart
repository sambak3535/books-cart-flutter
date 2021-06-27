import 'dart:convert';

import 'package:shopping_cart_flutter/src/domain/products/product.dart';
import 'package:shopping_cart_flutter/src/domain/products/product_repository.dart';

const products = '''[
  {
    "id": "1",
    "image":
    "https://m.media-amazon.com/images/I/81oKhu2bsgL._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Book 1",
    "price": 8.0
  },
  {
    "id": "2",
    "image":
    "https://m.media-amazon.com/images/I/81HnHYik58L._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Book 2",
    "price": 8.0
  },
  {
    "id": "3",
    "image":
    "https://m.media-amazon.com/images/I/81ZYZ9yl1hL._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Book 3",
    "price": 8.0
  },
  {
    "id": "4",
    "image":
    "https://m.media-amazon.com/images/I/61-DwEh1zrL._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Book 4",
    "price": 8.0
  },
  {
    "id": "5",
    "image":
    "https://m.media-amazon.com/images/I/71MG0EzCU4L._AC_UL640_FMwebp_QL65_.jpg",
    "title": "Book 5",
    "price": 8.0
  }
  
]''';

class ProductInMemoryRepository implements ProductRepository {
  @override
  Future<List<Product>> get() async {
    return Future.delayed(
        const Duration(seconds: 2), () => _parse(jsonDecode(products)));
  }

  List<Product> _parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseProducts(jsonItem)).toList();
  }

  Product _parseProducts(Map<String, dynamic> json) {
    return Product(json['id'], json['image'], json['title'], json['price']);
  }
}
