      Subroutine rbox(x1,x2,y1,y2,r)
      dimension x(2),y(2)
*
      x(1) = x1
      x(2) = x1
      y(1) = y1+r
      y(2) = y2-r
      Call Ipl(2,x,y)
      x(1) = x2
      x(2) = x2
      Call Ipl(2,x,y)
      y(1) = y1
      y(2) = y1
      x(1) = x1+r
      x(2) = x2-r
      Call Ipl(2,x,y)
      y(1) = y2
      y(2) = y2
      Call Ipl(2,x,y)
      call Igarc(x1+r,y1+r,r,r,180.,270.)
      call Igarc(x1+r,y2-r,r,r, 90.,180.)
      call Igarc(x2-r,y2-r,r,r,  0., 90.)
      call Igarc(x2-r,y1+r,r,r,270.,  0.)
*
      End
