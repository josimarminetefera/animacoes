import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animações",
      debugShowCheckedModeBanner: false,
      home: LogoApp(),
    );
  }
}

class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  //criar o controlador de animação
  AnimationController controller;

  //para criar uma animação
  Animation<double> animacao;

  @override
  void initState() {
    //inicindo a animação
    super.initState();
    //vsync é um mixin que informa para gente toda vez que a tela é refeita para sempre ficar animando a tela
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    //inicializar o animation
    //tween animação vai variar o nimero de 0 a 300 enquando o controller vai variar de 0 a 1
    //tween é uma animaçao com inicio e fim
    animacao = Tween<double>(begin: 0, end: 300).animate(controller);

    //animação tem que dar o start e atializar a tela
    animacao.addListener(() {
      //chama esta função sempre que tiver uma modificaçao na animação
      setState(() {});
    });

    //iniciar a animação
    controller.forward();
  }

  //quando fechar a tela tem que desmontar o controller
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: animacao.value,
        width: animacao.value,
        child: FlutterLogo(),
      ),
    );
  }
}
