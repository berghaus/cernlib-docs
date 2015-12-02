      SUBROUTINE MYUHLP
      CHARACTER CMD*32
*
      CALL KUHELP(LUN,CMD)
*
      WRITE(LUN,'(3A)')
     +  ' This is the user help information for '''
     +  ,CMD(:LENOCC(CMD)),'''.'
*
      CALL DATIME(IDATE,ITIME)
      WRITE(LUN,'(/A,I7,I5)')
     +  ' Current date and time:',IDATE,ITIME
      END
