import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpfe/controller/home_controller.dart';
import 'package:flutterpfe/model/products.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
   HomeView({Key? key}) : super(key: key);
   HomeController controller = Get.put(HomeController());

   @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body:Column(children: [
        Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(10),child: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.addressList.isNotEmpty
            ? RefreshIndicator(
          onRefresh: () =>
              controller.getProducts(isShowLoading: false),
          child: ListView.builder(
              shrinkWrap: false,
              itemCount: controller.addressList.length,
              itemBuilder: (context, i) {
                return productItem(controller.addressList[i]);
              }),
        )
            : Container(child: Text("Not Found Item"),),))
      ],) ,
    );
  }
   Widget productItem(Products item) {
     return InkWell(
       onTap: (){

       },
       child: Container(
           width:double.infinity,
           padding: EdgeInsets.all(10.0),
           margin: const EdgeInsets.symmetric(vertical: 8.0),
           child: Text(item.price ?? "")),
     );
   }

}
