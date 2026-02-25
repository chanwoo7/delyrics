import 'package:flutter/material.dart';
import '../../domain/models/dedupe_result.dart';

class StatusBar extends StatelessWidget {
  final DedupeResult? result;

  const StatusBar({
    super.key,
    this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (result == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatusItem(
            label: '입력',
            value: '${result!.inputLineCount}줄',
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          _Divider(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          _StatusItem(
            label: '출력',
            value: '${result!.outputLineCount}줄',
            color: theme.colorScheme.secondary,
          ),
          _Divider(color: theme.colorScheme.outline.withValues(alpha: 0.3)),
          _StatusItem(
            label: '중복 제거',
            value: '${result!.removedDuplicateCount}줄',
            color: result!.removedDuplicateCount > 0
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatusItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
            letterSpacing: 0.1,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  final Color color;

  const _Divider({required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: 1,
        height: 14,
        color: color,
      ),
    );
  }
}
