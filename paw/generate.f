	program ggg
	character CIN*20,CNAMES(400)*10,CD*1,CM*1,CMENU*20,CCOM*3 

	OPEN(1,file='CCC',status='old')
	OPEN(2,file='CCC.out',status='unknown')

        II = 0
	DO 10 I=1,400
          READ(1,'(A)',end=100) CIN
          IF (CIN(2:2).EQ.'N') THEN
            CD=CIN(4:4)
	    CCOM =CIN(4:)  
            CM='0'
	    WRITE(2,'(A,5X,A)') CIN,CD     
          ELSEIF (CIN(2:2).EQ.'M') THEN
            J = INDEXA(CIN(4:)) + 3
	    CM=CIN(J:J)
	    CMENU=CIN(J:)  
	    WRITE(2,'(A,5X,A)') CIN,CM     
          ELSEIF (CIN(2:2).EQ.'C') THEN
            II = II + 1
	    LL=LENOCC(CIN)
	    LL=MIN(LL,9)  
            CNAMES(II)=CIN(4:LL)//' '//CD//' '//CM
	    WRITE(2,'(A,3(5X,A))') CNAMES(II),CIN(4:),CCOM,CMENU
          ELSE
            WRITE(6,*) ' ERROR ', I, CIN
        ENDIF
   10 CONTINUE
  100   END
        
