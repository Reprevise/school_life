import 'package:flutter/material.dart';

import '../../../../models/time_block.dart';

class ScheduleField extends StatelessWidget {
  const ScheduleField({
    Key? key,
    required this.tBlock,
    required this.onRemove,
    required this.onEdit,
  }) : super(key: key);

  final TimeBlock tBlock;
  final VoidCallback onRemove;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              _InfoField(title: 'Day', data: tBlock.day),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: onEdit,
                color: Colors.black,
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onRemove,
                color: Colors.red,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _InfoField(
                flex: 6,
                title: 'Start time',
                data: tBlock.startTime.format(context),
              ),
              const Spacer(flex: 1),
              _InfoField(
                title: 'End time',
                flex: 6,
                data: tBlock.endTime.format(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  final String title;
  final String data;
  final int flex;

  const _InfoField({
    Key? key,
    required this.title,
    required this.data,
    this.flex = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              title,
              style: const TextStyle(color: Color(0xFF313131)),
            ),
          ),
          Container(
            // constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                data,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
