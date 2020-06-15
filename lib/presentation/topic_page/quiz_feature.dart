import 'package:basetalk/domain/entities/quiz_answer.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/entities/quiz_question.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/quiz_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFeature extends StatefulWidget {
  final QuizData quizData;
  final QuizViewModel quizViewModel = QuizViewModel();

  QuizFeature(this.quizData);

  @override
  _QuizFeatureState createState() => _QuizFeatureState();
}

class _QuizFeatureState extends State<QuizFeature> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> questionWidgets = List();
    Widget firstQuizPage = Column(
      children: [
        Text(
          "Zeit für ein Quiz",
          style: TextStyle(
            fontSize: 36,
            decoration: TextDecoration.underline,
          ),
        ),
        Spacer(),
        Text(
          "Wie lauten die folgenden Redewendungen?",
          style: TextStyle(fontSize: 36),
          textAlign: TextAlign.center,
        ),
        Spacer(),
      ],
    );
    questionWidgets.add(firstQuizPage);
    for (QuizQuestion quizQuestion in widget.quizData.questions) {
      questionWidgets.add(quizContainer(quizQuestion));
    }

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
                child: PageView(
                    physics: new NeverScrollableScrollPhysics(),
                    controller: _controller,
                    children: questionWidgets)),
            Provider.of<QuizViewModel>(context).isNextButtonVisible
                ? FlatButton(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Weiter",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    color: Colors.grey[600],
                    onPressed: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear);
                      Provider.of<QuizViewModel>(context, listen: false)
                          .setNextButtonVisibility(false);
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget quizContainer(QuizQuestion quizQuestion) {
    List<Widget> buttons = List();
    for (QuizAnswer quizAnswer in quizQuestion.answers) {
      Color activatedColor = Colors.red;
      VoidCallback onPressed = () {
        Provider.of<QuizViewModel>(context, listen: false)
            .setNextButtonVisibility(false);
      };
      if (quizAnswer == quizQuestion.correctAnswer) {
        activatedColor = Colors.green;
        onPressed = () {
          Provider.of<QuizViewModel>(context, listen: false)
              .setNextButtonVisibility(true);
        };
      }
      buttons.add(QuizButton(activatedColor, quizAnswer.answer, onPressed));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          quizQuestion.question,
          style: TextStyle(fontSize: 36),
        ),
        SizedBox(height: 40),
        Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: buttons
                .map((w) => Container(child: w, padding: EdgeInsets.all(6)))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class QuizButton extends StatefulWidget {
  final Color activatedColor;
  final String buttonText;
  final VoidCallback onPressed;

  QuizButton(this.activatedColor, this.buttonText, this.onPressed);

  @override
  _QuizButtonState createState() => _QuizButtonState();
}

class _QuizButtonState extends State<QuizButton> {
  bool pressed = false;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 48,
      child: Container(
        width: double.infinity,
        height: 60,
        child: FlatButton(
          child: Text(
            widget.buttonText,
            style: TextStyle(fontSize: 30),
          ),
          color: pressed ? widget.activatedColor : primary_green,
          onPressed: () {
            setState(() {
              pressed = true;
            });
            widget.onPressed();
          },
        ),
      ),
    );
  }
}
