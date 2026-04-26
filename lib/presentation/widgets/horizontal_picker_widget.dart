import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HorizontalPicker extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final ValueChanged<int> onChanged;

  const HorizontalPicker({
    super.key,
    required this.min,
    required this.max,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<HorizontalPicker> createState() => _HorizontalPickerState();
}

class _HorizontalPickerState extends State<HorizontalPicker> {
  late final ScrollController _controller;
  late int selectedValue;

  final double itemWidth = 40;
  double? _centerPadding;

  @override
  void initState() {
    super.initState();

    selectedValue = widget.initialValue.clamp(widget.min, widget.max);

    _controller = ScrollController();
    _controller.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_controller.hasClients) return;
      final offset = (selectedValue - widget.min) * itemWidth;
      _controller.jumpTo(offset);
    });
  }

  @override
  void didUpdateWidget(covariant HorizontalPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue != widget.initialValue) {
      selectedValue = widget.initialValue.clamp(widget.min, widget.max);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_controller.hasClients) return;
        _controller.jumpTo((selectedValue - widget.min) * itemWidth);
      });
    }
  }

  void _onScroll() {
    final value = _valueFromOffset(_controller.offset);

    if (value != selectedValue) {
      setState(() {
        selectedValue = value;
      });
      widget.onChanged(value);
    }
  }

  int _valueFromOffset(double offset) {
    final index = (offset / itemWidth).round();
    final value = widget.min + index;
    return value.clamp(widget.min, widget.max);
  }

  void _snapToNearest() {
    if (!_controller.hasClients) return;

    final targetIndex = (_controller.offset / itemWidth).round();
    final targetOffset = targetIndex * itemWidth;

    _controller.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _centerPadding = (constraints.maxWidth / 2) - (itemWidth / 2);
        if (_centerPadding! < 0) {
          _centerPadding = 0;
        }

        return Column(
          children: [
            Text(
              selectedValue.toString(),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.textOnMain,
              ),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 80,
              child: NotificationListener<ScrollEndNotification>(
                onNotification: (_) {
                  _snapToNearest();
                  return false;
                },
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: _centerPadding!,
                  ),
                  itemCount: widget.max - widget.min + 1,
                  itemBuilder: (context, index) {
                    final value = widget.min + index;
                    final isSelected = value == selectedValue;
                    final isMajorTick = value % 10 == 0;

                    return SizedBox(
                      width: itemWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 2,
                            height: isMajorTick ? 24 : 12,
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withOpacity(0.75),
                          ),
                          const SizedBox(height: 4),
                          if (isMajorTick)
                            Text(
                              value.toString(),
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.95),
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Unit',
              style: TextStyle(
                color: Colors.white.withOpacity(0.85),
                fontSize: 12,
              ),
            ),
          ],
        );
      },
    );
  }
}