class DedupeResult {
  final String outputText;
  final int inputLineCount;
  final int outputLineCount;
  final int removedDuplicateCount;
  final Set<int> duplicateLineIndices;

  const DedupeResult({
    required this.outputText,
    required this.inputLineCount,
    required this.outputLineCount,
    required this.removedDuplicateCount,
    this.duplicateLineIndices = const {},
  });

  const DedupeResult.empty()
      : outputText = '',
        inputLineCount = 0,
        outputLineCount = 0,
        removedDuplicateCount = 0,
        duplicateLineIndices = const {};
}
