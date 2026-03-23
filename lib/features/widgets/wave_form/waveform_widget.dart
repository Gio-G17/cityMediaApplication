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

    animation = Tween<double>(begin: 12.5, end: 2.5).animate(curvedAnimation)
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
      width: 5,
      height: 25,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: animation.value,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}
