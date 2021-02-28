Use Windows.pkg
Use DFClient.pkg
Use cCAFEDataDictionary.dd
Use cALUNOSDataDictionary.dd
Use cPESSOASCAFEDataDictionary.dd
Use DFEntry.pkg
Use cDbCJGrid.pkg
Use cdbCJGridColumn.pkg

Deferred_View Activate_pessoasCafe for ;
Object pessoasCafe is a dbView
    Object oALUNOS_DD is a cALUNOSDataDictionary
    End_Object

    Object oCAFE_DD is a cCAFEDataDictionary
    End_Object

    Object oPESSOASCAFE_DD is a cPESSOASCAFEDataDictionary
        Set DDO_Server to oALUNOS_DD
        Set Constrain_file to CAFE.File_number
        Set DDO_Server to oCAFE_DD
        
        Procedure OnConstrain
            Forward Send OnConstrain
            Boolean bEtapa1 bEtapa2
            Get Checked_State of oCheckBoxEtapa1 to bEtapa1
            Get Checked_State of oCheckBoxEtapa2 to bEtapa2
            If ((bEtapa1) and (not(bEtapa2))) Constrain PESSOASCAFE.ETAPA eq 1
            Else If ((not(bEtapa1)) and (bEtapa2)) Constrain PESSOASCAFE.ETAPA eq 2
            Else If ((not(bEtapa1)) and (not(bEtapa2))) Constrain PESSOASCAFE.ETAPA eq 3
        End_Procedure
    End_Object

    Set Main_DD to oCAFE_DD
    Set Server to oCAFE_DD

    Set Border_Style to Border_Thick
    Set Size to 177 509
    Set Location to 10 14
    Set Label to "CONSULTA TURMAS ESPAÄOS DE CAFê"
    Set piMinSize to 177 509

    Object oCAFE_CODIGO is a dbForm
        Entry_Item CAFE.CODIGO
        Set Location to 7 43
        Set Size to 13 42
        Set Label to "Espaáo CafÇ:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oCAFE_DESCRICAO is a dbForm
        Entry_Item CAFE.DESCRICAO
        Set Location to 7 87
        Set Size to 13 166
        Set Enabled_State to False
    End_Object

    Object oCheckBoxEtapa1 is a CheckBox
        Set Size to 10 50
        Set Location to 10 431
        Set Label to "Etapa 1"
        Set Checked_State to True
        Set peAnchors to anTopRight
    
        Procedure OnChange
            Forward Send OnChange
            Send Rebuild_Constraints of oPESSOASCAFE_DD
            Send MovetoFirstRow of oGridPessoas
        End_Procedure
    
    End_Object

    Object oCheckBoxEtapa2 is a CheckBox
        Set Size to 10 50
        Set Location to 10 471
        Set Label to "Etapa 2"
        Set Checked_State to True
        Set peAnchors to anTopRight
    
        Procedure OnChange
            Forward Send OnChange
            Send Rebuild_Constraints of oPESSOASCAFE_DD
            Send MovetoFirstRow of oGridPessoas
        End_Procedure
    
    End_Object

    Object oGridPessoas is a cDbCJGrid
        Set Server to oPESSOASCAFE_DD
        Set Size to 149 503
        Set Location to 25 2
        Set peHorizontalGridStyle to xtpGridNoLines
        Set Ordering to 1
        Set pbReadOnly to True
        Set peAnchors to anAll

        Object oPESSOASCAFE_ETAPA is a cDbCJGridColumn
            Entry_Item PESSOASCAFE.ETAPA
            Set piWidth to 54
            Set psCaption to "Etapa"
        End_Object

        Object oPESSOASCAFE_CODALU is a cDbCJGridColumn
            Entry_Item ALUNOS.CODALU
            Set piWidth to 68
            Set psCaption to "Aluno"
        End_Object

        Object oALUNOS_NOME is a cDbCJGridColumn
            Entry_Item ALUNOS.NOME
            Set piWidth to 376
            Set psCaption to "Nome"
            Set TextColor to clBlack
        End_Object

        Object oALUNOS_SOBRENOME is a cDbCJGridColumn
            Entry_Item ALUNOS.SOBRENOME
            Set piWidth to 382
            Set psCaption to "Sobrenome"
            Set TextColor to clBlack
        End_Object
    End_Object

    Object oTextBox1 is a TextBox
        Set Size to 10 25
        Set Location to 10 400
        Set Label to "Mostrar"
        Set peAnchors to anTopRight
    End_Object

    Object oCAFE_LOTACAO1 is a dbForm
        Entry_Item CAFE.LOTACAO1
        Set Location to 7 295
        Set Size to 13 26
        Set Label to "Qtd Etapa 1:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oCAFE_LOTACAO2 is a dbForm
        Entry_Item CAFE.LOTACAO2
        Set Location to 7 368
        Set Size to 13 26
        Set Label to "Qtd. Etapa 2:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

Cd_End_Object
