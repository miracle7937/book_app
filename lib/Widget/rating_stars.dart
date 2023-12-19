import 'package:flutter/material.dart';

class RatingStar extends StatefulWidget {
  final int maxRating;
  final int initialRating;
  final double iconSize;
  final Function(int)? onRatingChanged;

  RatingStar({
    this.maxRating = 5,
    this.initialRating = 1,
    this.onRatingChanged,
    this.iconSize = 20,
  });

  @override
  _RatingStarState createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  late int _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
  }

  Widget _buildStar(int index) {
    IconData iconData = index < _currentRating ? Icons.star : Icons.star_border;

    return GestureDetector(
      onTap: widget.onRatingChanged == null
          ? null
          : () {
              setState(() {
                _currentRating = index + 1;
                if (widget.onRatingChanged != null) {
                  widget.onRatingChanged!(_currentRating);
                }
              });
            },
      child: Icon(
        iconData,
        color: index < _currentRating ? Colors.orange : Colors.grey,
        size: widget.iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.maxRating, (index) => _buildStar(index)),
    );
  }
}
