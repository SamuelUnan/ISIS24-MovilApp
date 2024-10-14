import 'package:flutter/material.dart';
import '../services/CartDatabase.dart';
import '../models/product_model.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<ShoppingCartScreen> {
  late Future<List<Product>> _cartProducts;

  @override
  void initState() {
    super.initState();
    _cartProducts = CartDatabase.instance.fetchCart();
  }

  void _refreshCart() {
    setState(() {
      _cartProducts = CartDatabase.instance.fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Carrito de Compras",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: () async {
                    await CartDatabase.instance.clearCart();
                    _refreshCart();
                  },
                ),
              ],
            ),
          ),

          FutureBuilder<List<Product>>(
            future: _cartProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('El carrito está vacío'));
              }

              final products = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: EdgeInsets.all(16),
                    color: Colors.amberAccent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${product.name} x ${product.quantity}'),

                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () async {
                                if (product.quantity > 1) {
                                  await CartDatabase.instance
                                      .updateProductQuantity(
                                    product.id,
                                    product.quantity - 1,
                                  );
                                } else {
                                  await CartDatabase.instance
                                      .deleteProduct(product.id);
                                }
                                _refreshCart();
                              },
                            ),
                            Text(
                                '${product.quantity}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                await CartDatabase.instance
                                    .updateProductQuantity(
                                  product.id,
                                  product.quantity + 1,
                                );
                                _refreshCart();
                              },
                            ),
                          ],
                        ),

                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await CartDatabase.instance
                                .deleteProduct(product.id);
                            _refreshCart();
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () async {
                  final existingProduct =
                      await CartDatabase.instance.getProductById(1);

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
                        quantity: 1);
                    await CartDatabase.instance.insertProduct(newProduct2);
                  }

                  _refreshCart();
                }),
          ),
        ],
      ),
    );
  }
}
