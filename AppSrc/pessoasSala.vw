Use Windows.pkg
Use DFClient.pkg
Use cDbCJGrid.pkg
Use cSALASDataDictionary.dd
Use cALUNOSDataDictionary.dd
Use cPESSOASSALADataDictionary.dd
Use DFEntry.pkg
Use cdbCJGridColumn.pkg

Deferred_View Activate_pessoasSala for ;
Object pessoasSala is a dbView
    Object oALUNOS_DD is a cALUNOSDataDictionary
    End_Object

    Object oSALAS_DD is a cSALASDataDictionary
    End_Object

    Object oPESSOASSALA_DD is a cPESSOASSALADataDictionary
        Set DDO_Server to oALUNOS_DD
        Set Constrain_file to SALAS.File_number
        Set DDO_Server to oSALAS_DD

        Procedure OnConstrain
            Forward Send OnConstrain
            Boolean bEtapa1 bEtapa2
            Get Checked_State of oCheckBoxEtapa1 to bEtapa1
            Get Checked_State of oCheckBoxEtapa2 to bEtapa2
            If ((bEtapa1) and (not(bEtapa2))) Constrain PESSOASSALA.ETAPA eq 1
            Else If ((not(bEtapa1)) and (bEtapa2)) Constrain PESSOASSALA.ETAPA eq 2
            Else If ((not(bEtapa1)) and (not(bEtapa2))) Constrain PESSOASSALA.ETAPA eq 3
        End_Procedure
    End_Object

    Set Main_DD to oSALAS_DD
    Set Server to oSALAS_DD

    Set Border_Style to Border_Thick
    Set Size to 157 517
    Set Location to 13 29
    Set Label to "CONSULTA TURMAS SALAS DE AULA"
    Set piMinSize to 157 517

    Object oSALAS_CODIGO is a dbForm
        Entry_Item SALAS.CODIGO
        Set Location to 6 20
        Set Size to 13 42
        Set Label to "Sala:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 0
    End_Object

    Object oSALAS_DESCRICAO is a dbForm
        Entry_Item SALAS.DESCRICAO
        Set Location to 6 65
        Set Size to 13 182
        Set Enabled_State to False
    End_Object

    Object oCheckBoxEtapa1 is a CheckBox
        Set Size to 10 50
        Set Location to 8 432
        Set Label to "Etapa 1"
        Set Checked_State to True
        Set peAnchors to anTopRight
    
        // Fires whenever the value of the control is changed
        Procedure OnChange
            Forward Send OnChange
            Send Rebuild_Constraints of oPESSOASSALA_DD
            Send MovetoFirstRow of oGridPessoas
        End_Procedure
    
    End_Object

    Object oCheckBoxEtapa2 is a CheckBox
        Set Size to 10 50
        Set Location to 8 475
        Set Label to "Etapa 2"
        Set Checked_State to True
        Set peAnchors to anTopRight
    
        // Fires whenever the value of the control is changed
        Procedure OnChange
            Forward Send OnChange
            Send Rebuild_Constraints of oPESSOASSALA_DD
            Send MovetoFirstRow of oGridPessoas
        End_Procedure
    
    End_Object

    Object oGridPessoas is a cDbCJGrid
        Set Server to oPESSOASSALA_DD
        Set Size to 125 509
        Set Location to 27 5
        Set peAnchors to anAll
        Set pbReadOnly to True
        Set Ordering to 1
        Set peHorizontalGridStyle to xtpGridNoLines

        Object oPESSOASSALA_ETAPA is a cDbCJGridColumn
            Entry_Item PESSOASSALA.ETAPA
            Set piWidth to 50
            Set psCaption to "Etapa"
        End_Object

        Object oPESSOASSALA_CODALU is a cDbCJGridColumn
            Entry_Item ALUNOS.CODALU
            Set piWidth to 60
            Set psCaption to "Aluno"
        End_Object

        Object oALUNOS_NOME is a cDbCJGridColumn
            Entry_Item ALUNOS.NOME
            Set piWidth to 388
            Set psCaption to "Nome"
            Set TextColor to clBlue
        End_Object

        Object oALUNOS_SOBRENOME is a cDbCJGridColumn
            Entry_Item ALUNOS.SOBRENOME
            Set piWidth to 392
            Set psCaption to "Sobrenome"
            Set TextColor to clBlack
        End_Object
    End_Object

    Object oTextBox1 is a TextBox
        Set Size to 10 25
        Set Location to 8 403
        Set Label to "Mostrar"
        Set peAnchors to anTopRight
    End_Object

    Object oSALAS_LOTACAO1 is a dbForm
        Entry_Item SALAS.LOTACAO1
        Set Location to 6 290
        Set Size to 13 30
        Set Label to "Qtd. Etapa 1:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oSALAS_LOTACAO2 is a dbForm
        Entry_Item SALAS.LOTACAO2
        Set Location to 6 363
        Set Size to 13 30
        Set Label to "Qtd. Etapa 2:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

Cd_End_Object
