#INCLUDE "protheus.CH"
#INCLUDE "TOPCONN.CH"

/*--------------------------------------------------
|   Programa: DESCEND                              |
|   Autor: Felipe                                  |
|   Data: 17/08/2022                               |
|   Descrição: Retornar o endereço do cliente      |
--------------------------------------------------*/

USER FUNCTION DESCEND()

Local aArea    := GetArea()
Local cRETORNO := ""

cEndereco := 'Endereço:' + POSICIONE("SA1",1,XFILIAL("SA1")+C5_CLIENTE+C5_LOJACLI,"A1_END") + Chr(13) + Chr(10)    
cEndereco += 'Bairro:' + POSICIONE("SA1",1,XFILIAL("SA1")+C5_CLIENTE+C5_LOJACLI,"A1_BAIRRO") + Chr(13) + Chr(10)    
cEndereco += 'Município:' + POSICIONE("SA1",1,XFILIAL("SA1")+C5_CLIENTE+C5_LOJACLI,"A1_MUN") + Chr(13) + Chr(10)     
cEndereco += 'Estado:' + POSICIONE("SA1",1,XFILIAL("SA1")+C5_CLIENTE+C5_LOJACLI,"A1_EST") + Chr(13) + Chr(10)      
   

cRETORNO := cEndereco

RestArea(aArea)

Return(cRETORNO)

