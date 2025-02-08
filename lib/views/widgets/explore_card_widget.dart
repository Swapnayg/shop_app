import 'package:flutter/material.dart';
import 'package:shop_app/core/model/exploreItem.dart';

class ExploreCardWidget extends StatelessWidget {
  final exploreItem data;
  const ExploreCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: AssetImage(data.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
