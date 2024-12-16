import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:online_shopping_app/models/product_model.dart';
import 'package:online_shopping_app/providers/products_provider.dart';
import 'package:online_shopping_app/widgets/products/products_widget.dart';
import 'package:online_shopping_app/widgets/titles_text.dart';
import 'package:provider/provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchScreen extends StatefulWidget {
  static const routeName = "/SearchScreen";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController seachTextController;
  List<ProductModel> productListSearch = [];
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _voiceInput = '';

  @override
  void initState() {
    seachTextController = TextEditingController();
    _speech = stt.SpeechToText();
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

    void startListening() async {
      bool available = await _speech.initialize(
        onError: (error) {
          debugPrint('Speech initialization error: $error');
        },
      );

      if (available) {
        setState(() => _isListening = true);
        debugPrint("Listening...");
        _speech.listen(onResult: (result) {
          setState(() {
            _voiceInput = result.recognizedWords;
            seachTextController.text = _voiceInput;
            productListSearch = productProvider.searchQuery(
                searchText: _voiceInput, passedList: productList);
          });
        });
      } else {
        debugPrint("Speech recognition not available");
      }
    }

    void stopListening() {
      setState(() => _isListening = false);
      _speech.stop();
    }

    void scanBarcode() async {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Scan Barcode')),
            body: MobileScanner(onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              debugPrint(
                  'Detected Barcodes: ${barcodes.map((b) => b.rawValue).toList()}');

              if (barcodes.isNotEmpty) {
                final String? code = barcodes.first.rawValue;
                if (code != null) {
                  setState(() {
                    seachTextController.text = code;
                    productListSearch = productProvider.searchQuery(
                        searchText: code, passedList: productList);
                  });
                  Navigator.pop(context);
                }
              } else {
                debugPrint('No barcode detected');
              }
            }),
          ),
        ),
      );
    }

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
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: scanBarcode,
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.green),
                            ),
                            const Icon(IconlyLight.search),
                          ],
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed:
                                  _isListening ? stopListening : startListening,
                              icon: Icon(
                                _isListening ? Icons.mic : Icons.mic_none,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
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
                          ],
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        setState(() {
                          productListSearch = productProvider.searchQuery(
                              searchText: seachTextController.text,
                              passedList: productList);
                        });
                      },
                      onChanged: (value) {
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
