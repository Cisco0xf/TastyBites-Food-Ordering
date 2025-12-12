import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodapp/common/commons.dart';
import 'package:foodapp/common/gaps.dart';
import 'package:foodapp/statemanagement/theming/is_light.dart';
import 'package:foodapp/common/app_dimention.dart';
import 'package:foodapp/constants/fonts.dart';

class ReviewerOpinoinWidget extends StatelessWidget {
  const ReviewerOpinoinWidget({
    super.key,
    required this.reviewerName,
    required this.reviewerOpinion,
    required this.reviewerRate,
    required this.fromWhen,
  });
  final String reviewerName;
  final double reviewerRate;
  final String reviewerOpinion;
  final String fromWhen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            /* Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: borderRaduis(5),
              ),
              child: ClipRRect(
                borderRadius: borderRaduis(7),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 35,
                  height: 35,
                ),
              ),
            ), */
            Container(
              padding: padding(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange, width: 1.4),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.orange),
            ),
            const Gap(width: 4.0),
            Text(
              reviewerName,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Text(
          reviewerOpinion,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            fontFamily: FontFamily.subFont,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RatingBar.builder(
              maxRating: 5.0,
              minRating: 0.0,
              itemCount: 5,
              itemSize: 20,
              direction: Axis.horizontal,
              initialRating: reviewerRate,
              allowHalfRating: true,
              tapOnlyMode: true,
              itemBuilder: (context, index) {
                return const Icon(
                  Icons.star,
                  color: Colors.amber,
                );
              },
              onRatingUpdate: (double rating) {},
            ),
            Text(reviewerRate.toString()),
          ],
        ),
        Text(fromWhen),
      ],
    );
  }
}

class ReviewersSector extends StatelessWidget {
  const ReviewersSector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.screenHeight * .4,
      width: context.screenWidth * .42,
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: borderRaduis(15),
        color:
            context.isLight ? const Color(0xFFFFF6DC) : const Color(0xFFA79277),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            for (int i = 0; i < reviewers.length; i++) ...{
              ReviewerOpinoinWidget(
                reviewerName: reviewers[i].name,
                reviewerOpinion: reviewers[i].description,
                reviewerRate: reviewers[i].rate,
                fromWhen: reviewers[i].fromWhen,
              ),
              if (i != reviewers.length - 1) const Divider(),
            },
            /*  ReviewerOpinoinWidget(
              reviewerName: "Sarah Oftli",
              reviewerOpinion: "I like it but it was a little bite cold",
              reviewerRate: 3.0,
              imagePath: "asstes/images/app_images/profile/woman_1.jpg",
              fromWhen: "3 munite ago",
            ),
            Divider(),
            ReviewerOpinoinWidget(
              reviewerName: "John Oftli",
              reviewerOpinion:
                  "One of the most delicious dish I vave ever tast",
              reviewerRate: 4.6,
              imagePath: "asstes/images/app_images/profile/man_2.jpg",
              fromWhen: "3 hours ago",
            ),
            Divider(),
            ReviewerOpinoinWidget(
              reviewerName: "Alix Oftli",
              reviewerOpinion: "I like it but it was a little bite cold",
              reviewerRate: 4.0,
              imagePath: "asstes/images/app_images/profile/man_3.jpg",
              fromWhen: "3 days ago",
            ),
            Divider(),
            ReviewerOpinoinWidget(
              reviewerName: "Sarah Ali",
              reviewerOpinion:
                  "One of the most delicious dish I vave ever tast",
              reviewerRate: 5.0,
              imagePath: "asstes/images/app_images/profile/woman_2.jpg",
              fromWhen: "3 munite ago",
            ),
            Divider(),
            ReviewerOpinoinWidget(
              reviewerName: "Khaled Moneer",
              reviewerOpinion: "It's perfect but the delevery was too late",
              reviewerRate: 3.8,
              imagePath: "asstes/images/app_images/profile/man_3.jpg",
              fromWhen: "32 munite ago",
            ),
            Divider(),
            ReviewerOpinoinWidget(
              reviewerName: "Ali Mossa",
              reviewerOpinion: "I like it ,will try again",
              reviewerRate: 4.5,
              imagePath: "asstes/images/app_images/profile/man_4.jpg",
              fromWhen: "12 munite ago",
            ), */
          ],
        ),
      ),
    );
  }
}

class ReviewerModel {
  final String name;
  final String description;
  final String fromWhen;
  final double rate;

  const ReviewerModel({
    required this.description,
    required this.fromWhen,
    required this.name,
    required this.rate,
  });
}

const List<ReviewerModel> reviewers = [
  ReviewerModel(
    name: "Sarah Oftli",
    description: "I like it but it was a little bite cold",
    rate: 3.0,
    fromWhen: "3 munite ago",
  ),
  ReviewerModel(
    name: "John Oftli",
    description: "One of the most delicious dish I vave ever tast",
    rate: 4.6,
    fromWhen: "3 hours ago",
  ),
  ReviewerModel(
    name: "Alix Oftli",
    description: "I like it but it was a little bite cold",
    rate: 4.0,
    fromWhen: "3 days ago",
  ),
  ReviewerModel(
    name: "Sarah Ali",
    description: "One of the most delicious dish I vave ever tast",
    rate: 5.0,
    fromWhen: "3 munite ago",
  ),
  ReviewerModel(
    name: "Khaled Moneer",
    description: "It's perfect but the delevery was too late",
    rate: 3.8,
    fromWhen: "32 munite ago",
  ),
  ReviewerModel(
    name: "Ali Mossa",
    description: "I like it ,will try again",
    rate: 4.5,
    fromWhen: "12 munite ago",
  ),
];
