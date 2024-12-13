import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping_app/consts/app_constants.dart';
import 'package:online_shopping_app/providers/products_provider.dart';
import 'package:online_shopping_app/widgets/app_name_text.dart';
import 'package:online_shopping_app/widgets/products/ctg_rounded_widget.dart';
import 'package:online_shopping_app/widgets/products/latest_arrival_products_widget.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:
            const AppNameTextWidget(), // Added `const` for better performance
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            'https://res.cloudinary.com/dueksc1xj/image/upload/v1733700836/shopping_cart_twbeff.png', // Cloudinary URL
            width: 40, // Width of the image
            height: 40, // Height of the image
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Image.network(
                      AppConstants.bannnersImages[index],
                    );
                  },
                  itemCount: AppConstants.bannnersImages.length,
                  autoplay: true,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Colors.red,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const TitlesTextWidget(
                label: "Latest arrival",
                fontSize: 22,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                      
                      value: productProvider.getProducts[index],
                      child: const LatestArrivalProductWidget());
                  },
                ),
              ),
              const TitlesTextWidget(
                label: "Categories",
                fontSize: 22,
          
              ),
              const SizedBox(
                height: 18,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                children: 
                  List.generate(AppConstants.categoriesList.length, (index){
                    return CategoryRoundedWidget(
                      image: AppConstants.categoriesList[index].images,
                      name: AppConstants.categoriesList[index].name,
          
                    );
                  }),
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
