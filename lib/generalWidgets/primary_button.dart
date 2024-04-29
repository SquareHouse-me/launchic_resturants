import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget childWidget;
  final double? width;
  final double? height;
  final double? borderRadius, elevation;

  final IconData? iconData;

  final Color? bgColor;
  const PrimaryButton(
      {Key? key,
      required this.onTap,
      required this.childWidget,
      this.width,
      this.height,
      this.elevation = 5,
      this.borderRadius = 7,
      required this.bgColor,
      this.iconData})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: widget.elevation ?? 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Container(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: widget.height ?? 55.h,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(widget.borderRadius!),
            ),
            child: widget.childWidget,
          ),
        ),
      ),
    );
  }
}
