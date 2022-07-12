import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lesson6_homework/edit_screen.dart';

import 'models/products.dart';

void main() {
  runApp(ScreenUtilInit(
      designSize: const Size(1080, 1920),
      builder: (BuildContext context, Widget? child) =>
          MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen())));
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [
    Product(
        name: 'Product 1',
        imageURL: 'assets/images/aothun.png',
        description: 'Ao thun',
        price: 10.5),
    Product(
        name: 'Product 2',
        imageURL: 'assets/images/ao_so_mi_nam.png',
        description: 'Ao so mi',
        price: 15.0),
    Product(
        name: 'Product 3',
        imageURL: 'assets/images/mu_tron.png',
        description: 'Mu tron',
        price: 7.9),
    Product(
        name: 'Product 4',
        imageURL: 'assets/images/vay_xep.png',
        description: 'Vay xep ngan',
        price: 19.9),
    Product(
        name: 'Product 5',
        imageURL: 'assets/images/chan_vay_dai_cong_so.png',
        description: 'Chan vay dai',
        price: 25.0)
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Products',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
            child: IconButton(
                onPressed: () {
                  _addItem();
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: ScreenUtil().setWidth(60),
                )),
          )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: _buildListView(),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var screenSize = MediaQuery.of(context).size;
        return Container(
          width: screenSize.width,
          height: ScreenUtil().setHeight(200),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(75)),
                child: Image.asset(
                  products[index].imageURL,
                  width: ScreenUtil().setWidth(150),
                  height: ScreenUtil().setHeight(150),
                  fit: BoxFit.cover,
                  errorBuilder: (context, object, trace) {
                    return SizedBox(
                      height: ScreenUtil().setHeight(150),
                      width: ScreenUtil().setWidth(150),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setHeight(75)),
                        child: Image.asset(
                          'assets/images/no_image.png',
                          width: ScreenUtil().setWidth(150),
                          height: ScreenUtil().setHeight(150),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(50),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  products[index].name,
                  style: TextStyle(fontSize: ScreenUtil().setHeight(40)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () async {
                    var result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return EditScreen(product: products[index]);
                      }),
                    );
                    setState(() {
                      products[index] = result;
                    });
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.purple,
                    size: ScreenUtil().setHeight(60),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.business,
                    color: Colors.green,
                    size: ScreenUtil().setHeight(60),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    _deleteItem(index);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: ScreenUtil().setHeight(60),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 2,
      ),
    );
  }

  Future _deleteItem(int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Delete Item',
          style: TextStyle(fontSize: ScreenUtil().setHeight(50)),
        ),
        content: Container(
          width: ScreenUtil().setWidth(800),
          height: ScreenUtil().setHeight(200),
          child: Center(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.delete,
                color: Colors.red,
                size: ScreenUtil().setHeight(50),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(50),
              ),
              Text(
                'Are You Sure?',
                style: TextStyle(fontSize: ScreenUtil().setHeight(50)),
              ),
            ]),
          ),
        ),
        actions: [
          Container(
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        products.removeAt(index);
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Text(
                      'Yes, Delete',
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(75),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(300),
                  height: ScreenUtil().setHeight(100),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Future _addItem() {
    late Product product = Product(
        name: 'Product ${(products.length + 1).toString()}',
        imageURL: 'assets/images/no_image.png',
        description: '${(products.length + 1).toString()} description',
        price: 0.0);

    final nameController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final imageUrlController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Add Item',
          style: TextStyle(
            fontSize: ScreenUtil().setWidth(50),
          ),
        ),
        actions: [
          SingleChildScrollView(
            child: Container(
              height: ScreenUtil().setHeight(800),
              width: ScreenUtil().setWidth(700),
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product name',
                      labelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                      floatingLabelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(50),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(50),
                    ),
                    cursorHeight: ScreenUtil().setHeight(75),
                    controller: nameController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product price',
                      labelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                      floatingLabelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(50),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(50),
                    ),
                    cursorHeight: ScreenUtil().setHeight(75),
                    controller: priceController,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product description',
                      labelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                      floatingLabelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(50),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(50),
                    ),
                    cursorHeight: ScreenUtil().setHeight(75),
                    controller: descriptionController,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Product imageUrl',
                      labelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(40),
                      ),
                      floatingLabelStyle: TextStyle(
                        fontSize: ScreenUtil().setHeight(50),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: ScreenUtil().setHeight(50),
                    ),
                    cursorHeight: ScreenUtil().setHeight(75),
                    controller: imageUrlController,
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ScreenUtil().setHeight(250),
                        height: ScreenUtil().setHeight(100),
                        child: ElevatedButton(
                            onPressed: () {
                              product.name = nameController.text.isEmpty
                                  ? product.name
                                  : nameController.text;
                              product.price = priceController.text.isEmpty
                                  ? product.price
                                  : double.parse(priceController.text);
                              product.description =
                                  descriptionController.text.isEmpty
                                      ? product.description
                                      : descriptionController.text;
                              product.imageURL = imageUrlController.text.isEmpty
                                  ? product.imageURL
                                  : imageUrlController.text;
                              Navigator.pop(context, product);
                              setState(() {
                                products.add(product);
                              });
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: Text(
                              'Add Item',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setHeight(35)),
                            )),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(100),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(250),
                        height: ScreenUtil().setHeight(100),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setHeight(35),),
                            ),),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
