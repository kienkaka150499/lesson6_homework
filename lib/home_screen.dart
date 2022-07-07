import 'package:flutter/material.dart';
import 'package:lesson6_homework/edit_screen.dart';

import 'models/products.dart';

void main() {
  runApp(MaterialApp(home: HomeScreen()));
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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          IconButton(
              onPressed: () {
                
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
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
          var screenSize = MediaQuery
              .of(context)
              .size;
          return Container(
              width: screenSize.width,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      products[index].imageURL,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Text(products[index].name)),
                  IconButton(
                      onPressed: () async {
                        var result = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditScreen(product: products[index])));
                        setState(() {
                          products[index] = result;
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.purple,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.folder_zip,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          products.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(
              thickness: 2,
            ));
  }
}
