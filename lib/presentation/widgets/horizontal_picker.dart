import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HorizontalPicker extends StatefulWidget {
  final int min;
  final int max;
  final int initialValue;
  final Function(int) onChanged;

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
  late ScrollController _controller;
  int selectedValue = 0;

  final double itemWidth = 40;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;

    _controller = ScrollController(
      initialScrollOffset: (selectedValue - widget.min) * itemWidth,
    );

    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final index = (_controller.offset / itemWidth).round();
    final value = widget.min + index;

    if (value != selectedValue && value >= widget.min && value <= widget.max) {
      setState(() {
        selectedValue = value;
      });

      widget.onChanged(value);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          selectedValue.toString(),
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 60,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: widget.max - widget.min + 1,
            itemBuilder: (context, index) {
              final value = widget.min + index;

              return SizedBox(
                width: itemWidth,
                child: Column(
                  children: [
                    Container(
                      width: 2,
                      height: value % 10 == 0 ? 20 : 10,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    if (value % 10 == 0)
                      Text(
                        value.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}