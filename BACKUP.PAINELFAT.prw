#Include 'PROTHEUS.CH'
#Include 'FWMVCDEF.CH'
#Include 'TBICONN.CH'
#Include 'TOPCONN.CH'
#Include 'COLORS.CH'
#Include 'RPTDEF.CH'
#Include 'FWPRINTSETUP.CH'
#Include 'RWMAKE.CH'
#Include 'FONT.CH'

/*/{Protheus.doc} PAINELFAT
Paineis de Acompanhamento Sotequi
@type function
@author Rogério Machado
@since 19/05/2021
/*/User Function PAINELFAT()                        
Local oSay1
Local oSay3
Local oSay4
Local aCoors         := FwGetDialogSize()
Local aFieldFill     := {}
Local aFields        := {}
Local aAlterFields   := {}
Local oMSNewGe1


Static oDlg

Private aHeader1     := {}
Private aCols1       := {}
Private oTimer       := Nil



DEFINE MSDIALOG oDlg TITLE "Painel de Vendas" FROM aCoors[1], aCoors[2] To aCoors[3], aCoors[4] Pixel Style DS_MODALFRAME

//Chama o Refresh da tela a cada 2 min.
oTimer := TTimer():New(500000, {|| Refresh(oMSNewGe1) }, oDlg )
oTimer:Activate() 

//Monta o cabeçalho
aHeader1()


//Seleciona os registros de cada grids
MsgRun("Selecionando Registros..."   ,"",{|| CursorWait(),aCols1() })


oMSNewGe1 := MsNewGetDados():New( 000, 000, aCoors[3]/2 /*166*/, (aCoors[4]/2)-36 /*640*/, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "+Field1+Field2", aAlterFields,, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aHeader1, aCols1)

@ 010, (aCoors[4]/2)-33 BUTTON oButton1 PROMPT "Sair"    SIZE 030, 014 OF oDlg ACTION oDlg:END() PIXEL
@ 028, (aCoors[4]/2)-33 BUTTON oButton2 PROMPT "Refresh" SIZE 030, 014 OF oDlg ACTION Refresh(oMSNewGe1)  PIXEL
@ 046, (aCoors[4]/2)-33 BUTTON oButton2 PROMPT "Legenda" SIZE 030, 014 OF oDlg ACTION Legenda()  PIXEL

oMSNewGe1:oBrowse:bLDblClick := {|| VisuaPed(oMSNewGe1)}

ACTIVATE MSDIALOG oDlg CENTERED

Return


//Pedido de Vendas
Static Function aHeader1()

    Aadd(aHeader1,{ "  "               , "COR"         ,"@BMP"                         , 1                        , 0, .T.,"","" , "" ,"R" ,"" ,"" ,.F.,"V","","","",""})
    AAdd(aHeader1,{ "Filial"           , "XX_PEDIDO"   , "@!"                          , TamSX3('C5_FILIAL')[01]  , 0, ".F.", ".F.", "C", "", } )
    AAdd(aHeader1,{ "Num. Pedido"  	   , "XX_PEDIDO"   , "@!"                          , TamSX3('C5_NUM')[01]     , 0, ".F.", ".F.", "C", "", } )
    AAdd(aHeader1,{ "Razão Social"     , "XX_NOME"     , "@!"                          , TamSX3('A1_NOME')[01]    , 0, ".F.", ".F.", "C", "", } )
    AAdd(aHeader1,{ "Dt. Entrega"      , "XX_DTENTREG" , ""                            , TamSX3('C5_XDTENTR')[01] , 0, ".F.", ".F.", "C", "", } )

Return


//Dados Pedido de Vendas
Static Function aCols1(oMSNewGe1, lRefresh)

Local cAliasQry     := GetNextAlias()
Local aLegenda      := ""
Local oUrgente      := LoadBitmap(GetResources(),"PMSEDT2")
Local oVioleta      := LoadBitmap(GetResources(),"BR_VIOLETA")
Local oRed          := LoadBitmap(GetResources(),"BR_VERMELHO")
Local oYellow       := LoadBitmap(GetResources(),"BR_AMARELO")
Local oGreen        := LoadBitmap(GetResources(),"BR_VERDE")

Default lRefresh := .F.

BeginSQL Alias cAliasQry
	SELECT 
        CASE 
            WHEN C5_XURGENT = 'S' THEN '1'
            WHEN C5_XDTENTR = CONVERT(VARCHAR(10),GETDATE(),112) THEN '2'
            WHEN C5_XDTENTR < CONVERT(VARCHAR(10),GETDATE(),112) THEN '3'
            WHEN C5_XDTENTR BETWEEN CONVERT(VARCHAR(10),GETDATE(),112) AND CONVERT(VARCHAR(10),GETDATE()+3,112) THEN '4'
            WHEN C5_XDTENTR >= CONVERT(VARCHAR(10),GETDATE()+4,112) THEN '5'
        END AS PRIORIDADE, * FROM SC5010 AS SC5
	WHERE SC5.D_E_L_E_T_ = ''
	AND C5_NOTA  = ''
	ORDER BY PRIORIDADE, C5_FILIAL, C5_NUM
EndSQL


DbSelectArea(cAliasQry)
(cAliasQry)->(DbGotop())

aCols1        := {}
While !(cAliasQry)->(Eof())

    If (cAliasQry)->C5_XURGENT == 'S'
        aLegenda := oUrgente
    ElseIf STOD((cAliasQry)->C5_XDTENTR) < DDATABASE
        aLegenda := oVioleta
    ElseIf STOD((cAliasQry)->C5_XDTENTR) == DDATABASE
        aLegenda := oRed
    ElseIf STOD((cAliasQry)->C5_XDTENTR) > DDATABASE .And. STOD((cAliasQry)->C5_XDTENTR) <= DDATABASE+3
        aLegenda := oYellow
    ElseIf STOD((cAliasQry)->C5_XDTENTR) >= DDATABASE+4
        aLegenda := oGreen
    EndIf    

    aAdd(aCols1, { aLegenda, (cAliasQry)->C5_FILIAL, (cAliasQry)->C5_NUM, POSICIONE("SA1",1,xFilial("SA1")+(cAliasQry)->C5_CLIENTE+(cAliasQry)->C5_LOJACLI,"A1_NOME"), StoD((cAliasQry)->C5_XDTENTR), .F. })

    (cAliasQry)->(dbSkip())
EndDo


If lRefresh
    oMSNewGe1:SetArray(aCols1, .T.)
    oMSNewGe1:Refresh(.T.)
    oMSNewGe1:ForceRefresh()      
EndIf

Return



//Chama o Refresh da tela a cada 2 min.
Static Function Refresh(oMSNewGe1)
Local lRefresh := .T.

MsgRun("Selecionando Registros..."   ,"",{|| CursorWait(),aCols1(oMSNewGe1,lRefresh) })

Return


//Visualiza Pedido de Vendas
Static Function VisuaPed(oMsGet)
Local nXLinAt := oMsGet:nAt //Linha Atual
Local aArea	  := GetArea()
Local cBkpFil := cFilAnt

Private Inclui    := .F. //defino que a inclusão é falsa
Private Altera    := .T. //defino que a alteração é verdadeira
Private nOpca     := 1   //obrigatoriamente passo a variavel nOpca com o conteudo 1
Private cCadastro := "Pedido de Vendas - Visualizar" //obrigatoriamente preciso definir com private a variável cCadastro
Private aRotina := {} //obrigatoriamente preciso definir a variavel aRotina como private

cFilAnt := oMsGet:aCols[nXLinAt,2]


DbSelectArea('SC5')
SC5->( DbSetOrder(1) )
If	SC5->( MsSeek( oMsGet:aCols[nXLinAt,2] + oMsGet:aCols[nXLinAt,3] , .F. ) )
    MatA410(Nil, Nil, Nil, Nil, "A410Visual") //executo a função padrão MatA410
EndIf
SC5->(DbCloseArea()) //quando eu sair da tela de visualizar pedido, fecho o meu alias


cFilAnt := cBkpFil
RestArea(aArea)

Return



//Telinha da Legenda
Static Function Legenda()
    Local aLegenda := {}
     
    //Monta as legendas (Cor, Legenda)
    aAdd(aLegenda,{"PMSEDT2",         "Urgente" })
    aAdd(aLegenda,{"BR_VERMELHO",     "Hoje"})
    aAdd(aLegenda,{"BR_VIOLETA",      "Atrasado"})
    aAdd(aLegenda,{"BR_AMARELO",      "Faltam 3 dias"})
    aAdd(aLegenda,{"BR_VERDE",        "Faltam +4 dias"})
     
    //Chama a função que monta a tela de legenda
    BrwLegenda("Legenda", "", aLegenda)
Return
