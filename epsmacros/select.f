      REAL FUNCTION select(XDUMMY)
*********************************************************
*                                                       *
* This file was generated by HUWFUN.                    *
*                                                       *
*********************************************************
*
*     N-tuple Id:     10   
*     N-tuple Title:  CERN Population
*     Creation:       10/03/93 09.36.12
*
*********************************************************
*
      COMMON /PAWIDN/ IDNEVT,VIDN1,VIDN2,VIDN3,VIDN(10)
*
*--   Ntuple Variable Declarations
*
      INTEGER CATEGORY,FLAG,AGE,SERVICE,CHILDREN,GRADE,STEP,HRWEEK,COST
      CHARACTER*32 DIVISION,NATION
*
      COMMON /PAWCR4/ CATEGORY,FLAG,AGE,SERVICE,CHILDREN,GRADE,STEP
     + ,HRWEEK,COST
      COMMON /PAWC32/ DIVISION,NATION
*

*
*--   Enter user code here
*

      select = 1.
*
      END

