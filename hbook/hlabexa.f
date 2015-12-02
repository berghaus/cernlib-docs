      PROGRAM CERN

      PARAMETER (NWPAWC = 30000)

      COMMON /PAWC/ IPAW(NWPAWC)

      REAL    RDATA(11)

      CHARACTER*4 CHDIV,CHDIVS(13), CHNAT,CHNATS(15)

      DATA CHDIVS /'AG', 'DD', 'DG', 'EF', 'EP', 'FI', 'LEP', 'PE',
     +           'PS', 'SPS', 'ST', 'TH', 'TIS'/
      DATA CHNATS /'AT', 'BE', 'CH', 'DE', 'DK', 'ES', 'FR', 'GB',
     +           'GR', 'IT', 'NL', 'NO', 'PT', 'SE', 'ZZ'/

      CALL HLIMIT(NWPAWC)
*
      OPEN(11,FILE='aptuple.dat', STATUS='OLD')
      OPEN(12,file='hlabexa.ps',form='formatted',status='unknown')

      CALL HBOOK1(11,'Example HLABEL explicit list',13,1.,14.,0.)
      CALL HBOOK1(12,'Example HLABEL implicit list',1 ,0.,1. ,0.)
      CALL HBOOK2(21,'Example HLABEL 2-D',13,2.,15.,13,1.,14.,0.)
*
      CALL HLABEL(11,13,CHDIVS,'N')
      CALL HLABEL(21,13,CHDIVS,'NY')
*
*-- Loop over input data
*
      DO 10 IEVENT = 1, 99999
         READ(11, '(10F4.0, F7.0)', END=20) RDATA
*
         CHDIV    = CHDIVS(INT(RDATA(2)))
         IAGE     = RDATA(4)
         IGRADE   = RDATA(7)
         ISTEP    = RDATA(8)
         CHNAT    = CHNATS(INT(RDATA(9)))
         CALL HFC1(11,0,CHDIV,1.,' ')
         CALL HFC1(12,0,CHDIV,1.,' ')
         CALL HFC2(21,IGRADE,' ',0,CHDIV,1.,' ')
C         print *,' ievent ',IEVENT, ' CHDIV CNNAT ', 
C     x        CHDIV,CHNAT,' IAGE IGRADE ISTEP ',IAGE,IGRADE,ISTEP
   10 CONTINUE
      

   20 CALL HLABEL(12,0,' ','SV')  
      print*, 'End of filling ...'
*
*-- print Ntuple definition
*
      CALL HPLINT(0)
      CALL HPLCAP(-12)
      CALL HPLSET('VSIZ',0.20)
      CALL HPLSET('NDVX',-13.05)
      CALL HPLSET('HCOL',1105)
      CALL HPLSET('BCOL',1.5)
      CALL HPLSET('*FON',-60.)
      CALL HPLOPT('NBOX',1)
      CALL HPLZON(2,2,1,' ')
      CALL HPLOT(11,' ',' ',0)
      CALL HPLOT(12,' ',' ',0)
      CALL HPLZON(1,2,2,'S')  
      CALL HPLOPT('GRID',1)
      CALL HPLOT(21,'BOX',' ',0)
*
      CALL HPLEND
      CALL HINDEX
*
      END
