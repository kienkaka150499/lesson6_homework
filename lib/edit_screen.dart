import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  bool _loadImage=true;

  @override
  void initState() {
    nameController.text = widget.product.name;
    priceController.text = widget.product.price.toString();
    descriptionController.text = widget.product.description;
    imageURLController.text = widget.product.imageURL;
    Future.delayed(const Duration(milliseconds: 200),(){
      setState((){});
      loadImage();
    });
    super.initState();
  }

  void loadImage(){
    _loadImage=true;
    precacheImage(AssetImage(widget.product.imageURL), context,onError: (e,stackTrace){
      setState((){
        loadImage();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, widget.product);
          },
          icon: Icon(
            Icons.chevron_left,
            size: ScreenUtil().setHeight(60),
          ),
        ),
        title: Text(
          'Edit Product',
          style: TextStyle(fontSize: ScreenUtil().setHeight(40)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setHeight(30)),
            child: IconButton(
              onPressed: () {
                setState(() {
                  widget.product.name = nameController.text.isEmpty
                      ? widget.product.name
                      : nameController.text;
                  widget.product.price = priceController.text.isEmpty
                      ? widget.product.price
                      : double.parse(priceController.text);
                  widget.product.description =
                      descriptionController.text.isEmpty
                          ? widget.product.description
                          : descriptionController.text;
                  widget.product.imageURL = imageURLController.text.isEmpty
                      ? widget.product.imageURL
                      : imageURLController.text;
                });
              },
              icon: Icon(
                Icons.save,
                color: Colors.white,
                size: ScreenUtil().setHeight(60),
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(ScreenUtil().setHeight(20)),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(100),
                child: Row(
                  children: [
                    Text(
                      'Expanded',
                      style: TextStyle(fontSize: ScreenUtil().setHeight(40)),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 1),
                          child: Text(
                            '1',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              fontSize: ScreenUtil().setHeight(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '1',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            backgroundColor: Colors.black.withOpacity(0.5),
                            fontSize: ScreenUtil().setHeight(30),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 1),
                          child: Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              backgroundColor: Colors.black.withOpacity(0.5),
                              fontSize: ScreenUtil().setHeight(30),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: ScreenUtil().setWidth(50),
                  ),
                ),
                controller: nameController,
                style: TextStyle(
                  fontSize: ScreenUtil().setWidth(50),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(
                      fontSize: ScreenUtil().setWidth(50),
                    ),),
                controller: priceController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: ScreenUtil().setWidth(50),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: ScreenUtil().setWidth(50),
                    ),),
                controller: descriptionController,
                style: TextStyle(
                  fontSize: ScreenUtil().setWidth(50),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: ScreenUtil().setHeight(200),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          widget.product.imageURL,
                          width: ScreenUtil().setWidth(200),
                          height: ScreenUtil().setHeight(200),
                          fit: BoxFit.cover,
                          errorBuilder: (context, object, StackTrace? strace) {
                            return SizedBox(
                              width: ScreenUtil().setWidth(200),
                              height: ScreenUtil().setHeight(200),
                              child: Image.asset(
                                'assets/images/no_image.png',
                                width: 80,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Image URL',
                          labelStyle: TextStyle(
                            fontSize: ScreenUtil().setWidth(50),
                          ),
                        ),
                        maxLines: 1,
                        controller: imageURLController,
                        style: TextStyle(
                          fontSize: ScreenUtil().setWidth(50),
                        ),
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
