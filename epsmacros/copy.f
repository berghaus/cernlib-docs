      REAL FUNCTION COPY(XDUMMY)
      COMMON/PAWIDN/IDNEVT,VIDN1,VIDN2,VIDN3,VIDN(10),
     +   X    ,   Y    ,   Z     
*
      VECTOR VX(10000), VY(10000), VZ(10000)
*
      VX(IDNEVT) = X
      VY(IDNEVT) = Y
      VZ(IDNEVT) = Z
      END
