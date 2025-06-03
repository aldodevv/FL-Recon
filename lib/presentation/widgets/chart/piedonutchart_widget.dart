import 'dart:math' as math;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PiedonutchartWidget extends StatelessWidget {
  final double size;
  final List<PieChartSectionData> sections;
  final String centerText;
  final Function(int, Offset)? onSectionTapped;

  const PiedonutchartWidget({
    super.key,
    this.size = 300,
    required this.sections,
    this.centerText = '',
    this.onSectionTapped,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 60,
      height: size + 60,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sections:
                  sections
                      .map((e) => e.copyWith(radius: math.max(30, size * 0.2)))
                      .toList(),
              centerSpaceRadius:size * 0.3,
              titleSunbeamLayout: true,
              sectionsSpace: 1,
              startDegreeOffset: -90,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {
                  if (event is FlTapUpEvent) {
                    final index =
                        response?.touchedSection?.touchedSectionIndex ?? -1;
                    if (index >= 0 && index < sections.length) {
                      final section = sections[index];
                      final tooltipText =
                          section.title ??
                          'Section ${index + 1}: ${section.value.toStringAsFixed(1)}%';

                      final renderBox = context.findRenderObject() as RenderBox;
                      final globalPosition = renderBox.localToGlobal(
                        event.localPosition,
                      );

                      ResponsiveTooltip.show(
                        context: context,
                        position: globalPosition,
                        text: tooltipText,
                      );
                      onSectionTapped?.call(index, event.localPosition);
                    } else {
                      print('No section tapped');
                    }
                  }
                },
              ),
            ),
          ),

          // Center text overlay
          if (centerText.isNotEmpty)
            Positioned.fill(
              child: Center(
                child: Text(
                  centerText,
                  style: TextStyle(
                    fontSize: size * 0.08,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ResponsiveTooltip {
  static OverlayEntry? _overlayEntry;
  static AnimationController? _animationController;

  static void show({
    required BuildContext context,
    required Offset position,
    required String text,
    Duration duration = const Duration(seconds: 3),
  }) {
    hide();

    final overlay = Overlay.of(context);
    final screenSize = MediaQuery.of(context).size;

    const tooltipWidth = 200.0;
    const tooltipHeight = 50.0;
    const padding = 16.0;
    const arrowSize = 8.0;

    double left = position.dx - tooltipWidth / 2;
    double top = position.dy - tooltipHeight - padding - arrowSize;
    bool showArrowBottom = true;

    // Boundary checks
    if (left < padding) {
      left = padding;
    } else if (left + tooltipWidth > screenSize.width - padding) {
      left = screenSize.width - tooltipWidth - padding;
    }

    if (top < padding) {
      top = position.dy + padding + arrowSize;
      showArrowBottom = false;
    }

    _overlayEntry = OverlayEntry(
      builder:
          (context) => _TooltipOverlay(
            left: left,
            top: top,
            text: text,
            width: tooltipWidth,
            showArrowBottom: showArrowBottom,
            arrowOffset: position.dx - left,
          ),
    );

    overlay.insert(_overlayEntry!);

    if (duration != Duration.zero) {
      Future.delayed(duration, hide);
    }
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _TooltipOverlay extends StatefulWidget {
  final double left;
  final double top;
  final String text;
  final double width;
  final bool showArrowBottom;
  final double arrowOffset;

  const _TooltipOverlay({
    required this.left,
    required this.top,
    required this.text,
    required this.width,
    required this.showArrowBottom,
    required this.arrowOffset,
  });

  @override
  State<_TooltipOverlay> createState() => _TooltipOverlayState();
}

class _TooltipOverlayState extends State<_TooltipOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _controller,
          builder:
              (context, child) => Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: _TooltipContent(
                    text: widget.text,
                    width: widget.width,
                    showArrowBottom: widget.showArrowBottom,
                    arrowOffset: widget.arrowOffset,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class _TooltipContent extends StatelessWidget {
  final String text;
  final double width;
  final bool showArrowBottom;
  final double arrowOffset;

  const _TooltipContent({
    required this.text,
    required this.width,
    required this.showArrowBottom,
    required this.arrowOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!showArrowBottom) _buildArrow(true),
        Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (showArrowBottom) _buildArrow(false),
      ],
    );
  }

  Widget _buildArrow(bool pointUp) {
    return CustomPaint(
      size: const Size(16, 8),
      painter: _ArrowPainter(pointUp: pointUp),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final bool pointUp;

  _ArrowPainter({required this.pointUp});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black87
          ..style = PaintingStyle.fill;

    final path = Path();
    if (pointUp) {
      path.moveTo(size.width / 2, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
