#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "PARMTYPE.CH"

/*ииииииииииииииииииииииииииииииииииииииииииииииииииииииии
|*  Programa: TPPEDIDO                                  *|
|*  Autor: Felipe                                       *|
|*  Data: 18/08/2022                                    *|
|*  Descriчуo: Tipo de pedido de venda                  *|
ииииииииииииииииииииииииииииииииииииииииииииииииииииииии*/

User function TPPEDIDO ()
Local aArea  := SC5->(GetArea()) 
local cMsg := ""

if SC5->XOPER == '01' .or. 
    cMsg = 'Venda'
elseif SC5->XOPER == '02' .or. '03'
    cMsg = 'Serviчo'
