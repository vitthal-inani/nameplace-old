import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  @override
  final Text initialtext, finaltext;
  final ButtonStyle buttonStyle;
  final IconData icon;
  final double iconsize;
  final Duration animationduration;
  final Function onTap;
  final bool reset;
  final ButtonStates state;

  AnimatedButton({this.initialtext,
    this.finaltext,
    this.buttonStyle,
    this.icon,
    this.iconsize = 16,
    this.animationduration,
    this.onTap,
    this.state = ButtonStates.ONLY_TEXT,
    this.reset = false})
      : assert(Duration != null),
        assert(icon != null);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  ButtonStates _currentstate;
  Duration _smallDuration;

  @override
  void initState() {
    super.initState();
    _smallDuration = Duration(
        milliseconds: (widget.animationduration.inMilliseconds * 0.2).round());
    _controller =
        AnimationController(vsync: this, duration: widget.animationduration);
    _currentstate = widget.state;
    _controller.addListener(() {
      double controllerValue = _controller.value;
      if (controllerValue < 0.4) {
        setState(() {
          _currentstate = ButtonStates.ONLY_ICON;
        });
      } else {
        setState(() {
          _currentstate = ButtonStates.BOTH;
        });
      }
    });
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      borderRadius: (_currentstate == ButtonStates.ONLY_ICON)
          ? BorderRadius.circular(40)
          : BorderRadius.all(Radius.circular(40.00)),
      color: (_currentstate == ButtonStates.ONLY_TEXT)
          ? widget.buttonStyle.intialColour
          : widget.buttonStyle.finalColour,
      child: InkWell(
        onTap: () {
          _controller.forward();
          widget.onTap();
          if(_controller.isCompleted){
            _controller.value = 0;
          }
          print(_controller.value);
        },
        child: AnimatedContainer(
          duration: _smallDuration,
          height: widget.iconsize + 32,
          decoration: BoxDecoration(
            color: (_currentstate == ButtonStates.ONLY_TEXT)
                ? widget.buttonStyle.intialColour
                : widget.buttonStyle.finalColour,
            borderRadius: (_currentstate == ButtonStates.ONLY_ICON)
                ? BorderRadius.circular(40)
                : BorderRadius.all(Radius.circular(40.00)),
            border: Border.all(
                color: (_currentstate == ButtonStates.ONLY_TEXT)
                    ? widget.finaltext.style.color
                    : widget.buttonStyle.intialColour),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.00, vertical: 10.00),
          child: AnimatedSize(
            vsync: this,
            duration: _smallDuration,
            curve: Curves.easeInOut,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (_currentstate != ButtonStates.ONLY_TEXT)
                    ? Container(
                  padding: (_currentstate == ButtonStates.ONLY_ICON)
                      ? EdgeInsets.symmetric(horizontal: 5)
                      : null,
                  child: Icon(
                    widget.icon,
                    size: widget.iconsize,
                    color: widget.finaltext.style.color,
                  ),
                )
                    : Container(),
                (_currentstate == ButtonStates.ONLY_TEXT)
                    ? widget.initialtext
                    : Container(),
                SizedBox(
                  width: (_currentstate == ButtonStates.BOTH) ? 20 : 0,
                ),
                (_currentstate == ButtonStates.BOTH)
                    ? widget.finaltext
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonStyle {
  final Color intialColour, finalColour;
  final double elevation, borderradius;

  ButtonStyle(
      {this.intialColour, this.finalColour, this.elevation, this.borderradius});
}

enum ButtonStates {
  ONLY_TEXT,
  ONLY_ICON,
  BOTH,
}
