import 'package:flutter/material.dart';
import 'package:food_flutter/models/food.dart';

class foodListItem extends StatelessWidget {
  static const iconSize = 18.0;

  final food foods;

  const foodListItem({
    super.key,
    required this.foods,
  });

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;

    var hasRating = foods.averageRating > 0;
    var numWholeStar = foods.averageRating.truncate();
    var fraction = foods.averageRating - numWholeStar;
    var showHalfStar = fraction >= 0.5;
    var numBlankStar = 5 - numWholeStar - (showHalfStar ? 1 : 0);

    return Card(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                  width: 60.0,
                  height: 60.0,
                  color: colorScheme.background,
                  child: Center(child: Icon(Icons.home, size: 30.0))),
              SizedBox(width: 8.0),
              Expanded(child: Text(foods.name, style: textTheme.titleLarge)),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                hasRating
                    ? Row(children: [
                  for (var i = 0; i < numWholeStar; i++)
                    Icon(Icons.star, size: iconSize),
                  if (showHalfStar) Icon(Icons.star_half, size: iconSize),
                  for (var i = 0; i < numBlankStar; i++)
                    Icon(Icons.star_border, size: iconSize),
                  //Text(toilet.averageRating.toStringAsFixed(1))
                ])
                    : Text('ยังไม่มีคะแนน'),
                Text('${foods.distance.toString()} เมตร',
                    style: textTheme.bodyLarge)
              ])
            ])));
  }
}
