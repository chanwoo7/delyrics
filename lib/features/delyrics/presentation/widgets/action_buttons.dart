import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PrimaryButton(
          label: l10n.convert,
          shortcutHint: Platform.isMacOS ? '⌘ Enter' : 'Ctrl Enter',
          onPressed: onConvert,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 10),
        _SecondaryButton(
          label: l10n.copyResult,
          icon: Icons.copy_rounded,
          onPressed: hasOutput ? onCopy : null,
          theme: theme,
        ),
        const SizedBox(width: 10),
        _SecondaryButton(
          label: l10n.reset,
          icon: Icons.refresh_rounded,
          onPressed: onReset,
          theme: theme,
          isDestructive: true,
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
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
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: SizedBox(
          height: 36,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.color,
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
                  widget.label,
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
                    widget.shortcutHint,
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
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
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
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isDestructive
        ? widget.theme.colorScheme.onSurface.withValues(alpha: 0.45)
        : widget.theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered && widget.onPressed != null ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        child: SizedBox(
          height: 36,
          child: TextButton.icon(
            onPressed: widget.onPressed,
            icon: Icon(widget.icon, size: 15, color: widget.onPressed != null ? color : color.withValues(alpha: 0.3)),
            label: Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: widget.onPressed != null ? color : color.withValues(alpha: 0.3),
              ),
            ),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
                side: BorderSide(
                  color: widget.theme.colorScheme.outline.withValues(alpha: widget.onPressed != null ? 0.4 : 0.2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
