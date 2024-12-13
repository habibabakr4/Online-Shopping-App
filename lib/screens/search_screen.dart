import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:online_shopping_app/models/product_model.dart';
import 'package:online_shopping_app/providers/products_provider.dart';
import 'package:online_shopping_app/widgets/products/products_widget.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController seachTextController;
  List<ProductModel> productListSearch = [];

  @override
  void initState() {
    seachTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: TitlesTextWidget(label: passedCategory ?? "Search"),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              'https://res.cloudinary.com/dueksc1xj/image/upload/v1733700836/shopping_cart_twbeff.png', // Cloudinary URL
              width: 40,
              height: 40,
            ),
          ),
        ),
        body: productList.isEmpty
            ? const Center(
                child: TitlesTextWidget(label: "No products found"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: seachTextController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          IconlyLight.search,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              seachTextController.clear();
                              FocusScope.of(context).unfocus();
                            });
                          },
                          icon: const Icon(
                            IconlyLight.closeSquare,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          productListSearch = productProvider.searchQuery(
                              searchText: seachTextController.text,
                              passedList: productList);
                        });
                      },
                      onChanged: (vakue){
                        setState(() {
                          productListSearch = productProvider.searchQuery(
                              searchText: seachTextController.text,
                              passedList: productList);
                        });
                      },
                    ),
                    if (seachTextController.text.isNotEmpty &&
                        productListSearch.isEmpty) ...{
                      const Center(
                        child: TitlesTextWidget(
                          label: "no results found",
                          fontSize: 30,
                        ),
                      )
                    },
                    Expanded(
                      child: DynamicHeightGridView(
                        builder: (context, index) {
                          return ProductsWidget(
                            productId: seachTextController.text.isNotEmpty
                                ? productListSearch[index].productId
                                : productList[index].productId,
                          );
                        },
                        itemCount: seachTextController.text.isNotEmpty
                            ? productListSearch.length
                            : productList.length,
                        crossAxisCount: 2,
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
