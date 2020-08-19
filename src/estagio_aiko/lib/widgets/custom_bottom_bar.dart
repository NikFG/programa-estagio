import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  final int index;
  final PageController pageController;

  CustomBottomBar(this.index,this.pageController);

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.index,
      onTap: (index){
        FocusScope.of(context).unfocus();
        setState(() {
          widget.pageController.jumpToPage(index);
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_bus),
          title: Text("Linhas"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.traffic),
          title: Text("Paradas"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run),
          title: Text("Corredores")
        )
      ],
    );
  }
}
