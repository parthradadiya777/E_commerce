import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/utility/constant.dart';
import 'package:flutter/material.dart';

class Cslider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: carousal.length,
      options: CarouselOptions(
        enableInfiniteScroll: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        autoPlayCurve: Curves.easeInSine,
        autoPlay: true,
        viewportFraction: 0.84,
        enlargeCenterPage: true,
      ),
      itemBuilder: (BuildContext contex, int index, int page) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  carousal[index].image,
                  fit: BoxFit.fitHeight,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black54.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25)),
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: Text(
                    carousal[index].text,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
