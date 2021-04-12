import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/globals.dart';

@immutable
class MyNeumorphicSlider extends StatefulWidget {
  final SliderStyle style;
  final double min;
  final double value;
  final double max;
  final double height;
  final NeumorphicSliderListener onChanged;
  final NeumorphicSliderListener onChangeStart;
  final NeumorphicSliderListener onChangeEnd;

  final Widget thumb;
  final double sliderHeight;

  MyNeumorphicSlider({
    Key key,
    this.style = const SliderStyle(),
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height = 15,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumb,
    this.sliderHeight,
  });

  double get percent => (((value.clamp(min, max)) - min) / ((max - min)));

  @override
  createState() => _NeumorphicSliderState();
}

class _NeumorphicSliderState extends State<MyNeumorphicSlider> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          final tapPos = details.localPosition;
          final newPercent = tapPos.dx / constraints.maxWidth;
          final newValue =
          ((widget.min + (widget.max - widget.min) * newPercent))
              .clamp(widget.min, widget.max);

          if (widget.onChanged != null) {
            widget.onChanged(newValue);
          }
        },
        onPanStart: (DragStartDetails details) {
          if (widget.onChangeStart != null) {
            widget.onChangeStart(widget.value);
          }
        },
        onPanEnd: (details) {
          if (widget.onChangeEnd != null) {
            widget.onChangeEnd(widget.value);
          }
        },
        child:  _widget(context),
      );
    });
  }

  Widget _widget(BuildContext context) {
    double thumbSize = widget.height * 1.5;
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return Neumorphic(
        style: NeumorphicStyle(
            color: backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(widget.style.borderRadius),
            lightSource: widget.style.lightSource ?? theme.lightSource,
            border: widget.style.border,
            disableDepth: widget.style.disableDepth,
            depth: 10,
            shape: NeumorphicShape.flat,
            shadowLightColor: softShadowColor,
            shadowDarkColor: shadowColor
        ),
        child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
          _generateSlider(context),
        Align(
            alignment: Alignment(
              //because left = -1 & right = 1, so the "width" = 2, and minValue = 1
                (widget.percent * 2) - 1,
                0),
            child: widget.thumb ?? _generateThumb(context, thumbSize))
      ],
    ));
  }

  Widget _generateSlider(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return MyNeumorphicProgress(
      duration: Duration.zero,
      percent: widget.percent,
      height: widget.height,
      style: ProgressStyle(
        disableDepth: widget.style.disableDepth,
        depth: widget.style.depth,
        border: widget.style.border,
        lightSource: widget.style.lightSource ?? theme.lightSource,
        borderRadius: widget.style.borderRadius,
        accent: widget.style.accent ?? theme.accentColor,
        variant: widget.style.variant ?? theme.variantColor,
      ),
    );
  }

  Widget _generateThumb(BuildContext context, double size) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Neumorphic(
      style: NeumorphicStyle(
        disableDepth: widget.style.disableDepth,
        shape: NeumorphicShape.concave,
        border: widget.style.thumbBorder,
        lightSource: widget.style.lightSource ?? theme.lightSource,
        color: widget.style.accent ?? theme.accentColor,
        boxShape: NeumorphicBoxShape.circle(),
      ),
      child: SizedBox(
        height: size,
        width: size,
      ),
    );
  }
}

class MyNeumorphicProgress extends StatefulWidget {
  final double _percent;
  final double height;
  final Duration duration;
  final ProgressStyle style;
  final Curve curve;

  const MyNeumorphicProgress(
      {Key key,
        double percent,
        this.height = 10,
        this.duration = const Duration(milliseconds: 300),
        this.style = const ProgressStyle(),
        this.curve = Curves.easeOutCubic})
      : this._percent = percent,
        super(key: key);

  @override
  _NeumorphicProgressState createState() => _NeumorphicProgressState();

  double get percent => _percent?.clamp(0, 1);

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is MyNeumorphicProgress &&
              runtimeType == other.runtimeType &&
              percent == other.percent &&
              height == other.height &&
              style == other.style &&
              curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      percent.hashCode ^ height.hashCode ^ style.hashCode ^ curve.hashCode;
}

class _NeumorphicProgressState extends State<MyNeumorphicProgress>
    with TickerProviderStateMixin {
  double oldPercent = 0;

  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: widget.percent, end: oldPercent)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(MyNeumorphicProgress oldWidget) {
    if (oldWidget.percent != widget.percent) {
      _controller.reset();
      oldPercent = oldWidget.percent;
      _animation = Tween<double>(begin: oldPercent, end: widget.percent)
          .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
      _controller.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      height: sliderHeight,
      child: SizedBox(
        width: sliderWidth,
        child: Neumorphic(
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
            color: backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(widget.style.borderRadius),
            disableDepth: widget.style.disableDepth,
            border: widget.style.border,
            depth: widget.style.depth,
            shape: NeumorphicShape.flat,
            shadowLightColor: theme.shadowLightColor,
            shadowDarkColor: theme.shadowDarkColor,
            lightSource: theme.lightSource
          ),
          child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _animation.value,
                  child: _GradientProgress(
                    borderRadius: widget.style.gradientBorderRadius ??
                        widget.style.borderRadius,
                    begin: widget.style.progressGradientStart ??
                        Alignment.centerLeft,
                    end: widget.style.progressGradientEnd ??
                        Alignment.centerRight,
                    colors: [
                      widget.style.variant ?? theme.variantColor,
                      widget.style.accent ?? theme.accentColor,
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}

/// A widget that shows progress along a line.
///
/// NeumorphicProgressIndeterminate is indeterminate.
///
/// You can provide a custom animation [duration]
///
/// Indeterminate progress indicators do not have a specific value at each point in time and instead indicate that progress is being made
/// without indicating how much progress remains. To create an indeterminate progress indicator, use a null value.
///
///  ```
///  NeumorphicProgressIndeterminate(
///      height: 15,
///  );
///
///  ```
///
class NeumorphicProgressIndeterminate extends StatefulWidget {
  final double height;
  final ProgressStyle style;
  final Duration duration;
  final bool reverse;
  final Curve curve;

  const NeumorphicProgressIndeterminate({
    Key key,
    this.height = 10,
    this.style = const ProgressStyle(),
    this.duration = const Duration(seconds: 3),
    this.reverse = false,
    this.curve = Curves.easeInOut,
  }) : super(key: key);

  @override
  createState() => _NeumorphicProgressIndeterminateState();

  @override
  // ignore: invalid_override_of_non_virtual_member
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is NeumorphicProgressIndeterminate &&
              runtimeType == other.runtimeType &&
              height == other.height &&
              style == other.style &&
              duration == other.duration &&
              reverse == other.reverse &&
              curve == other.curve;

  @override
  // ignore: invalid_override_of_non_virtual_member
  int get hashCode =>
      height.hashCode ^
      style.hashCode ^
      duration.hashCode ^
      reverse.hashCode ^
      curve.hashCode;
}

class _NeumorphicProgressIndeterminateState
    extends State<NeumorphicProgressIndeterminate>
    with TickerProviderStateMixin {
    AnimationController _controller;
    Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: widget.curve));
    _loop();
  }

  void _loop() async {
    try {
      await _controller
          .repeat(min: 0, max: 1, reverse: widget.reverse)
          .orCancel;
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicThemeData theme = NeumorphicTheme.currentTheme(context);

    return FractionallySizedBox(
      widthFactor: 1,
      child: SizedBox(
        height: widget.height,
        child: Neumorphic(
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(widget.style.borderRadius),
            lightSource: widget.style.lightSource ?? theme.lightSource,
            border: widget.style.border,
            disableDepth: widget.style.disableDepth,
            depth: widget.style.depth,
            shape: NeumorphicShape.flat,
            shadowLightColor: theme.shadowLightColor,
            shadowDarkColor: theme.shadowDarkColor
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedBuilder(
                animation: _animation,
                builder: (_, __) {
                  return Padding(
                    padding: EdgeInsets.only(
                        left: constraints.maxWidth * _animation.value),
                    child: FractionallySizedBox(
                      heightFactor: 1,
                      alignment: Alignment.centerLeft,
                      widthFactor: _animation.value,
                      child: _GradientProgress(
                        borderRadius: widget.style.gradientBorderRadius ??
                            widget.style.borderRadius,
                        begin: widget.style.progressGradientStart ??
                            Alignment.centerLeft,
                        end: widget.style.progressGradientEnd ??
                            Alignment.centerRight,
                        colors: [
                          widget.style.accent ?? theme.accentColor,
                          widget.style.variant ?? theme.variantColor
                        ],
                      ),
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}

class _GradientProgress extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: this.borderRadius,
        gradient: LinearGradient(
            begin: this.begin, end: this.end, colors: this.colors),
      ),
    );
  }

  const _GradientProgress({
    @required this.begin,
    @required this.end,
    @required this.colors,
    @required this.borderRadius,
  });
}
