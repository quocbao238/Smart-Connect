import 'package:bsmart_connect/models/uimodel.dart';
import 'package:bsmart_connect/ui/widget/animation.dart';
import 'package:bsmart_connect/ui/widget/customUI.dart';
import 'package:bsmart_connect/ui/widget/styleSizebox.dart';
import 'package:bsmart_connect/ui/widget/styleText.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class InTroPage extends StatelessWidget {
  final GlobalKey introGlobalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Get size phone
    getScreenSize(context);

    //Animation for Logo
    final _tweenLogo = MultiTween<LogoAniProps>()
      ..add(
          // top left => top right
          LogoAniProps.offset,
          Tween(begin: Offset(0, -ScreenSize.height * 0.4), end: Offset(0, 0)),
          2000.milliseconds)
      ..add(
          // top right => bottom right
          LogoAniProps.offset,
          Tween(begin: Offset(0, 0), end: Offset(0, -20)),
          200.milliseconds)
      ..add(
        // bottom right => bottom left
        LogoAniProps.offset,
        Tween(begin: Offset(0, -20), end: Offset(0, 0)),
        200.milliseconds,
      )
      ..add(
        // bottom right => bottom left
        LogoAniProps.offset,
        Tween(begin: Offset(0, 0), end: Offset(0, 0)),
        1000.milliseconds,
      )
      ..add(
          // bottom left => top left
          LogoAniProps.offset,
          Tween(begin: Offset(0, 0), end: Offset(0, ScreenSize.height)),
          2000.milliseconds);

    //Animation for SignInGoogle
    final _tweenSignIn = MultiTween<SignInAniProps>()
      ..add(SignInAniProps.width, 0.0.tweenTo(ScreenSize.width * 0.8),
          500.milliseconds)
      ..add(SignInAniProps.height, 0.0.tweenTo(ScreenSize.height * 0.2),
          1200.milliseconds);

    return buildPageMain(_tweenLogo, _tweenSignIn);
  }

  Widget buildPageMain(MultiTween<LogoAniProps> _tweenLogo,
      MultiTween<SignInAniProps> _tweenSignIn) {
    return Scaffold(
      key: introGlobalKey,
      body: Stack(
        children: <Widget>[
          buildImageBackground(),
          buildTittleLogo(_tweenLogo),
          buildWelcome(),
          buildSinInGoogle(),
          buildBottomGuestMode(),
          // buildTittleIcon(),
        ],
      ),
    );
  }

  Widget buildImageBackground() {
    return Positioned.fill(
      child: Image.asset(
        ImageApp.introBackground,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget buildTittleLogo(MultiTween<LogoAniProps> _tween) {
    return PlayAnimation<MultiTweenValues<LogoAniProps>>(
      tween: _tween, // Pass in tween
      duration: _tween.duration, // Obtain duration from MultiTween
      builder: (context, child, value) {
        return Transform.translate(
          offset: value.get(LogoAniProps.offset), // Get animated offset
          child: buildTittleIcon(),
        );
      },
    );
  }

  Widget buildTittleIcon() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: ScreenSize.height * 0.4),
          width: ScreenSize.width,
          height: ScreenSize.height * 0.1,
          child: PlayAnimation<double>(
              tween: (0.0).tweenTo(ScreenSize.width * 0.1),
              duration: 5.seconds,
              delay: 2.seconds,
              curve: Curves.easeOut,
              builder: (context, child, value) {
                return Container(
                  width: value,
                  child: Center(
                    child: Image.asset(
                      ImageApp.introIcon,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
        ),
        Container(
          margin: EdgeInsets.only(top: ScreenSize.marginVertical),
          child: Text(
            "Smart Connect",
            style: TextStyle(
                color: Colors.white,
                fontSize: 32 * ScreenSize.szText,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: ScreenSize.marginVertical),
          child: Text(
            "Control your home eassier",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18 * ScreenSize.szText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWelcome() {
    return PlayAnimation<double>(
      duration: 400.milliseconds,
      tween: 0.0.tweenTo(80.0),
      builder: (context, child, height) {
        return PlayAnimation<double>(
          duration: 500.milliseconds,
          delay: 3000.milliseconds,
          tween: 2.0.tweenTo(ScreenSize.width),
          builder: (context, child, width) {
            return Container(
              margin: EdgeInsets.only(top: ScreenSize.height * 0.1),
              width: width,
              height: height,
              child: isEnoughForTypewriter(width)
                  ? Column(
                      children: <Widget>[
                        TypewriterText(
                          text: "Welcome to",
                          textStyle: TxtStyle.headerStyle18White70,
                        ),
                        TypewriterText(
                          text: "Smart Connect",
                          textStyle: TxtStyle.headerStyle30White,
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        );
      },
    );
  }

  Widget buildSinInGoogle() {
    return PlayAnimation<double>(
      duration: 1000.milliseconds,
      delay: 4000.milliseconds,
      curve: Curves.fastOutSlowIn,
      tween: 0.0.tweenTo(ScreenSize.width * 0.8),
      builder: (context, child, width) {
        return PlayAnimation<double>(
          // curve: Curves.easeOut,
          duration: 2000.milliseconds,
          // delay: 4500.milliseconds,
          tween: 0.0.tweenTo(ScreenSize.height * 0.07),
          builder: (context, child, height) {
            return GestureDetector(
              onTap: () {
                goToHome(introGlobalKey.currentContext);
              },
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: ScreenSize.height * 0.45,
                      right: ScreenSize.width * 0.1,
                      left: ScreenSize.width * 0.1,
                    ),
                    width: width,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.white,
                    ),
                    child: isEnoughForGoogleSignIn(width)
                        ? Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 24.0 * ScreenSize.szText,
                                  height: 24.0 * ScreenSize.szText,
                                  child: Image.asset(ImageApp.googleIcon),
                                ),
                                BoxMargin(
                                  isVertical: false,
                                  multi: 3,
                                ),
                                MyTxt(
                                  txt: "Sign in with Google",
                                  color: Colors.blue,
                                  size: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget buildBottomGuestMode() {
    return PlayAnimation<double>(
      duration: 1000.milliseconds,
      tween: 0.0.tweenTo(ScreenSize.height * 0.3),
      delay: 4500.milliseconds,
      builder: (context, child, height) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: ScreenSize.width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: Colors.white.withOpacity(0.95),
              ),
              child: isEnoughForGuestSignIn(height)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: ScreenSize.height * 0.15,
                          child: Image.asset(ImageApp.guestIcon),
                        ),
                        GestureDetector(
                          onTap: () {
                            goToHome(introGlobalKey.currentContext);
                          },
                          child: Container(
                            height: ScreenSize.height * 0.08,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                MyTxt(
                                  txt: "Are you a guest? Enable ",
                                  color: Colors.grey[400],
                                ),
                                MyTxt(
                                  txt: "Guest Mode",
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : Container(),
            ),
          ],
        );
      },
    );
  }

  //Valid for animation
  bool isEnoughForTypewriter(double width) => width > 20;
  bool isEnoughForGoogleSignIn(double width) => width > ScreenSize.width * 0.7;
  bool isEnoughForGuestSignIn(double height) =>
      height > ScreenSize.height * 0.25;
}
