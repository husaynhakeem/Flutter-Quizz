import 'package:flutter/material.dart';
import '../ui/answer_button.dart';
import '../ui/question_text.dart';
import '../ui/correct_wrong_overlay.dart';
import '../models/Quiz.dart';
import '../models/Question.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new QuizPageState();
}

class QuizPageState extends State {

  Quiz _quiz = new Quiz(<Question>[
    new Question("Elon Musk is human", false),
    new Question("Pizzas are healthy", false),
    new Question("Flutter is awesome", true)
  ]);

  Question _currentQuestion;
  String _currentQuestionText;
  int _currentQuestionNumber;
  bool _currentAnswerIsCorrect;

  bool _shouldDisplayOverlay = false;

  @override
  void initState() {
    super.initState();
    _currentQuestion = _quiz.nextQuestion;
    _currentQuestionText = _currentQuestion.question;
    _currentQuestionNumber = _quiz.questionNumber;
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => _onAnswerTapped(true)),
            new QuestionText(_currentQuestionNumber, _currentQuestionText),
            new AnswerButton(false, () => _onAnswerTapped(false))
          ],
        ),
        _shouldDisplayOverlay
            ? new CorrectWrongOverlay(
            _currentAnswerIsCorrect, () => _onPostAnswerOverlayTapped())
            : new Container()
      ],
    );
  }

  void _onAnswerTapped(bool answer) {
    _currentAnswerIsCorrect = _currentQuestion.answer == answer;
    _quiz.answer(_currentAnswerIsCorrect);
    this.setState(() {
      _shouldDisplayOverlay = true;
    });
  }

  void _onPostAnswerOverlayTapped() {
    _currentQuestion = _quiz.nextQuestion;
    if (_currentQuestion == null) {
      _showScorePage();
    } else {
      _showNextQuestion();
    }
  }

  void _showScorePage() {
    Navigator.of(context)
        .pushAndRemoveUntil(new MaterialPageRoute(
        builder: (BuildContext context) =>
        new ScorePage(_quiz.score, _quiz.numberOfQuestions)), (Route route) =>
    route == null);
  }

  void _showNextQuestion() {
    _currentQuestionText = _currentQuestion.question;
    _currentQuestionNumber = _quiz.questionNumber;
    this.setState(() {
      _shouldDisplayOverlay = false;
    });
  }
}