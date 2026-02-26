import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class HighlightingTextEditingController extends TextEditingController {
  Set<int> _duplicateLineIndices = {};
  Color _highlightColor = Colors.red;

  void setHighlightState({
    required Set<int> duplicateLineIndices,
    required Color highlightColor,
  }) {
    _duplicateLineIndices = duplicateLineIndices;
    _highlightColor = highlightColor;
    notifyListeners();
  }

  void clearHighlights() {
    _duplicateLineIndices = {};
    notifyListeners();
  }

  bool get hasHighlights => _duplicateLineIndices.isNotEmpty;

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    if (_duplicateLineIndices.isEmpty) {
      return super.buildTextSpan(
        context: context,
        style: style,
        withComposing: withComposing,
      );
    }

    final lines = text.split('\n');
    final spans = <TextSpan>[];

    for (int i = 0; i < lines.length; i++) {
      if (i > 0) spans.add(const TextSpan(text: '\n'));

      final isDuplicate = _duplicateLineIndices.contains(i);
      spans.add(TextSpan(
        text: lines[i],
        style: isDuplicate
            ? style?.copyWith(
                color: _highlightColor,
                decoration: TextDecoration.lineThrough,
                decorationColor: _highlightColor,
              )
            : style,
      ));
    }

    return TextSpan(style: style, children: spans);
  }
}

class LyricsInputPanel extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onFileLoaded;

  const LyricsInputPanel({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onFileLoaded,
  });

  @override
  State<LyricsInputPanel> createState() => _LyricsInputPanelState();
}

class _LyricsInputPanelState extends State<LyricsInputPanel> {
  bool _isDragOver = false;

  Future<void> _handleDrop(DropDoneDetails details) async {
    setState(() => _isDragOver = false);
    for (final file in details.files) {
      final path = file.path;
      if (path.endsWith('.txt') || path.endsWith('.lrc')) {
        final content = await File(path).readAsString();
        widget.onFileLoaded(content);
        return;
      }
    }
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.unsupportedFileType, style: const TextStyle(fontSize: 13)),
          behavior: SnackBarBehavior.floating,
          width: 320,
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt', 'lrc'],
    );
    if (result != null && result.files.single.path != null) {
      final content = await File(result.files.single.path!).readAsString();
      widget.onFileLoaded(content);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Row(
            children: [
              Text(
                l10n.originalLyrics,
                style: theme.textTheme.labelMedium,
              ),
              const Spacer(),
              Tooltip(
                message: l10n.openFile,
                child: SizedBox(
                  width: 28,
                  height: 28,
                  child: IconButton(
                    onPressed: _pickFile,
                    icon: Icon(
                      Icons.folder_open_rounded,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                    padding: EdgeInsets.zero,
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                          color: theme.colorScheme.outline.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: DropTarget(
            onDragEntered: (_) => setState(() => _isDragOver = true),
            onDragExited: (_) => setState(() => _isDragOver = false),
            onDragDone: _handleDrop,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _isDragOver
                      ? theme.colorScheme.primary
                      : theme.colorScheme.outline.withValues(alpha: 0.5),
                  width: _isDragOver ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _isDragOver
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.03),
                    blurRadius: _isDragOver ? 12 : 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: TextField(
                  controller: widget.controller,
                  focusNode: widget.focusNode,
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
        ),
      ],
    );
  }
}
