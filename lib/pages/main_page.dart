import 'package:flutter/material.dart';
import 'package:numbra/pages/graphing_page.dart';
import 'package:numbra/pages/home_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 10,
          ),
          body: Column(
            children: [
              TabBar(
                  dividerColor: Colors.grey.shade600,
                  indicatorColor: Colors.grey.shade700,
                  tabs: const [
                    Tab(
                      icon: Icon(
                        Icons.home,
                        color: Colors.grey,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.auto_graph_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ]),
              const Expanded(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [HomePage(), GraphingPage()]))
            ],
          ),
        ));
  }
}
