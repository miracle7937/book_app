class FoulWordChecker {
  bool check(
    String sentence,
    List<String> foulWord,
  ) {
    List<String> sentenceWords = sentence.toLowerCase().split(' ');
    List<String> lowerCaseWords =
        foulWord.map((word) => word.toLowerCase()).toList();

    bool containsWord =
        sentenceWords.any((word) => lowerCaseWords.contains(word));

    if (containsWord) {
      return true;
    } else {
      return false;
    }
  }
}
