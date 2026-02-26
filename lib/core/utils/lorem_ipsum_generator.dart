import 'dart:math';

class LoremIpsumGenerator {
  LoremIpsumGenerator._();

  static final List<String> _words = [
    'lorem',
    'ipsum',
    'dolor',
    'sit',
    'amet',
    'consectetur',
    'adipiscing',
    'elit',
    'sed',
    'do',
    'eiusmod',
    'tempor',
    'incididunt',
    'ut',
    'labore',
    'et',
    'dolore',
    'magna',
    'aliqua',
  ];

  static final Random _random = Random();

  static String _capitalize(String word) {
    return word[0].toUpperCase() + word.substring(1);
  }

  static String _generateSentence({int minWords = 6, int maxWords = 12}) {
    int wordCount = minWords + _random.nextInt(maxWords - minWords + 1);
    List<String> sentence = List.generate(wordCount, (_) {
      return _words[_random.nextInt(_words.length)];
    });
    String result = '${_capitalize(sentence.join(' '))}.';
    return result;
  }

  static String generate({int paragraphs = 1, int sentencesPerParagraph = 4}) {
    List<String> result = [];

    for (int i = 0; i < paragraphs; i++) {
      List<String> paragraph = List.generate(
        sentencesPerParagraph,
        (_) => _generateSentence(),
      );
      result.add(paragraph.join(' '));
    }

    return result.join('\n\n');
  }
}
