Use Windows.pkg
Use DFClient.pkg
Use cALUNOSDataDictionary.dd
Use cCAFEDataDictionary.dd
Use cPESSOASCAFEDataDictionary.dd
Use cSALASDataDictionary.dd
Use cPESSOASSALADataDictionary.dd
Use DFEntry.pkg
Use dfTabDlg.pkg
Use cDbCJGrid.pkg
Use cdbCJGridColumn.pkg

Deferred_View Activate_alunos for ;
Object alunos is a dbView
    
//    Procedure Request_Save
//        Forward Send Request_Save
//        Integer iCodSala iCodalu iEtapa
//        
//        
//    End_Procedure
    
    
    
    
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
    Set Size to 162 358
    Set Location to 20 25
    Set Label to "ALUNOS"
    Set piMinSize to 158 358

    Object oALUNOS_CODALU is a dbForm
        Entry_Item ALUNOS.CODALU
        Set Location to 11 44
        Set Size to 13 42
        Set Label to "C¢digo:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 0

        Procedure Exiting Handle hoDestination Returns Integer
            Integer iRetVal iReg iCodigo
            Forward Get msg_Exiting hoDestination to iRetVal
            If (not(iRetVal)) Begin
                Get Current_Record of oALUNOS_DD to iReg
                If (not(iReg)) Begin
                    Clear SYSTEM
                    Find ge SYSTEM by recnum
                    If Found Begin
                        Move SYSTEM.ULTIMOALUNO to iCodigo
                        Move (iCodigo+1) to iCodigo
                        Set Field_Default_Value of oALUNOS_DD Field ALUNOS.CODALU to iCodigo
                    End
                End
            End
            Procedure_Return iRetVal
        End_Procedure
    End_Object

    Object oALUNOS_NOME is a dbForm
        Entry_Item ALUNOS.NOME
        Set Location to 26 44
        Set Size to 13 246
        Set Label to "Nome:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oALUNOS_SOBRENOME is a dbForm
        Entry_Item ALUNOS.SOBRENOME
        Set Location to 41 44
        Set Size to 13 246
        Set Label to "Sobrenome:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oALUNOS_CPF is a dbForm
        Entry_Item ALUNOS.CPF
        Set Location to 56 44
        Set Size to 13 78
        Set Label to "CPF:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
        Set Form_Mask to "000-000-000-00"
    End_Object

    Object oALUNOS_DATNAS is a dbForm
        Entry_Item ALUNOS.DATNAS
        Set Location to 56 185
        Set Size to 13 66
        Set Label to "Data Nascimento:"

        Procedure Exiting Handle hoDestination Returns Integer
            Integer iRetVal iReg
            Forward Get msg_Exiting hoDestination to iRetVal
            If (not(iRetVal)) Begin
                Get Current_Record of oALUNOS_DD to iReg
                If (not(iReg)) Begin
                    Send Request_Save of oALUNOS_DD
                End
            End
            Procedure_Return iRetVal
        End_Procedure
    End_Object

    Object oDbGroupSala is a dbGroup
        Set Size to 80 162
        Set Location to 78 10
        Set Label to "Sala"

        Object oGridSala is a cDbCJGrid
            Set Server to oPESSOASSALA_DD
            Set Size to 65 154
            Set Location to 10 4
            Set peHorizontalGridStyle to xtpGridNoLines
            Set pbReadOnly to True
            Set Focus_Mode to NonFocusable
            Set Ordering to 1

            Object oPESSOASSALA_ETAPA is a cDbCJGridColumn
                Entry_Item PESSOASSALA.ETAPA
                Set piWidth to 46
                Set psCaption to "Etapa"
            End_Object

            Object oPESSOASSALA_CODSAL is a cDbCJGridColumn
                Entry_Item SALAS.CODIGO
                Set piWidth to 34
                Set psCaption to "Sala"
            End_Object

            Object oSALAS_DESCRICAO is a cDbCJGridColumn
                Entry_Item SALAS.DESCRICAO
                Set piWidth to 189
            End_Object
        End_Object
    End_Object

    Object oDbGroupCafe is a dbGroup
        Set Size to 80 162
        Set Location to 78 181
        Set Label to "Caf‚"

        Object oGridCafe is a cDbCJGrid
            Set Server to oPESSOASCAFE_DD
            Set Size to 65 154
            Set Location to 9 5
            Set pbReadOnly to True
            Set peHorizontalGridStyle to xtpGridNoLines
            Set Focus_Mode to NonFocusable
            Set Ordering to 1

            Object oPESSOASCAFE_ETAPA is a cDbCJGridColumn
                Entry_Item PESSOASCAFE.ETAPA
                Set piWidth to 37
                Set psCaption to "Etapa"
            End_Object

            Object oPESSOASCAFE_CODCAF is a cDbCJGridColumn
                Entry_Item CAFE.CODIGO
                Set piWidth to 46
                Set psCaption to "Espa‡o"
            End_Object

            Object oCAFE_DESCRICAO is a cDbCJGridColumn
                Entry_Item CAFE.DESCRICAO
                Set piWidth to 186
            End_Object
        End_Object
    End_Object

Cd_End_Object
