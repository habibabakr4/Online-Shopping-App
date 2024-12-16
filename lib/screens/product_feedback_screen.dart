import 'package:flutter/material.dart';
import 'package:online_shopping_app/models/feedback_model.dart';

class ProductFeedbackScreen extends StatefulWidget {
  static const routeName = '/product-feedback';

  const ProductFeedbackScreen({Key? key}) : super(key: key);

  @override
  _ProductFeedbackScreenState createState() => _ProductFeedbackScreenState();
}

class _ProductFeedbackScreenState extends State<ProductFeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productTitleController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();

  // List to store feedback (you can replace this with a database or API call)
  List<ProductFeedback> feedbackList = [];

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Create a new ProductFeedback object
      final feedback = ProductFeedback(
        productTitle: _productTitleController.text,
        feedback: _feedbackController.text,
      );

      // Store the feedback (here we just add it to the list for simplicity)
      setState(() {
        feedbackList.add(feedback);
      });

      // Clear the text fields
      _productTitleController.clear();
      _feedbackController.clear();

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted successfully!')),
      );
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _productTitleController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Product Title Field
              TextFormField(
                controller: _productTitleController,
                decoration: const InputDecoration(
                  labelText: 'Product Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Feedback Field
              TextFormField(
                controller: _feedbackController,
                decoration: const InputDecoration(
                  labelText: 'Your Feedback',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Submit Button
              ElevatedButton(
                onPressed: _submitFeedback,
                child: const Text('Submit Feedback'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}