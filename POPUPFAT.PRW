#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "PARMTYPE.CH"

/*ииииииииииииииииииииииииииииииииииииииииииииииииииииииии
|*  Programa: POPUP                                     *|
|*  Autor: Felipe                                       *|
|*  Data: 18/08/2022                                    *|
|*  Descriчуo: Popup com informaчoes do pedido de venda *|
ииииииииииииииииииииииииииииииииииииииииииииииииииииииии*/

User function POPUP()
Local aArea  := SC5->(GetArea()) 
local cMsg := ""


cMsg := "<h3> Avisos Gerais : </h3>" + SC5->C5_XOBSERV + Chr(13) + Chr(10)
cMsg += "<h3> Aviso Produчуo: </h3>" + SC5->C5_XPOPUP + Chr(13) + Chr(10)
cMsg += "<h3> Aviso Faturamento: </h3>" + SC5->C5_XPOPUP2 + Chr(13) + Chr(10)


MsgInfo(cMsg)


RestArea(aArea)


Return 
