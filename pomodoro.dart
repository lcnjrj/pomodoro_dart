// Importamos a biblioteca 'dart:io' para poder usar funções de entrada e saída no terminal (como print e stdin).
import 'dart:io';

// Importamos a biblioteca 'dart:async' para usar funções assíncronas, como o Timer.
import 'dart:async';

// Função principal: ponto de entrada do programa.
void main() async {
  // Exibe uma mensagem inicial explicando o app.
  print('=== Pomodoro Timer ===');
  print('Método clássico: 25 minutos de foco e 5 minutos de descanso.');
  print('Pressione ENTER para iniciar.');

  // Aguarda o usuário pressionar ENTER.
  stdin.readLineSync();

  // Define as durações em minutos (você pode ajustar se quiser testar mais rápido).
  int focoMin = 25;
  int pausaMin = 5;

  // Chama a função que executa o ciclo Pomodoro.
  await iniciarPomodoro(focoMin, pausaMin);
}

// Função assíncrona que gerencia o ciclo completo do Pomodoro.
Future<void> iniciarPomodoro(int foco, int pausa) async {
  // Inicia o ciclo de foco.
  print('\n🧠 Iniciando ${foco} minutos de foco...');
  await contagemRegressiva(foco * 60); // converte minutos para segundos

  // Aviso de término do tempo de foco.
  print('\n⏰ Tempo de foco acabou! Faça uma pausa.');

  // Inicia o ciclo de pausa.
  print('\n☕ Pausa de ${pausa} minutos...');
  await contagemRegressiva(pausa * 60);

  // Aviso final.
  print('\n✅ Ciclo Pomodoro concluído!');
  print('Deseja iniciar outro ciclo? (s/n)');

  // Lê a resposta do usuário.
  String? resposta = stdin.readLineSync();

  // Se o usuário digitar 's' ou 'S', inicia outro ciclo.
  if (resposta != null && resposta.toLowerCase() == 's') {
    await iniciarPomodoro(foco, pausa);
  } else {
    print('👋 Até a próxima! Continue produtivo!');
  }
}

// Função que faz a contagem regressiva no terminal.
Future<void> contagemRegressiva(int segundosTotais) async {
  // Loop que vai de segundosTotais até 1, diminuindo a cada segundo.
  for (int restante = segundosTotais; restante > 0; restante--) {
    // Calcula minutos e segundos para exibir de forma bonita (mm:ss).
    int minutos = restante ~/ 60; // divisão inteira
    int segundos = restante % 60; // resto da divisão

    // Usa '\r' para sobrescrever a linha anterior (sem pular linha).
    stdout.write(
      '\rTempo restante: ${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}',
    );

    // Aguarda 1 segundo antes de atualizar novamente.
    await Future.delayed(Duration(seconds: 1));
  }
}
