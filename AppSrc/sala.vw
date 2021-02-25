Use Windows.pkg
Use DFClient.pkg
Use cSALASDataDictionary.dd
Use cDbCJGrid.pkg
Use cdbCJGridColumn.pkg

Deferred_View Activate_sala for ;
Object sala is a dbView
    Object oSALAS_DD is a cSALASDataDictionary
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

        Object oSALAS_CODIGO is a cDbCJGridColumn
            Entry_Item SALAS.CODIGO
            Set piWidth to 59
            Set psCaption to "C¢digo"
        End_Object

        Object oSALAS_DESCRICAO is a cDbCJGridColumn
            Entry_Item SALAS.DESCRICAO
            Set piWidth to 367
            Set psCaption to "Descri‡Æo"
        End_Object

        Object oSALAS_LOTACAO is a cDbCJGridColumn
            Entry_Item SALAS.LOTACAO
            Set piWidth to 83
            Set psCaption to "Lota‡Æo M x."
        End_Object
    End_Object

Cd_End_Object
