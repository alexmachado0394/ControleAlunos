Use Windows.pkg
Use DFClient.pkg
Use cSALASDataDictionary.dd
Use cDbCJGrid.pkg
Use cdbCJGridColumn.pkg

Deferred_View Activate_sala for ;
Object sala is a dbView
    Object oSALAS_DD is a cSALASDataDictionary
       Procedure Update
            Forward Send Update
            
            Clear SYSTEM
            Find ge SYSTEM by recnum
            If Found Begin
                Reread SYSTEM
                Move (SYSTEM.SALASCADASTRADAS+1) to SYSTEM.SALASCADASTRADAS
                Move (SYSTEM.CAPACIDADEMAX+SALAS.CAPACIDADE) to SYSTEM.CAPACIDADEMAX
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
                Move (SYSTEM.SALASCADASTRADAS-1) to SYSTEM.SALASCADASTRADAS
                Move (SYSTEM.CAPACIDADEMAX-SALAS.CAPACIDADE) to SYSTEM.CAPACIDADEMAX
                SaveRecord SYSTEM
                Unlock
            End
            
        End_Procedure
    End_Object

    Set Main_DD to oSALAS_DD
    Set Server to oSALAS_DD

    Set Border_Style to Border_Thick
    Set Size to 110 300
    Set Location to 2 2
    Set Label to "CADASTRO DE SALAS"

    Object oDbCJGrid1 is a cDbCJGrid
        Set Size to 100 291
        Set Location to 5 7
        Set pbGrayIfDisable to False
        Set peAnchors to anAll
        Set peHorizontalGridStyle to xtpGridNoLines
        Set pbUseAlternateRowBackgroundColor to True

        Object oSALAS_CODIGO is a cDbCJGridColumn
            Entry_Item SALAS.CODIGO
            Set piWidth to 73
            Set psCaption to "C¢digo"
        End_Object

        Object oSALAS_DESCRICAO is a cDbCJGridColumn
            Entry_Item SALAS.DESCRICAO
            Set piWidth to 364
            Set psCaption to "Descri‡Æo"
        End_Object

        Object oSALAS_CAPACIDADE is a cDbCJGridColumn
            Entry_Item SALAS.CAPACIDADE
            Set piWidth to 72
            Set psCaption to "Capacidade"
        End_Object
    End_Object

Cd_End_Object
