#include 'protheus.ch'
/*
/*{Protheus.doc} User Function fStrZero
    (Essa função tem por finalidade mostrar a função de Conversões de Tipos de Dados StrZero em ADVPL)
    @type  Function 
*/
User Function fStrZero()

/*00001*/
 
    Local nNum := ALLTRIM(STR(VAL(M->C6_ITEM)*10))                                                                    
    Local nTam := 5
    
 
    Local cVar := StrZero(nNum,nTam)
 
    msgAlert("Variável numérica convertida em String usando a StrZero:"+cVar)
 
Return
