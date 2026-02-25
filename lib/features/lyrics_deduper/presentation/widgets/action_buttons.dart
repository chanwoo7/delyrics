import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onConvert;
  final VoidCallback onCopy;
  final VoidCallback onReset;
  final bool hasOutput;

  const ActionButtons({
    super.key,
    required this.onConvert,
    required this.onCopy,
    required this.onReset,
    required this.hasOutput,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // 변환 버튼 (Primary)
        _PrimaryButton(
          label: '변환',
          shortcutHint: '⌘ Enter',
          onPressed: onConvert,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 10),
        // 결과 복사 버튼
        _SecondaryButton(
          label: '결과 복사',
          icon: Icons.copy_rounded,
          onPressed: hasOutput ? onCopy : null,
          theme: theme,
        ),
        const Spacer(),
        // 초기화 버튼
        _SecondaryButton(
          label: '초기화',
          icon: Icons.refresh_rounded,
          onPressed: onReset,
          theme: theme,
          isDestructive: true,
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final String shortcutHint;
  final VoidCallback onPressed;
  final Color color;

  const _PrimaryButton({
    required this.label,
    required this.shortcutHint,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                shortcutHint,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final ThemeData theme;
  final bool isDestructive;

  const _SecondaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.theme,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? theme.colorScheme.onSurface.withValues(alpha: 0.45)
        : theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return SizedBox(
      height: 36,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 15, color: onPressed != null ? color : color.withValues(alpha: 0.3)),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: onPressed != null ? color : color.withValues(alpha: 0.3),
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
            side: BorderSide(
              color: theme.colorScheme.outline.withValues(alpha: onPressed != null ? 0.4 : 0.2),
            ),
          ),
        ),
      ),
    );
  }
}
