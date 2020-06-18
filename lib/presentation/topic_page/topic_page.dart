import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:basetalk/domain/entities/feature.dart';
import 'package:basetalk/domain/entities/feature_type.dart';
import 'package:basetalk/domain/entities/page_number.dart';
import 'package:basetalk/domain/entities/quiz_answer.dart';
import 'package:basetalk/domain/entities/quiz_data.dart';
import 'package:basetalk/domain/entities/quiz_question.dart';
import 'package:basetalk/presentation/colors.dart';
import 'package:basetalk/presentation/topic_page/impulse_bar.dart';
import 'package:basetalk/presentation/topic_page/quiz_feature.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/impulse_bar_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/quiz_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_page_view_model.dart';
import 'package:basetalk/presentation/topic_page/viewmodel/topic_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopicPage extends StatefulWidget {
  static const routeName = "/topicPage";

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  double rowDividerHeight;
  double iconSize;
  double audioButtonSize;

  TopicViewModel topicViewModel;
  TopicPageViewModel topicPageViewModel;
  ImpulseBarViewModel impulseBarViewModel;

  initLayoutSizes() {
    double deviceHeight = MediaQuery.of(context).size.height;
    double heightFactor = deviceHeight / 100;
    iconSize = 17 * heightFactor;
    audioButtonSize = 12 * heightFactor;
    rowDividerHeight = 5 * heightFactor;
  }

  initProviders(BuildContext context) {
    topicViewModel = Provider.of<TopicViewModel>(context);
    topicPageViewModel = Provider.of<TopicPageViewModel>(context);
    var pageNumber = topicPageViewModel.pageNumber;
    var impulses = topicViewModel.getImpulses(pageNumber);
    impulseBarViewModel = ImpulseBarViewModel(impulses);
  }



  @override
  Widget build(BuildContext context) {
    initLayoutSizes();
    initProviders(context);

    return Container(
      color: topicPageViewModel.isFeatureVisible
          ? Colors.black.withOpacity(0.3)
          : Colors.black.withOpacity(0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(height: rowDividerHeight),
          topicPageViewModel.isFeatureVisible ? featureRow() : Container(),
          SizedBox(height: rowDividerHeight),
          featureImpulseRow(),
          SizedBox(height: rowDividerHeight)
        ],
      ),
    );
  }

  Widget featureRow() {
    Widget child = Container();
    PageFeature pageFeature =
    topicViewModel.getPageFeature(topicPageViewModel.pageNumber);
    if (pageFeature == null) return Container();
    var type = pageFeature.type;
    if (type == FeatureType.AUDIO || type == FeatureType.AUDIOIMAGE)
      child = audioFeature();
    else if (type == FeatureType.IMAGE)
      child = imageFeature();
    else if (type == FeatureType.QUIZ) child = quizFeature();

    return Expanded(
      child: Container(
        child: child,
      ),
    );
  }

  QuizData mockQuizData() {
    List<QuizAnswer> mockAnswersQuestions1 = List();
    QuizAnswer correctAnswer1 = QuizAnswer(1, "Antwort 1 Frage 1");
    mockAnswersQuestions1.add(correctAnswer1);
    mockAnswersQuestions1.add(QuizAnswer(2, "Antwort 2 Frage 1"));
    mockAnswersQuestions1.add(QuizAnswer(3, "Antwort 3 Frage 1"));
    QuizQuestion question1 =
    QuizQuestion("Frage 1", mockAnswersQuestions1, correctAnswer1, 1);

    List<QuizAnswer> mockAnswersQuestions2 = List();
    QuizAnswer correctAnswer2 = QuizAnswer(4, "Antwort 1  Frage 2");
    mockAnswersQuestions2.add(correctAnswer2);
    mockAnswersQuestions2.add(QuizAnswer(5, "Antwort 2  Frage 2"));
    mockAnswersQuestions2.add(QuizAnswer(6, "Antwort 3  Frage 2"));
    QuizQuestion question2 =
    QuizQuestion("Frage 2", mockAnswersQuestions2, correctAnswer2, 2);

    List<QuizQuestion> questions = List();
    questions.add(question1);
    questions.add(question2);
    QuizData quizData = new QuizData(questions, 1);
    return quizData;
  }

  Widget quizFeature() {
    QuizData quizData = mockQuizData();

    return Container(
        child: ChangeNotifierProvider<QuizViewModel>(
          create: (_) => QuizViewModel(),
          child: QuizFeature(quizData),
        ));
  }

  Widget audioFeature() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: primary_green,
        child: Icon(
          Icons.volume_down,
          size: 200,
        ),
      ),
    );
  }

  Widget imageFeature() {
    return Container(
      color: primary_green,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Image(
          image: AssetImage("assets/img/example_no_vc.jpg"),
        ),
      ),
    );
  }

  showImpulseBar() {
    return ChangeNotifierProvider<ImpulseBarViewModel>.value(
      value: impulseBarViewModel,
      child: ImpulseBar(
        onClose: topicPageViewModel.toggleImpulseBarVisible,
        audioIconSize: iconSize,
      ),
    );
  }

  Widget showImpulseBarButton() {
    return Container(
      child: Card(
        elevation: 0,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: primary_green,
        child: IconButton(
            icon: Icon(Icons.chat),
            iconSize: iconSize,
            onPressed: () => topicPageViewModel.toggleImpulseBarVisible()),
      ),
    );
  }

  Widget featureButton() {
    PageFeature pageFeature =
    topicViewModel.getPageFeature(topicPageViewModel.pageNumber);
    if (pageFeature == null) return Container();

    return Container(
      child: Card(
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: primary_green,
        child: IconButton(
            icon: Icon(Icons.card_giftcard),
            iconSize: iconSize,
            onPressed: () => topicPageViewModel.toggleFeatureVisible()),
      ),
    );
  }

  Widget buttonRow() {
    Widget child = Container();
    PageFeature pageFeature =
    topicViewModel.getPageFeature(topicPageViewModel.pageNumber);
    if (pageFeature == null) return Container();
    var type = pageFeature.type;
    if (type == FeatureType.AUDIO || type == FeatureType.AUDIOIMAGE)
      child = audioButtonBar();
    else
      child = Container();
    return Container(child: Center(child: child));
  }

  Widget audioButtonBar() {
    AudioPlayer audioPlayer = AudioPlayer();
    AudioCache audioCache = new AudioCache(fixedPlayer: audioPlayer);
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        audioButton(
          icon: Icon(
            Icons.play_arrow,
            size: audioButtonSize,
          ),
          onPressed: () {
            print("Play audio");
            audioCache.play('example_audio.mp3');
          },
        ),
        audioButton(
            icon: Icon(
              Icons.pause,
              size: audioButtonSize,
            ),
            onPressed: () => audioPlayer.stop()),
      ],
    );
  }

  Widget audioButton({@required Icon icon, @required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
      child: RawMaterialButton(
        padding: EdgeInsets.all(20),
        fillColor: primary_green,
        shape: CircleBorder(),
        child: icon,
        onPressed: onPressed,
      ),
    );
  }

  Widget featureImpulseRow() {
    return Container(
      child: Stack(
        children: <Widget>[
          Center(
            child:
            topicPageViewModel.isFeatureVisible ? buttonRow() : Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              featureButton(),
              topicPageViewModel.isImpulseBarVisible
                  ? showImpulseBar()
                  : showImpulseBarButton()
            ],
          ),
        ],
      ),
    );
  }
}

class TopicPageParams {
  final int topicId;
  final PageNumber pageNumber;

  TopicPageParams(this.topicId, this.pageNumber);
}
