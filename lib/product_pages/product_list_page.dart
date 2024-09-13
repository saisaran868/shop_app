import 'package:flutter/material.dart';
import 'package:shop_app/global_variables/global_variables.dart';
import 'package:shop_app/product_pages/product_card.dart';
import 'package:shop_app/product_pages/product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
    final List <String> filters =const ["All" , "Addidas" ,"Nike" ,"Bata"];
  late String selectedFilters;

    final border =  const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(225, 225, 225, 1),
                    ),
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(50),),
                  );

                    @override
  void initState() {
    super.initState();
    selectedFilters = filters[0];
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Row(

              children: [
                 Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Shoes\nCollection",
                              style: Theme.of(context).textTheme.titleLarge,
                              ),
                              ),

            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: border,
                  focusedBorder: border,
                ),
                textInputAction: TextInputAction.search,
              ),
            ),

            ],
            ),

               SizedBox(
              height: 120,
              child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
              final filter = filters[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFilters = filter;
                    });
                    
                  },
                  child: Chip(
                    backgroundColor:  selectedFilters == filter ? Theme.of(context).colorScheme.primary :const Color.fromRGBO(245, 247, 249, 1),
                    side: const BorderSide(
                      color:  Color.fromRGBO(245, 247, 249, 1),
                    ),
                    label:Text(filter),
                    labelStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    padding:const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 14, 
                      ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),

                    ),
                     ),

                ),
              );
                        },
                        ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context , index){
                  final product = products[index];
                  return   GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                     return ProductDetailsPage(product: product,);
                      },
                      ),
                      );
                    },
                    child: ProductCard(
                      title: product['title']as String,
                      price: product['price']as double,
                      image: product['imageUrl']as String ,
                      backGroungColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) :const Color.fromRGBO(245, 247, 249, 1),
                      ),
                  );
                }
                ),
            ),

          ],
        );
  }
}