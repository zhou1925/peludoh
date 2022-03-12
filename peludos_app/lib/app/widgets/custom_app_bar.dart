import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pet_care/app/constants/colors.dart';


AppBar CustomAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: kBlackMainColor, fontWeight: FontWeight.bold),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            
          ),
        )
      ),
      actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/cart');
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(Icons.shopping_cart_outlined, size: 20, color: Colors.black,)
            ),),
          )
        ]
    );
  }

AppBar CustomAppBarCart2(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    
    );
  }



AppBar CustomAppBarSettings(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    );
  }

AppBar CustomAppBarHome(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    );
  }


AppBar CustomAppBarApmt(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    );
  }


AppBar CustomAppBarCart(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    );
  }


AppBar CustomAppBarAdoption(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    );
  }


AppBar CustomAppBarDetail(String title) {
    return AppBar(
      elevation: 0,
      title: Text(title, style: TextStyle(color: blackMain),),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: InkWell(
          onTap: () {
            Get.back();
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/back_arrow.svg',
              width: 24,
              height: 24,
              color: blackMain
            )
          ),
        )
      ),
    );
  }