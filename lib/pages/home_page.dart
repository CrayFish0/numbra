// ignore_for_file: deprecated_member_use
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:numbra/calculation/result.dart';
import 'package:numbra/util/globals.dart' as gd;
import 'package:numbra/util/main_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();
  final ScrollController _newController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  void _scrollDown() {
    _controller.jumpTo(_controller.position.maxScrollExtent);
    _controller.jumpTo(_newController.position.maxScrollExtent);
  }

  void calculateString(String equation) {
    dev.log(Result().newCalculate(equation));
  }

  calculateEquation(String pressed) {
    _scrollDown();
    setState(() {
      if (pressed == 'C') {
        gd.equation = '';
      } else if (pressed == '⌫') {
        gd.equation = gd.equation.substring(
            0, gd.equation.length - 1 < 0 ? 0 : gd.equation.length - 1);
      } else if (pressed == '=') {
        gd.equation = gd.answer;
      } else {
        gd.equation = '${gd.equation}$pressed';
      }
      gd.answer = Result().newCalculate(gd.equation);
    });
    _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width - 20,
                        child: SingleChildScrollView(
                          controller: _controller,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            gd.equation,
                            style: TextStyle(
                                fontSize: 56,
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 50,
                        child: SingleChildScrollView(
                          controller: _newController,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            gd.answer,
                            style: TextStyle(
                                fontSize: 22, color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.63,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  color: Color.fromARGB(20, 255, 255, 255),
                ),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 20,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 1.2,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return MainButtons(
                        name: gd.buttons[index],
                        buttonPressed: calculateEquation,
                      );
                    }),
              ),
            )
          ],
        ));
  }
}
