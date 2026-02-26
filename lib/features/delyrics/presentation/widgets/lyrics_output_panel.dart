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
          child: SizedBox(
            height: 28,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                l10n.deduplicatedResult,
                style: theme.textTheme.labelMedium,
              ),
            ),
          ),
        ),
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeOut,
                child: hasOutput
                    ? SizedBox.expand(
                        key: const ValueKey('output'),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: SelectableText(
                            outputText,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.7,
                              color: theme.colorScheme.onSurface,
                              fontFamily: 'Pretendard',
                            ),
                          ),
                        ),
                      )
                    : Center(
                        key: const ValueKey('empty'),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_music_outlined,
                              size: 48,
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.12),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              l10n.outputPlaceholder,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
                                fontSize: 14,
                              ),
                            ),
                          ],
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
