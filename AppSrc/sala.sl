Use Windows.pkg
Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cSALASDataDictionary.dd
Use cdbCJGridColumn.pkg

Object sala_sl is a dbModalPanel
    Object oSALAS_DD is a cSALASDataDictionary
    End_Object

    Set Main_DD to oSALAS_DD
    Set Server to oSALAS_DD

    Set Size to 133 292
    Set Location     to 4 5
    Set Border_Style to Border_Thick
    Set Label to "CONSULTA SALAS"

    Object oSelList is a cDbCJGridPromptList
        Set peAnchors to anAll
        Set Size      to 105 280
        Set Location  to 6 6

        Object oSALAS_CODIGO is a cDbCJGridColumn
            Entry_Item SALAS.CODIGO
            Set piWidth to 57
            Set psCaption to "C¢digo"
        End_Object

        Object oSALAS_DESCRICAO is a cDbCJGridColumn
            Entry_Item SALAS.DESCRICAO
            Set piWidth to 433
            Set psCaption to "Descri‡Æo"
        End_Object
    End_Object

    Object oOK_bn is a Button
        Set Label     to "&OK"
        Set Location  to 115 128
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Ok of oSelList
        End_Procedure

    End_Object

    Object oCancel_bn is a Button
        Set Label     to "&Cancel"
        Set Location  to 115 182
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object

    Object oSearch_bn is a Button
        Set Label     to "&Search..."
        Set Location  to 115 236
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn

End_Object

