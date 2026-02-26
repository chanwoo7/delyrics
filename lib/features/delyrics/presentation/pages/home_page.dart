import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/dedupe_result.dart';
import '../../domain/services/lyrics_dedupe_service.dart';
import '../widgets/lyrics_input_panel.dart';
import '../widgets/lyrics_output_panel.dart';
import '../widgets/action_buttons.dart';
import '../widgets/status_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inputController = HighlightingTextEditingController();
  final _inputFocusNode = FocusNode();
  final _dedupeService = LyricsDedupeService();

  DedupeResult? _result;
  String _outputText = '';
  String _textAtConversion = '';

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inputFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _inputController.removeListener(_onTextChanged);
    _inputController.dispose();
    _inputFocusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (_result != null && _inputController.text != _textAtConversion) {
      setState(() {
        _result = null;
        _outputText = '';
        _inputController.clearHighlights();
      });
    }
  }

  void _convert() {
    final result = _dedupeService.deduplicate(_inputController.text);
    _textAtConversion = _inputController.text;
    setState(() {
      _result = result;
      _outputText = result.outputText;
      _inputController.setHighlightState(
        duplicateLineIndices: result.duplicateLineIndices,
        highlightColor: Theme.of(context).colorScheme.error.withValues(alpha: 0.5),
      );
    });
  }

  void _copyResult() {
    if (_outputText.isEmpty) return;
    final l10n = AppLocalizations.of(context)!;
    Clipboard.setData(ClipboardData(text: _outputText));
    final isDark = Theme.of(context).brightness == Brightness.dark;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          l10n.copiedToClipboard,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? const Color(0xFFDDE4EE) : Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        width: 260,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: isDark
            ? const Color(0xFF3A4A60)
            : const Color(0xFF1E2A3A),
      ),
    );
  }

  void _onFileLoaded(String content) {
    setState(() {
      _inputController.clearHighlights();
      _inputController.text = content;
      _result = null;
      _outputText = '';
      _textAtConversion = '';
    });
  }

  void _reset() {
    setState(() {
      _inputController.clearHighlights();
      _inputController.clear();
      _result = null;
      _outputText = '';
      _textAtConversion = '';
    });
    _inputFocusNode.requestFocus();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter &&
        HardwareKeyboard.instance.isMetaPressed) {
      _convert();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        onKeyEvent: _handleKeyEvent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              // 헤더
              Row(
                children: [
                  Text(
                    'Delyrics',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  _LocaleToggleButton(),
                  const SizedBox(width: 8),
                  _ThemeToggleButton(),
                ],
              ),
              const SizedBox(height: 20),

              // 좌우 분할 패널
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 왼쪽: 입력
                    Expanded(
                      child: LyricsInputPanel(
                        controller: _inputController,
                        focusNode: _inputFocusNode,
                        onFileLoaded: _onFileLoaded,
                      ),
                    ),
                    const SizedBox(width: 20),
                    // 오른쪽: 출력
                    Expanded(
                      child: LyricsOutputPanel(
                        outputText: _outputText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 액션 버튼 + 상태 바
              Row(
                children: [
                  ActionButtons(
                    onConvert: _convert,
                    onCopy: _copyResult,
                    onReset: _reset,
                    hasOutput: _outputText.isNotEmpty,
                  ),
                  const Spacer(),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _result != null
                        ? StatusBar(key: const ValueKey('status'), result: _result)
                        : const SizedBox.shrink(key: ValueKey('empty')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LocaleToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = LocaleNotifier.of(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final String label;
    final String tooltip;
    if (notifier.locale == null) {
      label = 'SYS';
      tooltip = l10n.localeSystem;
    } else if (notifier.locale!.languageCode == 'en') {
      label = 'EN';
      tooltip = l10n.localeEnglish;
    } else {
      label = 'KO';
      tooltip = l10n.localeKorean;
    }

    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 34,
        height: 34,
        child: IconButton(
          onPressed: notifier.onToggle,
          icon: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          padding: EdgeInsets.zero,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notifier = ThemeModeNotifier.of(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final IconData icon;
    final String tooltip;
    switch (notifier.themeMode) {
      case ThemeMode.system:
        icon = Icons.brightness_auto_rounded;
        tooltip = l10n.themeSystem;
      case ThemeMode.light:
        icon = Icons.light_mode_rounded;
        tooltip = l10n.themeLight;
      case ThemeMode.dark:
        icon = Icons.dark_mode_rounded;
        tooltip = l10n.themeDark;
    }

    return Tooltip(
      message: tooltip,
      child: SizedBox(
        width: 34,
        height: 34,
        child: IconButton(
          onPressed: notifier.onToggle,
          icon: Icon(icon, size: 18),
          color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          padding: EdgeInsets.zero,
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
              side: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
