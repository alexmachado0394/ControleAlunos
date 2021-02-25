Use Windows.pkg
Use DFClient.pkg
Use cALUNOSDataDictionary.dd
Use DFEntry.pkg

Deferred_View Activate_alunos for ;
Object alunos is a dbView
    Object oALUNOS_DD is a cALUNOSDataDictionary
    End_Object

    Set Main_DD to oALUNOS_DD
    Set Server to oALUNOS_DD

    Set Border_Style to Border_Thick
    Set Size to 142 321
    Set Location to 20 25
    Set Label to "CADASTRO ALUNOS"

    Object oALUNOS_CODALU is a dbForm
        Entry_Item ALUNOS.CODALU
        Set Location to 11 64
        Set Size to 13 42
        Set Label to "C¢digo:"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 0

        Procedure Exiting Handle hoDestination Returns Integer
            Integer iRetVal
            Forward Get msg_Exiting hoDestination to iRetVal
            
            Procedure_Return iRetVal
        End_Procedure
    End_Object

    Object oALUNOS_NOME is a dbForm
        Entry_Item ALUNOS.NOME
        Set Location to 26 64
        Set Size to 13 246
        Set Label to "Nome:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oALUNOS_SOBRENOME is a dbForm
        Entry_Item ALUNOS.SOBRENOME
        Set Location to 41 64
        Set Size to 13 246
        Set Label to "Sobrenome:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oALUNOS_CPF is a dbForm
        Entry_Item ALUNOS.CPF
        Set Location to 56 64
        Set Size to 13 78
        Set Label to "CPF:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
        Set Form_Mask to "000.000.000-00"
    End_Object

    Object oALUNOS_GENERO is a dbForm
        Entry_Item ALUNOS.GENERO
        Set Location to 71 64
        Set Size to 13 20
        Set Label to "Gˆnero:"
        Set Label_Col_Offset to 0
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oALUNOS_DATNAS is a dbForm
        Entry_Item ALUNOS.DATNAS
        Set Location to 86 64
        Set Size to 13 66
        Set Label to "Data Nascimento:"
    End_Object

Cd_End_Object
