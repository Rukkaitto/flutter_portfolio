import 'dart:math';

import 'package:flutter/material.dart';

class Spinner extends StatefulWidget {
  const Spinner({
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.startDelay = const Duration(milliseconds: 0),
    this.repeatDelay = const Duration(milliseconds: 0),
    this.repeat = true,
    this.curve = Curves.linear,
    this.alignment = AlignmentDirectional.center,
    Key? key,
  }) : super(key: key);

  final Duration duration;
  final Duration startDelay;
  final Duration repeatDelay;
  final bool repeat;
  final Curve curve;
  final Widget child;
  final AlignmentGeometry alignment;

  @override
  State<Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addStatusListener((status) {
        if (widget.repeat && status == AnimationStatus.completed) {
          Future.delayed(widget.repeatDelay, () {
            _controller.forward(from: 0.0);
          });
        }
      });

    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);

    Future.delayed(widget.startDelay, () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final angle = _animation.value * (2 * pi);
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateY(angle);

        return Transform(
          alignment: widget.alignment,
          transform: transform,
          child: widget.child,
        );
      },
    );
  }
}
