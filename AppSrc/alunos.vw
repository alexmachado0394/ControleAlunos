Use Windows.pkg
Use DFClient.pkg
Use cALUNOSDataDictionary.dd
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

    Object oALUNOS_DD is a cALUNOSDataDictionary
        Procedure Update
            Forward Send Update
            
            Clear SYSTEM
            Find ge SYSTEM by recnum
            If Found Begin
                Reread SYSTEM
                Move (SYSTEM.PESOASCADASTRADAS+1) to SYSTEM.PESOASCADASTRADAS
                SaveRecord SYSTEM
                Unlock
            End
        End_Procedure

        Procedure Backout
            Forward Send Backout
            
            Clear SYSTEM
            Find ge SYSTEM by recnum
            If Found Begin
                Reread SYSTEM
                Move (SYSTEM.PESOASCADASTRADAS-1) to SYSTEM.PESOASCADASTRADAS
                SaveRecord SYSTEM
                Unlock
            End
            
        End_Procedure
    End_Object

    Set Main_DD to oALUNOS_DD
    Set Server to oALUNOS_DD

    Set Border_Style to Border_Thick
    Set Size to 74 293
    Set Location to 20 25
    Set Label to "ALUNOS"
    Set piMinSize to 74 293

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
                        If (SYSTEM.PESOASCADASTRADAS<SYSTEM.CAPACIDADEMAX) Begin
                            Move SYSTEM.ULTIMOALUNO to iCodigo
                            Move (iCodigo+1) to iCodigo
                            Set Field_Default_Value of oALUNOS_DD Field ALUNOS.CODALU to iCodigo
                        End
                        Else Begin
                            Send Stop_Box "Todas as salas estÆo cheias, imposs¡vel inscrever novos alunos" "ATEN€ÇO"
                            Move 1 to iRetVal
                        End
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

//        Procedure Exiting Handle hoDestination Returns Integer
//            Integer iRetVal iReg
//            If (not(iRetVal)) Begin
//                Get Current_Record of oALUNOS_DD to iReg
//                If (not(iReg)) Begin
//                    Send Request_Save //of oALUNOS_DD
//                End
//            End
//            Forward Get msg_Exiting hoDestination to iRetVal
//            Procedure_Return iRetVal
//        End_Procedure

       Procedure OnKillFocus
          Forward Send OnKillFocus 
          Send Request_Save //of oALUNOS_DD
       End_Procedure
    End_Object

Cd_End_Object
