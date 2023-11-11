// Pinos
const int buttonPin = D1; // Pino do botão
const byte ledPin = 2; //pino que o LED do módulo ESP12E está ligado

// Variáveis
int buttonState = 0;      // Variável para armazenar o estado do botão
int lastButtonState = LOW; // Variável para armazenar o estado anterior do botão
int ledState = LOW;       // Variável para armazenar o estado da LED

void setup() {
  // Configurar os pinos
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP); // Configurar o pino do botão como entrada com resistor de pull-up interno
}

void loop() {
  // Ler o estado do botão
  buttonState = digitalRead(buttonPin);

  // Verificar se o estado do botão mudou
  if (buttonState != lastButtonState) {
    // Se o botão foi pressionado, inverter o estado da LED
    if (buttonState == LOW) {
      ledState = !ledState;
      digitalWrite(ledPin, ledState);
    }

    // Atualizar o estado do botão
    lastButtonState = buttonState;
  }
}
