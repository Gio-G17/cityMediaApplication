import 'package:flutter/material.dart';

class VisualComponent extends StatefulWidget {
  final int duration;
  final Color color;

  const VisualComponent({
    Key? key,
    required this.duration,
    required this.color,
  }) : super(key: key);

  @override
  _VisualComponentState createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: animController,
      curve: Curves.easeInOutCubic,
    );

    animation = Tween<double>(begin: 12.5, end: 2.5).animate(curvedAnimation) // Only top half changes size
      ..addListener(() {
        setState(() {});
      });

    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5, // Fixed width for the bar
      height: 25, // Fixed height of 25 for the entire bar
      child: Align(
        alignment: Alignment.bottomCenter, // Aligning the changing part at the top
        child: Container(
          height: animation.value, // Only top half changes
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.zero, // Rectangular shape, no rounded corners
          ),
        ),
      ),
    );
  }
}
