import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mqttdashboard/globals.dart';

@immutable
class CustomNeumorphicSlider extends StatefulWidget {
  final SliderStyle style;
  final double min;
  final double value;
  final double max;
  final double height;
  final double width;
  final NeumorphicSliderListener onChanged;
  final NeumorphicSliderListener onChangeStart;
  final NeumorphicSliderListener onChangeEnd;

  final Widget thumb;
  final double sliderHeight;

  CustomNeumorphicSlider({
    Key key,
    this.style = const SliderStyle(),
    this.min = 0,
    this.value = 0,
    this.max = 10,
    this.height,
    this.width,
    this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.thumb,
    this.sliderHeight,
  });

  double get percent => (((value.clamp(min, max)) - min) / ((max - min)));

  @override
  createState() => _CustomNeumorphicSliderState();
}

class _CustomNeumorphicSliderState extends State<CustomNeumorphicSlider> {
  @override
  Widget build(BuildContext context) {
    if(widget.width == null || widget.height == null) return buildWidget(context);
    else return SizedBox(width: widget.width, height: widget.height, child: buildWidget(context),);
  }

  Widget buildWidget(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onPanUpdate: (DragUpdateDetails details) {
          final tapPos = details.localPosition;
          final newPercent = tapPos.dy / constraints.maxHeight;
          final newValue =
          ((widget.max - (widget.max - widget.min) * newPercent))
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
            shadowLightColor: theme.shadowLightColor,
            shadowDarkColor: theme.shadowDarkColor
        ),
        child: _generateSlider(context),
        );
  }

  Widget _generateSlider(BuildContext context) {
    return CustomNeumorphicProgress(
      percent: widget.percent,
      height: widget.height,
      borderRadius: widget.style.borderRadius,
    );
  }
}

class CustomNeumorphicProgress extends StatefulWidget {
  final double height;
  final BorderRadius borderRadius;
  final double percent;

  CustomNeumorphicProgress({this.height = 10, this.borderRadius = BorderRadius.zero, this.percent = 0});

  @override
  State<StatefulWidget> createState() {
    return _SliderState();
  }

}

class _SliderState extends State<CustomNeumorphicProgress> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Duration duration = const Duration(milliseconds: 30);
  Curve curve = Curves.easeInOut;
  BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10));
  double oldPercent = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _animation = Tween<double>(begin: widget.percent, end: oldPercent)
        .animate(_controller);
  }

  @override
  void didUpdateWidget(CustomNeumorphicProgress oldWidget) {
    if (oldWidget.percent != widget.percent) {
      _controller.reset();
      oldPercent = oldWidget.percent;
      _animation = Tween<double>(begin: oldPercent, end: widget.percent)
          .animate(CurvedAnimation(parent: _controller, curve: curve));
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

    return Neumorphic(
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(borderRadius),
              lightSource: theme.lightSource,
              depth: theme.depth,
              shape: NeumorphicShape.flat,
              shadowLightColor: theme.shadowLightColor,
              shadowDarkColor: theme.shadowDarkColor
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return AnimatedBuilder(
                animation: _animation,
                builder: (_, __) {
                  return FractionallySizedBox(
                      heightFactor: _animation.value,
                      alignment: Alignment.bottomCenter,
                      child: _GradientProgress(
                        borderRadius: BorderRadius.zero,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.accentColor,
                          theme.variantColor
                        ],
                      ),
                  );
                });
          }),
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