import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class LyricsInputPanel extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const LyricsInputPanel({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            l10n.originalLyrics,
            style: theme.textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.7,
                  color: theme.colorScheme.onSurface,
                  fontFamily: 'Pretendard',
                ),
                decoration: InputDecoration(
                  hintText: l10n.inputPlaceholder,
                  hintStyle: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    fontSize: 14,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  border: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
