User Function MA410COR()
Local aCores := PARAMIXB

aAdd(aCores,{"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ) .And. C5_X_CONF = 'S'",'ENABLE','Pedido em Aberto' })		//Pedido em Aberto
aAdd(aCores,{"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)" ,'DISABLE','Pedido Encerrado'})		   	//Pedido Encerrado
aAdd(aCores,{"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)",'BR_AMARELO','TESTE'})
aAdd(aCores,{"C5_BLQ == '1'",'BR_AZUL','Pedido Bloquedo por regra'}) //Pedido Bloquedo por regra
aAdd(aCores,{"C5_BLQ == '2'",'BR_LARANJA','Pedido Bloquedo por verba'})	//Pedido Bloquedo por verba
aAdd(aCores,{'C5_X_CAMPO="N"','BR_PINK','Descrição do novo status'})     // Pedido "Novo STATUS"

return( aCores )

User Function MA410LEG()

Local aLegNew := ParamIXB

AADD( aLegNew, {"BR_PINK","Descrição do novo status"} )
Return( aLegNew )
