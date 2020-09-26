import 'package:basetalk/domain/entities/quiz_answer.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/entities/quiz_question.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/quiz_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuizFeature extends StatefulWidget {
  QuizFeature();

  @override
  _QuizFeatureState createState() => _QuizFeatureState();
}

class _QuizFeatureState extends State<QuizFeature> {
  QuizViewModel quizViewModel;

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<QuizData> _futureQuizData;

  @override
  initState() {
    super.initState();
    this.quizViewModel = Provider.of<QuizViewModel>(context, listen: false);
    _futureQuizData =
        Provider.of<QuizViewModel>(context, listen: false).getQuizData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> questionWidgets = List();
    Widget firstQuizPage = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          child: Text(
            "Zeit für ein Quiz",
            style: TextStyle(
              fontSize: 36,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          "Wie lauten die folgenden Redewendungen?",
          style: TextStyle(fontSize: 36),
          textAlign: TextAlign.center,
        ),
      ],
    );

    Widget closeButton = FlatButton(
      height: 70,
      minWidth: 300,
      child: Text(
        "Quiz beenden",
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
      color: Colors.grey[600],
      onPressed: () {
        Provider.of<TopicPageViewModel>(context, listen: false)
            .toggleFeatureVisible();
      },
    );

    Widget lastQuizPage = Column(
      children: [
        Text(
          "Zeit für ein Quiz",
          style: TextStyle(
            fontSize: 36,
            decoration: TextDecoration.underline,
          ),
        ),
        Spacer(),
        closeButton,
        Spacer(),
      ],
    );
    questionWidgets.add(firstQuizPage);

    Widget nextButton = FlatButton(
      height: 70,
      minWidth: 300,
      child: Text(
        "Weiter",
        style: TextStyle(fontSize: 28, color: Colors.white),
      ),
      color: Colors.grey[600],
      onPressed: () {
        _controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
        Provider.of<QuizViewModel>(context, listen: false)
            .setNextButtonVisibility(false);
      },
    );

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey[200],
        child: FutureBuilder(
          future: _futureQuizData,
          builder: (BuildContext context, AsyncSnapshot<QuizData> snapshot) {
            if (snapshot.hasData) {
              for (QuizQuestion quizQuestion in snapshot.data.questions) {
                questionWidgets.add(quizContainer(quizQuestion));
              }
              questionWidgets.add(lastQuizPage);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: PageView.builder(
                      itemCount: questionWidgets.length,
                      physics: new NeverScrollableScrollPhysics(),
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return questionWidgets[index];
                      },
                    ),
                  ),
                  Provider
                      .of<QuizViewModel>(context)
                      .isNextButtonVisible
                      ? nextButton
                      : Container(
                    height: 70,
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
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

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              quizQuestion.question,
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(height: 18),
            Expanded(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(14),
                  child: Column(
                    children: buttons
                        .map((w) => Expanded(child: w))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
    return Padding(
      padding: EdgeInsets.all(5),
      child: ButtonTheme(
        minWidth: 48,
        child: Container(
          width: double.infinity,
          height: 55,
          child: FlatButton(
            child: Text(
              widget.buttonText,
              style: TextStyle(fontSize: 28),
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
      ),
    );
  }
}
