import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/cart_pages/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return  Scaffold(
      appBar: AppBar(

        title:const Center(
          child:Text("Cart",)
          ),
      ),
      body:ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context , index){
       final cartItems = cart[index];
        return ListTile(
          leading: CircleAvatar(
                     backgroundImage: AssetImage(cartItems['imageUrl'].toString(),),
                     radius:30,
            ),
          trailing: IconButton(
              onPressed: (){
                showDialog(
                context: context, 
                builder: (context){
                  return  AlertDialog(
                    title: Text("Delete Product",style:Theme.of(context).textTheme.titleMedium ,),
                    content: const Text("Are you sure you want to remove the product from cart?"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      child: const Text("No",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,

                      ),
                      ),
                      ),

                      TextButton(onPressed: (){
                        context.read<CartProvider>().removeProduct(cartItems);
                        Navigator.of(context).pop();
                      }, 
                      child: const Text("Yes",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,

                      ),),
                      ),

                    ],
                  );
                }
                );
              }, icon:const Icon(
              Icons.delete,color: Colors.red,
              ),
              ),  
          title: Text(
                     cartItems['title'].toString(),
                     style: Theme.of(context).textTheme.bodySmall,
            ),
          subtitle: Text(
                      "Size: ${cartItems['sizes'].toString()}",
            ),
        );
         

      },
      ),
    );
  }
}