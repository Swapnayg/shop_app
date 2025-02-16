import 'package:flutter/material.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:shop_app/core/model/search.dart';

class SearchHistoryTile extends StatelessWidget {
  const SearchHistoryTile({super.key, required this.data, required this.onTap});

  final SearchHistory data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: AppColor.primarySoft,
              width: 1,
            ),
          ),
        ),
        child: Text(data.title!),
      ),
    );
  }
}
