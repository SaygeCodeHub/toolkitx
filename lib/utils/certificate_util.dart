class CertificateUtil {
  List<Map<String, String>> answerList = [
    {"answer": "Strongly Disagree", "value": "1"},
    {"answer": "Disagree", "value": "2"},
    {"answer": "Neutral", "value": "3"},
    {"answer": "Agree", "value": "4"},
    {"answer": "Strongly Agree", "value": "5"},
  ];

  String feedbackAnswerToText(String answer) {
    switch (answer) {
      case '1':
        return 'Strongly Disagree';
      case '2':
        return 'Disagree';
      case '3':
        return 'Neutral';
      case '4':
        return 'Agree';
      case '5':
        return 'Strongly Agree';
      default:
        return answer;
    }
  }
}
