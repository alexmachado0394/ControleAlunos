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
    Set Size to 177 373
    Set Location to 10 14
    Set Label to "CONSULTA TURMAS ESPAÄOS DE CAFê"

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
        Set Size to 13 200
        Set Enabled_State to False
    End_Object

    Object oCheckBoxEtapa1 is a CheckBox
        Set Size to 10 50
        Set Location to 10 295
        Set Label to "Etapa 1"
        Set Checked_State to True
    
        Procedure OnChange
            Forward Send OnChange
            Send Rebuild_Constraints of oPESSOASCAFE_DD
            Send MovetoFirstRow of oGridPessoas
        End_Procedure
    
    End_Object

    Object oCheckBoxEtapa2 is a CheckBox
        Set Size to 10 50
        Set Location to 10 335
        Set Label to "Etapa 2"
        Set Checked_State to True
    
        Procedure OnChange
            Forward Send OnChange
            Send Rebuild_Constraints of oPESSOASCAFE_DD
            Send MovetoFirstRow of oGridPessoas
        End_Procedure
    
    End_Object

    Object oGridPessoas is a cDbCJGrid
        Set Server to oPESSOASCAFE_DD
        Set Size to 149 367
        Set Location to 25 2
        Set peHorizontalGridStyle to xtpGridNoLines
        Set Ordering to 1
        Set pbReadOnly to True

        Object oPESSOASCAFE_ETAPA is a cDbCJGridColumn
            Entry_Item PESSOASCAFE.ETAPA
            Set piWidth to 40
            Set psCaption to "Etapa"
        End_Object

        Object oPESSOASCAFE_CODALU is a cDbCJGridColumn
            Entry_Item ALUNOS.CODALU
            Set piWidth to 50
            Set psCaption to "Aluno"
        End_Object

        Object oALUNOS_NOME is a cDbCJGridColumn
            Entry_Item ALUNOS.NOME
            Set piWidth to 274
            Set psCaption to "Nome"
        End_Object

        Object oALUNOS_SOBRENOME is a cDbCJGridColumn
            Entry_Item ALUNOS.SOBRENOME
            Set piWidth to 278
            Set psCaption to "Sobrenome"
        End_Object
    End_Object

Cd_End_Object
