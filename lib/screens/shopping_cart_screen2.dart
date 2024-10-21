import 'package:flutter/material.dart';
import '../services/CartDatabase.dart';
import '../models/product_model.dart';

class ShoppingCartScreen2 extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<ShoppingCartScreen2> {
  List<Map<String, dynamic>> ProductsCart = [];

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    List<Product> cart = await CartDatabase.instance.fetchCart();
    List<Map<String, dynamic>> mappedCart = cart.map((product) {
      return {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
      };
    }).toList();

    setState(() {
      ProductsCart = mappedCart;
    });
  }

  void _refreshCart() async {
    List<Product> cart = await CartDatabase.instance.fetchCart();

    List<Map<String, dynamic>> mappedCart = cart.map((product) {
      return {
        'id': product.id,
        'name': product.name,
        'price': product.price,
        'quantity': product.quantity,
      };
    }).toList();

    setState(() {
      ProductsCart = mappedCart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Wrapping the ListView.builder inside a Container with a defined height
          Container(
            height: MediaQuery.of(context).size.height *
                0.7, // Adjust height as needed
            child: ProductsCart.isEmpty
                ? Center(
                    child: Text('Carrito Vacío')) // Show empty cart message
                : ListView.builder(
                    itemCount: ProductsCart.length,
                    itemBuilder: (context, index) {
                      final product = ProductsCart[index];
                      return _ShoppingCartItem(
                          product: product, onCartUpdate: _refreshCart);
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Fetch product with id 1
                final existingProduct =
                    await CartDatabase.instance.getProductById(2);

                // If the product exists, update its quantity
                if (existingProduct != null) {
                  await CartDatabase.instance.updateProductQuantity(
                    existingProduct.id,
                    existingProduct.quantity + 1,
                  );
                } else {
                  final newProduct2 = Product(
                    id: 2,
                    name: 'Producto2 Ejemplo',
                    price: 12.0,
                    quantity: 1,
                  );
                  await CartDatabase.instance.insertProduct(newProduct2);
                }
                _refreshCart();
              },
              child: Text('Agregar Producto'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShoppingCartItem extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onCartUpdate;

  _ShoppingCartItem({required this.product, required this.onCartUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(product['name']),
        subtitle: Text('Precio: \$${product['price']}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                if (product['quantity'] > 1) {
                  await CartDatabase.instance.updateProductQuantity(
                    product['id'],
                    product['quantity'] - 1,
                  );
                } else {
                  await CartDatabase.instance.deleteProduct(product['id']);
                }
                onCartUpdate();
              },
              icon: Icon(Icons.remove),
            ),
            Text('${product['quantity']}'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                int newQuantity = product['quantity'] + 1;
                await CartDatabase.instance.updateProductQuantity(
                  product['id'],
                  newQuantity,
                );
                onCartUpdate();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await CartDatabase.instance.deleteProduct(product['id']);
                onCartUpdate();
              },
            ),
          ],
        ),
      ),
    );
  }
}
