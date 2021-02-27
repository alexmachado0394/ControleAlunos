Use Windows.pkg
Use DFClient.pkg
Use BatchDD.pkg

Deferred_View Activate_gera_turmas for ;
Object gera_turmas is a dbView

    Set Border_Style to Border_Thick
    Set Size to 200 300
    Set Location to 18 59
    Set Label to "GERAÄ«O TURMAS"

    Object oGeraTurma is a BusinessProcess
    
        // Send DoProcess of this Business Process Object (BPO)
        // to start the business process.
        // DoProcess is a predefined method of the BusinessProcess class.
    //    Send DoProcess of oBusinessProcess1
    
        // Place your processing code into Procedure OnProcess.
        // OnProcess is a predefined method in the BusinessProcess class.
        Procedure OnProcess
            Boolean bFim bFim2
            Integer iLimCaf iLimSal iLotamin iSala iLotacao iDx
            
            Move 0 to iLotamin
            //Limpar turmas existentes
            Clear PESSOASSALA
            Move False to bFim
            Repeat
             Find gt PESSOASSALA by Index.1
             If Found Begin
                Delete PESSOASSALA
             End
             Else Move True to bFim
            Until bFim
            
            Clear PESSOASCAFE
            Move False to bFim
            Repeat
             Find gt PESSOASCAFE by Index.1
             If Found Begin
                Delete PESSOASCAFE
             End
             Else Move True to bFim
            Until bFim
            
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
            
            
            //Define o tamanho que cada turma pode ter baseado na quantidade de alunos inscritos e salas dispon°veis
            Clear SYSTEM
            Find ge SYSTEM by recnum
            If Found Begin
                Move (SYSTEM.ULTIMOALUNO/SYSTEM.ULTIMASALA) to iLimSal
                Move (SYSTEM.ULTIMOALUNO/SYSTEM.ULTIMOCAFE) to iLimCaf
            End
            
            //monta a composiá∆o das turmas da 1¶ etapa
            Clear ALUNOS
            Move False to bFim
            Repeat
                Find gt ALUNOS by Index.1
                If Found Begin
                   //Verifica qual a sala com menos pessoas
                   Clear SALAS
                   Move False to bFim2
                   Repeat
                    Find gt SALAS by Index.1
                    If Found Begin
                        Move SALAS.LOTACAO1 to iLotacao
                    End
                    Else Move True to bFim2
                   Until bFim2
                   
                   //escolhe a sala com menos pessoas
                   Clear SALAS
                   Move False to bFim2
                   Repeat
                    Find gt SALAS by Index.1
                    If Found Begin
                        If (iLotacao>=SALAS.LOTACAO1) Begin
                            Move SALAS.CODIGO to iSala
                            Move True to bFim2
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
            
            //monta as turmas dos espaáos de cafÇ
            Move 0 to iLotamin
            Clear ALUNOS
            Move False to bFim
            Repeat
                Find gt ALUNOS by Index.1
                If Found Begin
                   //Verifica qual a sala com menos pessoas
                   Clear CAFE
                   Move False to bFim2
                   Repeat
                    Find gt CAFE by Index.1
                    If Found Begin
                        Move CAFE.LOTACAO1 to iLotacao
                    End
                    Else Move True to bFim2
                   Until bFim2
                   
                   //escolhe a sala da pessoa
                   Clear CAFE
                   Move False to bFim2
                   Repeat
                    Find gt CAFE by Index.1
                    If Found Begin
                        If (iLotacao>=CAFE.LOTACAO1) Begin
                            Move CAFE.CODIGO to iSala
                            Move True to bFim2
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
            
        End_Procedure
    
    End_Object

    Object oButtonGerar is a Button
        Set Size to 20 100
        Set Location to 161 4
        Set Label to "Gerar Turmas"
        Set FontWeight to fw_Bold
        Set Typeface to "ARIAL"
        Set FontPointHeight to 15
        
    
        // fires when the button is clicked
        Procedure OnClick
            Integer iResp
            Get YesNo_Box "Confirma a geraá∆o de novas turmas?" "ATENÄ«O" to iResp
            If (iResp=MBR_Yes) Send DoProcess of oGeraTurma
            Else Begin
               Send Stop_Box "Processo cancelado pelo usu†rio" "ATENÄ«O"
               Send Close_Panel
            End
        End_Procedure
    
    End_Object

    Object oButtonSair is a Button
        Set Size to 20 65
        Set Location to 161 185
        Set Label to "Sair sem Gerar"
        Set FontPointHeight to 15
        Set FontWeight to fw_Bold
        Set Typeface to "ARIAL"
    
        // fires when the button is clicked
        Procedure OnClick
           Send Close_Panel            
        End_Procedure
    
    End_Object

    Object oTextBox1 is a TextBox
        Set Size to 9 33
        Set Location to 5 102
        Set Label to "ATENÄ«O!"
        Set FontPointHeight to 25
        Set FontWeight to fw_Bold
    End_Object

    Object oTextBox2 is a TextBox
        Set Auto_Size_State to False
        Set Size to 25 158
        Set Location to 37 3
        Set Label to "ESSE PROCESSO IRµ APAGAR TODAS AS TURMAS MONTADAS E GERAR TURMAS NOVAS BAEADAS NA QUANTIDADE DE SALAS DISPON÷VEIS."
        Set FontPointHeight to 16
        Set FontWeight to fw_Bold
        Set Justification_Mode to JMode_Center
    End_Object

    Object oTextBox3 is a TextBox
        Set Auto_Size_State to False
        Set Size to 25 158
        Set Location to 89 3
        Set Label to "ESSE PROCESSO ê IRREVERS÷VEL, CONFIRME APENAS SE TIVER CERTEZA QUE DESEJA REALIZAR O MESMO!"
        Set FontPointHeight to 16
        Set FontWeight to fw_Bold
        Set Justification_Mode to JMode_Center
    End_Object

Cd_End_Object
