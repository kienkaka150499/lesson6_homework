import 'package:flutter/material.dart';

import 'models/products.dart';

class EditScreen extends StatefulWidget {
  Product product;

  EditScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageURLController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text=widget.product.name;
    priceController.text=widget.product.price.toString();
    descriptionController.text=widget.product.description;
    imageURLController.text=widget.product.imageURL;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.product);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              onPressed: () {
                setState((){
                  widget.product.name=nameController.text.isEmpty?widget.product.name:nameController.text;
                  widget.product.price=priceController.text.isEmpty?widget.product.price:double.parse(priceController.text);
                  widget.product.description=descriptionController.text.isEmpty?widget.product.description:descriptionController.text;
                  widget.product.imageURL=imageURLController.text.isEmpty?widget.product.imageURL:imageURLController.text;
                });
              },
              icon: const Icon(
                Icons.save,
                color: Colors.white,
              ))
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    const Text('Expanded'),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1),
                        child: Text(
                          '1',
                          style: TextStyle(
                              backgroundColor: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                    )),
                    Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            '1',
                            style: TextStyle(
                                backgroundColor: Colors.black.withOpacity(0.5)),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 1),
                        child: Text(
                          '2',
                          style: TextStyle(
                              backgroundColor: Colors.black.withOpacity(0.5)),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: nameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                controller: priceController,
                keyboardType: TextInputType.number,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: descriptionController,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Image.asset(
                      widget.product.imageURL,
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(labelText: 'Image URL'),
                        maxLines: 1,
                        controller: imageURLController,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
