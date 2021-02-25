Use Windows.pkg
Use DFClient.pkg
Use cDbCJGridPromptList.pkg
Use cALUNOSDataDictionary.dd
Use cdbCJGridColumn.pkg

Object aluno_sl is a dbModalPanel
    Object oALUNOS_DD is a cALUNOSDataDictionary
    End_Object

    Set Main_DD to oALUNOS_DD
    Set Server to oALUNOS_DD

    Set Size to 133 424
    Set Location     to 4 5
    Set Border_Style to Border_Thick
    Set Label to "CONSULTA ALUNOS"

    Object oSelList is a cDbCJGridPromptList
        Set peAnchors to anAll
        Set Size to 105 412
        Set Location  to 6 6

        Object oALUNOS_CODALU is a cDbCJGridColumn
            Entry_Item ALUNOS.CODALU
            Set piWidth to 89
            Set psCaption to "C¢digo"
        End_Object

        Object oALUNOS_NOME is a cDbCJGridColumn
            Entry_Item ALUNOS.NOME
            Set piWidth to 287
            Set psCaption to "Nome"
        End_Object

        Object oALUNOS_SOBRENOME is a cDbCJGridColumn
            Entry_Item ALUNOS.SOBRENOME
            Set piWidth to 255
            Set psCaption to "Sobrenome"
        End_Object

        Object oALUNOS_DATNAS is a cDbCJGridColumn
            Entry_Item ALUNOS.DATNAS
            Set piWidth to 90
            Set psCaption to "Data Nascimento"
        End_Object
    End_Object

    Object oOK_bn is a Button
        Set Label     to "&OK"
        Set Location to 115 260
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Ok of oSelList
        End_Procedure

    End_Object

    Object oCancel_bn is a Button
        Set Label     to "&Cancel"
        Set Location to 115 314
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Cancel of oSelList
        End_Procedure

    End_Object

    Object oSearch_bn is a Button
        Set Label     to "&Search..."
        Set Location to 115 368
        Set peAnchors to anBottomRight

        Procedure OnClick
            Send Search of oSelList
        End_Procedure

    End_Object

    On_Key Key_Alt+Key_O Send KeyAction of oOk_bn
    On_Key Key_Alt+Key_C Send KeyAction of oCancel_bn
    On_Key Key_Alt+Key_S Send KeyAction of oSearch_bn

End_Object

