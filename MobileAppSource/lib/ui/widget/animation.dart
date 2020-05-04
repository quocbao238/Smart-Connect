import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum LogoAniProps { offset }
enum SignInAniProps { width ,height}
enum AniProps { offset }


enum _FadeProps { opacity, translateX }
class FadeIn extends StatelessWidget {
  final double delay;
  final Widget child;
  FadeIn({this.delay, this.child});
  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_FadeProps>()
      ..add(_FadeProps.opacity, 0.0.tweenTo(1.0))
      ..add(_FadeProps.translateX, 130.0.tweenTo(0.0));
    return PlayAnimation<MultiTweenValues<_FadeProps>>(
      delay: (1000 * delay).round().milliseconds,
      duration: 500.milliseconds,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(_FadeProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(_FadeProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}
