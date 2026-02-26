import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class LyricsOutputPanel extends StatelessWidget {
  final String outputText;

  const LyricsOutputPanel({
    super.key,
    required this.outputText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final hasOutput = outputText.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            l10n.deduplicatedResult,
            style: theme.textTheme.labelMedium,
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: hasOutput
                  ? theme.scaffoldBackgroundColor
                  : theme.colorScheme.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: hasOutput
                    ? theme.colorScheme.secondary.withValues(alpha: 0.25)
                    : theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
              boxShadow: hasOutput
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.secondary.withValues(alpha: 0.06),
                        blurRadius: 12,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: hasOutput
                  ? SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: SelectableText(
                        outputText,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.7,
                          color: theme.colorScheme.onSurface,
                          fontFamily: '.AppleSystemUIFont',
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        l10n.outputPlaceholder,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
                          fontSize: 14,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
