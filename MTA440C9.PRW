#INCLUDE "protheus.CH"
#INCLUDE "TOPCONN.CH"

/*иииииииииииииииииииииииииииииииииииииииииииииииии
|*  Programa: OPGERADA                            *|
|*  Autor: Felipe                                 *|
|*  Data: 17/08/2022                              *|
|*  Descriчуo: Preenchimento do campo C9_XNUMOP   *|
ииииииииииииииииииииииииииииииииииииииииииииииииии*/

user Function MTA440C9()

Local aArea  := SC6->(GetArea())

If SC6->C6_OPER == '03'
    SC9->C9_XNUMOP := "XXXXXX"
elseif SC6->C6_OPER == '02'
    SC9->C9_XNUMOP := "XXXXXX"
Else     
    SC9->C9_XNUMOP := SC6->C6_NUMOP
EndIf 

RestArea(aArea)

Return
