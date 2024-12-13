import 'package:online_shopping_app/models/category_model.dart';

class AppConstants {
  static String ProductsImagesUrl = "https://res.cloudinary.com/dueksc1xj/image/upload/v1733707141/shoeas-nobull-superfabric-trainer-color-blue-daisy_zu3gcc.jpg";

  static List<String> bannnersImages =[
    "https://res.cloudinary.com/dueksc1xj/image/upload/v1733863304/banner1_llvcel.png",
    "https://res.cloudinary.com/dueksc1xj/image/upload/v1733863304/banner2_oqlxsn.png",
  ];

  static List<CategoryModel> categoriesList =[
    CategoryModel(
      id: "Phones", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733879748/mobiles_mgxlh2.png", 
      name: "Phones"
    ),
    CategoryModel(
      id: "Laptops", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733880409/pc_yf9pig.png", 
      name: "Laptops"
    ),
    CategoryModel(
      id: "Electronics", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733880409/electronics_woockt.png", 
      name: "Electronics"
    ),
    CategoryModel(
      id: "Watches", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733880410/watch_vfzpsf.png", 
      name: "Watches"
    ),
    CategoryModel(
      id: "Shoes", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733880410/shoes_qt3zvm.png", 
      name: "Shoes"
    ),
    CategoryModel(
      id: "Books", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733880409/book_img_eqz3ff.png", 
      name: "Books"
    ),
    CategoryModel(
      id: "Cosmetics", 
      images: "https://res.cloudinary.com/dueksc1xj/image/upload/v1733880409/cosmetics_hozclq.png", 
      name: "Cosmetics"
    ),
  ];
}