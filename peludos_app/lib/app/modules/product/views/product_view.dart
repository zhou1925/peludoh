import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: Get.height * 0.40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://i.ibb.co/4VJ4nPJ/toy2.jpg'
                  )
                )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Title product',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      's./ 123',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description label',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Description Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.all(20),
                      child: LinearProgressIndicator(
                        value:0.7,
                        backgroundColor: Colors.grey,
                        color: Colors.purple
                      )
                    )
      
                  ],
                ),
              ),
            ),
      
          ]
        ),
      )
    );
  }
}
