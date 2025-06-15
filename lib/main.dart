import 'package:flutter/material.dart';
import 'package:calculator/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  var userQuestion = '';
  var userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 194, 58, 58),

      body: Column(
        children: [
          Expanded(child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 50,),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,

                  child: Text(userQuestion, style: TextStyle(fontSize: 30, color: Colors.white),)),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight, 
                  child:Text(userAnswer, style: TextStyle(fontSize: 30, color: Colors.white),)
                  )
                 
              ],

            ),

          )
          ),
          Expanded(
            flex: 2,
            child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0){
                    return MyButtons(
                      buttonTapped: (){
                        setState(() {
                          userQuestion = '';
                        });
                       
                      },
                      buttonText: buttons[index],
                      color: const Color.fromARGB(255, 170, 170, 170),
                      textcolor: const Color.fromARGB(255, 255, 255, 255),
                    );
                  } 
                  else if(index== 1){
                    return MyButtons(
                      buttonTapped: (){
                        setState(() {
                          userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                    color: const Color.fromARGB(255, 170, 170, 170),
                    textcolor: const Color.fromARGB(255, 255, 255, 255),
                    );

                  }


                  else if(index== buttons.length-1){
                    return MyButtons(
                      buttonTapped: (){
                        setState(() {
                          equalPressed();

                        });
                      },
                      buttonText: buttons[index],
                    color: const Color.fromARGB(255, 170, 170, 170),
                    textcolor: const Color.fromARGB(255, 255, 255, 255),
                    );

                  }

                  else {
                    return MyButtons(
                      buttonTapped: (){
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) ? const Color.fromARGB(255, 238, 86, 86) : const Color.fromARGB(255, 246, 153, 153),
                      textcolor: isOperator(buttons[index]) ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 157, 2, 2),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  
  bool isOperator(String x){
    if(x=='/' || x=='x' || x=='-' || x=='+' || x=='=' || x=='%'){
      return true;
    }
    return false;
  }

  void equalPressed(){
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

     ExpressionParser p = GrammarParser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();

  

  }
}