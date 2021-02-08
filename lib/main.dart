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

    //para controlar os estados da animação
    animacao.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //cheguei no 1
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //cheguei no 0
        controller.forward();
      }
    });

    //animação tem que dar o start e atializar a tela
    //estes .. é um parametros de cascata ele espera o primeiro terminar e depois faz o proximo
    //..addListener(() {
    //foi removido o setstate pois foi crido a classAnimacaoLogo
    //chama esta função sempre que tiver uma modificaçao na animação
    //setState(() {});
    //});

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
    //return AnimacaoLogo(animacao);
    return AumentarDiminuirFilho(
      child_que_vai_animado: LogoWidget(),
      animacao_crescer_diminuir: animacao,
    );
  }
}

/*
//isso aqui serva para remover o setState
class AnimacaoLogo extends AnimatedWidget {
  //a animação que chegar vai ser enviada para o super
  //este super é o contrutor do AnimatedWidget
  //super(listenable: animacao) com isso toda vez que a nimação atualizar a tela vai ser refeita
  AnimacaoLogo(Animation<double> animacao) : super(listenable: animacao);

  @override
  Widget build(BuildContext context) {
    //listenable precisa de um tipo
    final Animation<double> animacao_local = listenable;

    return Center(
      child: Container(
        height: animacao_local.value,
        width: animacao_local.value,
        child: FlutterLogo(),
      ),
    );
  }
}
*/

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //pode ser qualquer coisa que ele ia aumentar e diminuir
      child: FlutterLogo(),
    );
  }
}

//animação de ficar aumentando e diminuindo
class AumentarDiminuirFilho extends StatelessWidget {
  final Widget child_que_vai_animado;
  final Animation<double> animacao_crescer_diminuir;

  AumentarDiminuirFilho({this.child_que_vai_animado, this.animacao_crescer_diminuir});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      //animação builder anima apanas o widget que é passado por parametro
      child: AnimatedBuilder(
        animation: animacao_crescer_diminuir,
        child: child_que_vai_animado,
        builder: (context, child) {
          //Container que vai crescer e diminuir
          return Container(
            height: animacao_crescer_diminuir.value,
            width: animacao_crescer_diminuir.value,
            child: child_que_vai_animado,
          );
        },
      ),
    ));
  }
}
