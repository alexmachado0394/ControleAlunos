Use Windows.pkg
Use DFClient.pkg
Use cDbCJGrid.pkg
Use cCAFEDataDictionary.dd
Use cdbCJGridColumn.pkg

Deferred_View Activate_cafe for ;
Object cafe is a dbView
    Object oCAFE_DD is a cCAFEDataDictionary
    End_Object

    Set Main_DD to oCAFE_DD
    Set Server to oCAFE_DD

    Set Border_Style to Border_Thick
    Set Size to 106 300
    Set Location to 2 2
    Set Label to "CADASTRO ESPAÄOS PARA CAFê"

    Object oDbCJGrid1 is a cDbCJGrid
        Set Size to 100 295
        Set Location to 2 3
        Set peHorizontalGridStyle to xtpGridNoLines

        Object oCAFE_CODIGO is a cDbCJGridColumn
            Entry_Item CAFE.CODIGO
            Set piWidth to 54
            Set psCaption to "C¢digo"
        End_Object

        Object oCAFE_DESCRICAO is a cDbCJGridColumn
            Entry_Item CAFE.DESCRICAO
            Set piWidth to 372
            Set psCaption to "Descriá∆o"
        End_Object

        Object oCAFE_LOTACAO is a cDbCJGridColumn
            Entry_Item CAFE.LOTACAO
            Set piWidth to 90
            Set psCaption to "Lotaá∆o Max."
        End_Object
    End_Object

Cd_End_Object
