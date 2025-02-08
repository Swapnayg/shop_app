import 'package:flutter/material.dart';
import 'package:shop_app/constant/app_color.dart';
import 'package:shop_app/core/model/Review.dart';
//import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewTile extends StatelessWidget {
  final Review_p review_t;
  const ReviewTile({super.key, required this.review_t});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Photo
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: AssetImage(review_t.photoUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Username - Rating - Comments
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username - Rating
                  Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 8,
                          child: Text(
                            review_t.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColor.primary,
                                fontFamily: 'poppins'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Text(review_t.name),
                          //child: //SmoothStarRating(
                          //allowHalfRating: false,
                          //size: 16,
                          // color: Colors.orange[400],
                          //rating: review.rating,
                          //borderColor: AppColor.primarySoft,
                          //),
                        )
                      ],
                    ),
                  ),
                  // Comments
                  Text(
                    review_t.review,
                    style: TextStyle(
                        color: AppColor.secondary.withOpacity(0.7),
                        height: 150 / 100),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
