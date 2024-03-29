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

    //usou Curve pois assim os numeros dos tamanhos sai aleatório. não vai sair 0.1,0.2,0.3,0.4. vai sair 01.2,0.5,0.8
    animacao = CurvedAnimation(parent: controller, curve: Curves.elasticOut);

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

    //printar toda vez que o valor muda
    //toda vez que ele muda esta animação ele atualiza a nossa aplicação
    animacao.addListener(() {
      print(animacao.value);
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
    //return AnimacaoLogo(animacao);
    return AumentarDiminuirFilho(
      child_que_vai_animado: LogoWidget(),
      animacao_crescer_diminuir: animacao,
    );
  }
}

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

  //desenhado somente a curva de animação
  final Tween<double> tamanho_tween = Tween<double>(begin: 0, end: 300);
  final Tween<double> opacidade_tween = Tween(begin: 0.1, end: 1);

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
          return Opacity(
            //evaluate é um valor de 0 a 1 e este será convertido de uma valor de 0.1 a 1
            //clamp limita o tamanho dos limites que podem ser atingidos
            opacity: opacidade_tween.evaluate(animacao_crescer_diminuir).clamp(0, 1.0),
            child: Container(
              //evaluate é um valor de 0 a 1 e este será convertido de uma valor de 0 a 300
              height: tamanho_tween.evaluate(animacao_crescer_diminuir),
              width: tamanho_tween.evaluate(animacao_crescer_diminuir),
              child: child_que_vai_animado,
            ),
          );
        },
      ),
    ));
  }
}
