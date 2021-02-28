Use Windows.pkg
Use DFClient.pkg
Use BatchDD.pkg

Deferred_View Activate_gera_turmas for ;
Object gera_turmas is a dbView

    Set Border_Style to Border_Thick
    Set Size to 54 313
    Set Location to 18 59
    Set Label to "GERA€ÇO TURMAS"
    Set piMinSize to 54 313

    Object oGeraTurma is a BusinessProcess
    
        // Send DoProcess of this Business Process Object (BPO)
        // to start the business process.
        // DoProcess is a predefined method of the BusinessProcess class.
    //    Send DoProcess of oBusinessProcess1
    
        // Place your processing code into Procedure OnProcess.
        // OnProcess is a predefined method in the BusinessProcess class.
        Procedure OnProcess
            Boolean bFim bFim2
            Integer iLimSal iEtapa1 iSala iLotacao iDx
            
            //Limpar turmas existentes
            ZeroFile PESSOASSALA
            
            ZeroFile PESSOASCAFE
            
            Clear SALAS
            Move False to bFim
            Repeat
             Find gt SALAS by Index.1
             If Found Begin
                Reread SALAS
                Move 0 to SALAS.LOTACAO1
                Move 0 to SALAS.LOTACAO2
                SaveRecord SALAS
                Unlock
             End
             Else Move True to bFim
            Until bFim
            
            Clear CAFE
            Move False to bFim
            Repeat
             Find gt CAFE by Index.1
             If Found Begin
                Reread CAFE
                Move 0 to CAFE.LOTACAO1
                Move 0 to CAFE.LOTACAO2
                SaveRecord CAFE
                Unlock
             End
             Else Move True to bFim
            Until bFim
            
            
            //Define o tamanho que cada turma pode ter baseado na quantidade de alunos inscritos e salas dispon¡veis
            Clear SYSTEM
            Find ge SYSTEM by recnum
            If Found Begin
                Move (SYSTEM.PESOASCADASTRADAS/SYSTEM.SALASCADASTRADAS) to iLimSal
            End
            
            //monta a composi‡Æo das turmas da 1¦ etapa
            Clear ALUNOS
            Move False to bFim
            Repeat
                Find gt ALUNOS by Index.1
                If Found Begin
                   Move 0 to iSala
                   Move 0 to iLotacao
                   //Verifica qual a sala com menos pessoas e adiciona a pessoa a essa sala
                   Clear SALAS
                   Move False to bFim2
                   Repeat
                    Find gt SALAS by Index.1
                    If Found Begin
                        If ((iSala=0) or (SALAS.LOTACAO1<iLotacao)) Begin
                            If ((SALAS.LOTACAO1+1)<=SALAS.CAPACIDADE) Begin
                                Move SALAS.CODIGO to iSala
                                Move SALAS.LOTACAO1 to iLotacao
                            End
                        End
                    End
                    Else Move True to bFim2
                   Until bFim2
                   
                   //Atualiza PESSOASSALA e o SALAS
                   Clear PESSOASSALA
                   Move ALUNOS.CODALU to PESSOASSALA.CODALU
                   Move 1 to PESSOASSALA.ETAPA
                   Move iSala to PESSOASSALA.CODSAL
                   SaveRecord PESSOASSALA
                   
                   Clear SALAS
                   Move iSala to SALAS.CODIGO
                   Find eq SALAS by Index.1
                   If Found Begin
                       Reread SALAS
                       Move (SALAS.LOTACAO1+1) to SALAS.LOTACAO1
                       SaveRecord SALAS
                       Unlock
                   End
                End
                Else Move True to bFim
            Until bFim    
            
            //monta as turmas dos espa‡os de caf‚
            Clear ALUNOS
            Move False to bFim
            Repeat
                Find gt ALUNOS by Index.1
                If Found Begin
                   Move 0 to iSala
                   Move 0 to iLotacao
                   //Verifica qual o espa‡o com menos pessoas e adiciona a pessoa a esse espa‡o
                   Clear CAFE
                   Move False to bFim2
                   Repeat
                    Find gt CAFE by Index.1
                    If Found Begin
                        If ((iSala=0) or (CAFE.LOTACAO1<iLotacao)) Begin
                            Move CAFE.CODIGO to iSala
                            Move CAFE.LOTACAO1 to iLotacao
                        End
                    End
                    Else Move True to bFim2
                   Until bFim2
                   
                   //Atualiza PESSOASCAFE e o CAFE
                   For iDx from 1 to 2
                       Clear PESSOASCAFE
                       Move ALUNOS.CODALU to PESSOASCAFE.CODALU
                       Move iDx to PESSOASCAFE.ETAPA
                       Move iSala to PESSOASCAFE.CODCAF
                       SaveRecord PESSOASCAFE
                   Loop
                   
                   Clear CAFE
                   Move iSala to CAFE.CODIGO
                   Find eq CAFE by Index.1
                   If Found Begin
                       Reread CAFE
                       Move (CAFE.LOTACAO1+1) to CAFE.LOTACAO1
                       Move (CAFE.LOTACAO2+1) to CAFE.LOTACAO2
                       SaveRecord CAFE
                       Unlock
                   End
                End
                Else Move True to bFim
            Until bFim    
            
            
            //Monta as turmas da 2¦ etapa
            Clear ALUNOS
            Move False to bFim
            Repeat
                Find gt ALUNOS by Index.1
                If Found Begin
                   //verifica qual sala o aluno estava na 1¦ etapa
                   Clear PESSOASSALA
                   Move ALUNOS.CODALU to PESSOASSALA.CODALU
                   Move 1 to PESSOASSALA.ETAPA
                   Find eq PESSOASSALA by Index.1
                   If ((Found) and (ALUNOS.CODALU=PESSOASSALA.CODALU) and (PESSOASSALA.ETAPA=1)) Begin
                      Move PESSOASSALA.CODSAL to iEtapa1
                   End
                   
                   Move 0 to iLotacao
                   Move 0 to iSala
                   //escolhe a sala com menos pessoas
                   If (Mod(ALUNOS.CODALU,2)<>0) Begin
                       Clear SALAS
                       Move False to bFim2
                       Repeat
                        Find gt SALAS by Index.1
                        If Found Begin
                            If ((iSala=0) or (SALAS.LOTACAO2<iLotacao)) Begin
                                If ((SALAS.LOTACAO2+1)<=SALAS.CAPACIDADE) Begin
                                    Move SALAS.CODIGO to iSala
                                    Move SALAS.LOTACAO2 to iLotacao
                                End
                            End
                        End
                        Else Move True to bFim2
                       Until bFim2
                   End
                   Else Begin
                      Clear SALAS
                      Move False to bFim2
                      Repeat
                       Find gt SALAS by Index.1
                       If Found Begin
                          If (((iSala=0) or (iEtapa1<>iSala)) or (SALAS.LOTACAO2<iLotacao)) Begin
                            If ((SALAS.LOTACAO2+1)<=SALAS.CAPACIDADE) Begin
                                Move SALAS.CODIGO to iSala
                                Move SALAS.LOTACAO1 to iLotacao
                            End
                        End
                       End
                       Else Move True to bFim2
                      Until bFim2
                   End
                   
                   //Atualiza PESSOASSALA e o SALAS
                   Clear PESSOASSALA
                   Move ALUNOS.CODALU to PESSOASSALA.CODALU
                   Move 2 to PESSOASSALA.ETAPA
                   Move iSala to PESSOASSALA.CODSAL
                   SaveRecord PESSOASSALA
                   
                   Clear SALAS
                   Move iSala to SALAS.CODIGO
                   Find eq SALAS by Index.1
                   If Found Begin
                       Reread SALAS
                       Move (SALAS.LOTACAO2+1) to SALAS.LOTACAO2
                       SaveRecord SALAS
                       Unlock
                   End
                End
                Else Move True to bFim
            Until bFim
            
            Send Info_Box "Processo conclu¡do!" "AVISO"
            
        End_Procedure
    
    End_Object

    Object oButtonGerar is a Button
        Set Size to 20 100
        Set Location to 14 7
        Set Label to "Gerar Turmas"
        Set FontWeight to fw_Bold
        Set Typeface to "ARIAL"
        Set FontPointHeight to 15
        
    
        // fires when the button is clicked
        Procedure OnClick
            Integer iResp
            Boolean bContinua
            Move False to bContinua
            Clear SALAS
            Find gt SALAS by Index.1
            If Found Begin
                Move True to bContinua
            End
            Else Begin
               Send Stop_Box "NÆo h  Salas cadastradas, processo cancelado" "ATEN€ÇO"
               Move False to bContinua
            End
            
            If bContinua Begin
                Move False to bContinua
                Clear CAFE
                Find gt CAFE by Index.1
                If Found Begin
                    Move True to bContinua
                End
                Else Begin
                   Send Stop_Box "NÆo h  Espa‡os de caf‚ cadastrados, processo cancelado" "ATEN€ÇO"
                   Move False to bContinua
                End
            End
            If bContinua Begin
                Get YesNo_Box "Confirma a gera‡Æo de novas turmas?\nEsse processo ir  apagar as turmas existentes." "ATEN€ÇO" MB_DEFBUTTON2 to iResp
                If (iResp=MBR_Yes) Send DoProcess of oGeraTurma
                Else Begin
                   Send Stop_Box "Processo cancelado pelo usu rio" "ATEN€ÇO"
                End
            End
            Send Close_Panel
        End_Procedure
    
    End_Object

    Object oButtonSair is a Button
        Set Size to 20 65
        Set Location to 14 187
        Set Label to "Fechar"
        Set FontPointHeight to 15
        Set FontWeight to fw_Bold
        Set Typeface to "ARIAL"
    
        // fires when the button is clicked
        Procedure OnClick
           Send Close_Panel            
        End_Procedure
    
    End_Object

Cd_End_Object
