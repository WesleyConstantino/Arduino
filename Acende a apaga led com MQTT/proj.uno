/************************** Configuração***********************************/
#include "config.h"


/************************ Mapeamento de IO *******************************/
const byte L1 = 2; //pino que o LED do módulo ESP12E está ligado



/************************ Configuração dos tópicos *******************************/

// configura o tópico "fabiosouza_io/feeds/L1"
AdafruitIO_Feed *feedL1 = io.feed("L1");


/************************ Função setup *******************************/

void setup() {

  //configura pino da Lampada como saída
  pinMode(L1,OUTPUT); 

  // configura comunicação serial
  Serial.begin(115200);

  // Aguarda serial monitor
  while(! Serial);

  conectaBroker(); //função para conectar ao broker


}

/************************ Função loop *******************************/

void loop() {

  // processa as mensagens e mantêm a conexão ativa
  byte state = io.run();

  //verifica se está conectado
  if(state == AIO_NET_DISCONNECTED | state == AIO_DISCONNECTED){
    conectaBroker(); //função para conectar ao broker
  }
  
}

/****** Função de tratamento dos dados recebidos em L1***************/

void handleL1(AdafruitIO_Data *data) {

  // Mensagem 
  Serial.print("Recebido  <- ");
  Serial.print(data->feedName());
  Serial.print(" : ");
  Serial.println(data->value());

  //Aciona saída conforme dado recebido
  if(data->isTrue())
    digitalWrite(L1, LOW);
  else
    digitalWrite(L1, HIGH);
}


/****** Função para conectar ao WIFI e Broker***************/

void conectaBroker(){
  
  //mensagem inicial
  Serial.print("Conectando ao Adafruit IO");

  // chama função de conexão io.adafruit.com
  io.connect();

   // instancia um novo handler para recepção da mensagem do feed L1 
  feedL1->onMessage(handleL1);

  // Aguarda conexação ser estabelecida
  while(io.status() < AIO_CONNECTED) {
    Serial.print(".");
    delay(500);
  }

  // Conectado
  Serial.println();
  Serial.println(io.statusText());

  // certifique-se de que todos os feeds obtenham seus valores atuais imediatamente
  feedL1->get();
}
