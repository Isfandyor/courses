import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:practice_home/models/quiz.dart';

// ignore: must_be_immutable
class QuizGame extends StatefulWidget {
  // List<Quiz> quizzes;

  const QuizGame({super.key});

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  int indexQuizzes = 0;

  int result = 0;

  Future<void> resultDialog(List<Quiz> quizzes) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Result"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Correct answers: $result",
              style: TextStyle(color: Colors.green[900]),
            ),
            Text(
              "Wrong answers: ${quizzes.length - result}",
              style: TextStyle(
                color: Colors.red[900],
              ),
            )
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(
                context,
              );
              Navigator.pop(
                context,
              );
            },
            label: const Text("Home"),
            icon: const Icon(Icons.home),
          ),
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              indexQuizzes = 0;
              result = 0;
              setState(() {});
            },
            label: const Text("Try again"),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Quiz> quizzes =
        ModalRoute.of(context)!.settings.arguments as List<Quiz>;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${indexQuizzes + 1}. ${quizzes[indexQuizzes].question}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          SizedBox(
            height: 250,
            child: ListView.builder(
                itemCount: quizzes[indexQuizzes].options.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        if (index == quizzes[indexQuizzes].correctOptionIndex) {
                          result += 1;
                        }

                        if (indexQuizzes + 1 <=
                            quizzes[indexQuizzes].options.length) {
                          indexQuizzes++;
                          setState(() {});
                        } else {
                          resultDialog(quizzes);
                        }
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                            child: Text(quizzes[indexQuizzes].options[index])),
                      ),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${indexQuizzes + 1}/${quizzes.length}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                indexQuizzes < quizzes.length - 1
                    ? TextButton.icon(
                        onPressed: () {
                          if (indexQuizzes + 1 < quizzes.length) {
                            indexQuizzes++;
                            setState(() {});
                          }
                        },
                        iconAlignment: IconAlignment.end,
                        label: const Text("Next"),
                        icon: const Icon(
                          Icons.navigate_next_rounded,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          resultDialog(quizzes);
                        },
                        iconAlignment: IconAlignment.end,
                        child: const Text("Result"),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
