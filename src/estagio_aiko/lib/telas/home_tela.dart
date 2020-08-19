import 'package:estagio_aiko/telas/corredor_tela.dart';
import 'package:estagio_aiko/telas/linha_tela.dart';
import 'package:estagio_aiko/telas/parada_tela.dart';
import 'package:flutter/material.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {
  var _pageController = PageController(keepPage: false);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          this.index = index;
        });
      },
      children: [
        LinhaTela(index, _pageController),
        ParadaTela(index, _pageController),
        CorredorTela(index, _pageController),
      ],
    );
  }
}
