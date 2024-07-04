import 'package:flutter/material.dart';
import 'package:graph_calculator/controllers/graph_controller.dart';
import 'package:graph_calculator/models/graph.dart';
import 'package:graph_calculator/models/graph_function.dart';
import 'package:graph_calculator/widgets/graph_widget.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:numbra/util/globals.dart';

class GraphingPage extends StatefulWidget {
  const GraphingPage({super.key});

  @override
  State<GraphingPage> createState() => _GraphingPageState();
}

class _GraphingPageState extends State<GraphingPage> {
  int ind = 0;
  String equation = 'x';
  var graphController = GraphController(
      graph: Graph(
          gridStep: 100, numbersStyle: const TextStyle(color: Colors.black)));
  final TextEditingController _controller = TextEditingController();

  changeEqn(String eqn) {
    setState(() {
      equation = eqn;
    });
  }

  clearAll() {
    setState(() {
      graphController = GraphController(
          graph: Graph(
              gridStep: 100,
              numbersStyle: const TextStyle(color: Colors.black)));
    });
  }

  @override
  Widget build(BuildContext context) {
    Parser parser = Parser();
    Expression exp = parser.parse(equation);
    Variable x = Variable('x');

    void equationControl() {
      setState(() {
        graphController.addFunction(GraphFunction(
            function: (double xValue) {
              ContextModel cm = ContextModel();
              cm.bindVariable(x, Number(xValue));
              return exp.evaluate(EvaluationType.REAL, cm);
            },
            color: colorsAxis[ind % 12]));
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          GraphWidget(
            graphController: graphController,
            size: MediaQuery.of(context).size,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black,
              height: 120,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  onSubmitted: (value) {
                    changeEqn(value);
                  },
                  controller: _controller,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Enter the equation...',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Icons.clear),
              onPressed: () {
                clearAll();
              }),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Icons.line_axis_rounded),
              onPressed: () {
                equationControl();
                ind = ind + 1;
                _controller.clear();
              }),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(Icons.center_focus_strong),
              onPressed: () {
                setState(() {
                  graphController.backToHome();
                });
              }),
          const SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}
