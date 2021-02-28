Use Windows.pkg
Use DFClient.pkg
Use cALUNOSDataDictionary.dd
Use cCAFEDataDictionary.dd
Use cPESSOASCAFEDataDictionary.dd
Use cSALASDataDictionary.dd
Use cPESSOASSALADataDictionary.dd
Use DFEntry.pkg

Deferred_View Activate_consultaPessoa for ;
Object consultaPessoa is a dbView
    Object oSALAS_DD is a cSALASDataDictionary
    End_Object

    Object oCAFE_DD is a cCAFEDataDictionary
    End_Object

    Object oALUNOS_DD is a cALUNOSDataDictionary
    End_Object

    Object oPESSOASSALA_DD is a cPESSOASSALADataDictionary
        Set Constrain_file to ALUNOS.File_number
        Set DDO_Server to oALUNOS_DD
        Set DDO_Server to oSALAS_DD
    End_Object

    Object oPESSOASCAFE_DD is a cPESSOASCAFEDataDictionary
        Set Constrain_file to ALUNOS.File_number
        Set DDO_Server to oALUNOS_DD
        Set DDO_Server to oCAFE_DD
    End_Object

    Set Main_DD to oALUNOS_DD
    Set Server to oALUNOS_DD

    Set Border_Style to Border_Thick
    Set Size to 122 389
    Set Location to 2 2
    Set Label to "CONSULTA PESSOA"

    Object oALUNOS_CODALU is a dbForm
        Entry_Item ALUNOS.CODALU
        Set Location to 11 32
        Set Size to 13 42
        Set Label to "Pessoa:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oALUNOS_NOME is a dbForm
        Entry_Item ALUNOS.NOME
        Set Location to 11 77
        Set Size to 13 150
        Set Enabled_State to False
    End_Object

    Object oALUNOS_SOBRENOME is a dbForm
        Entry_Item ALUNOS.SOBRENOME
        Set Location to 11 230
        Set Size to 13 150
        Set Enabled_State to False
    End_Object

    Object oDbGroupSala is a dbGroup
        Set Size to 80 177
        Set Location to 36 10
        Set Label to "Sala"

        Object oGridSala is a cDbCJGrid
            Set Server to oPESSOASSALA_DD
            Set Size to 65 169
            Set Location to 10 4
            Set peHorizontalGridStyle to xtpGridNoLines
            Set pbReadOnly to True
            Set Ordering to 1
            Set peAnchors to anAll

            Object oPESSOASSALA_ETAPA is a cDbCJGridColumn
                Entry_Item PESSOASSALA.ETAPA
                Set piWidth to 50
                Set psCaption to "Etapa"
            End_Object

            Object oPESSOASSALA_CODSAL is a cDbCJGridColumn
                Entry_Item SALAS.CODIGO
                Set piWidth to 37
                Set psCaption to "Sala"
            End_Object

            Object oSALAS_DESCRICAO is a cDbCJGridColumn
                Entry_Item SALAS.DESCRICAO
                Set piWidth to 208
                Set TextColor to clBlack
            End_Object
        End_Object
    End_Object

    Object oDbGroupCafe is a dbGroup
        Set Size to 80 179
        Set Location to 36 199
        Set Label to "Caf‚"

        Object oGridCafe is a cDbCJGrid
            Set Server to oPESSOASCAFE_DD
            Set Size to 65 171
            Set Location to 9 5
            Set pbReadOnly to True
            Set peHorizontalGridStyle to xtpGridNoLines
            Set Ordering to 1
            Set peAnchors to anAll

            Object oPESSOASCAFE_ETAPA is a cDbCJGridColumn
                Entry_Item PESSOASCAFE.ETAPA
                Set piWidth to 41
                Set psCaption to "Etapa"
            End_Object

            Object oPESSOASCAFE_CODCAF is a cDbCJGridColumn
                Entry_Item CAFE.CODIGO
                Set piWidth to 51
                Set psCaption to "Espa‡o"
            End_Object

            Object oCAFE_DESCRICAO is a cDbCJGridColumn
                Entry_Item CAFE.DESCRICAO
                Set piWidth to 207
                Set TextColor to clBlack
            End_Object
        End_Object
    End_Object

Cd_End_Object
