import 'package:flutter/material.dart';

class AnimateButton extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final Color? titleColor;
  final double? radius;
  final double? width;
  final double? height;
  final Color? starColor;
  final Color? endColor;

  const AnimateButton(
      {Key? key,
      this.onTap,
      this.width = 150,
      this.height = 50,
      this.starColor = Colors.cyan,
      this.endColor = Colors.blue,
      this.title,
      this.titleColor,
      this.radius = 20})
      : super(key: key);

  @override
  State<AnimateButton> createState() => _AnimateButtonState();
}

class _AnimateButtonState extends State<AnimateButton> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  final Duration animDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _startAnim,
      onTapUp: _upAnim,
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (BuildContext context, Widget? child) {
          // return ClipPath(
          // clipper: const GuidingStarClipper(),
          // child:
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius!),
              color: color,
            ),
            alignment: Alignment.center,
            height: widget.height,
            width: widget.width,
            child: Text(
              widget.title ?? "",
              style: TextStyle(color: widget.titleColor, fontSize: widget.height! * 0.3),
            ),
            // ),
          );
        },
      ),
    );
  }

  Color get color => Color.lerp(widget.starColor, widget.endColor, _ctrl.value)!;

  void _startAnim(TapDownDetails details) {
    _ctrl.forward();
  }

  void _upAnim(TapUpDetails details) {
    _ctrl.reset();
  }
}
