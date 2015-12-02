      Subroutine screen(x,y,w)
      dimension xx(10), yy(10)
*
      w5 = 0.2*w
      call Igset('BORD',1.)
      call Igset('FAIS',0.)
      call Igset('LTYP',1.)
      Call Igbox(x,x+w,y+0.4*w,y+w)
      xx(1) = x
      xx(2) = x + w5
      xx(3) = x + 0.8*w
      xx(4) = x + w
      xx(5) = xx(1)
      yy(1) = y
      yy(2) = y + 0.2*w
      yy(3) = yy(2)
      yy(4) = y
      yy(5) = yy(1)
      call ipl(5,xx,yy)
      r = 0.66*w5
      call igarc(x+w5,y+4*w5,r,r,90.,180.)
      call igarc(x+w5,y+3*w5,r,r,180.,270.)
      call igarc(x+4*w5,y+4*w5,r,r,0.,90.)
      call igarc(x+4*w5,y+3*w5,r,r,270.,0.)
      xx(1) = x + w5
      xx(2) = x + 4*w5
      yy(1) = y +4.66*w5
      yy(2) = yy(1)
      call ipl(2,xx,yy)
      yy(1) = y +2.33*w5
      yy(2) = yy(1)
      call ipl(2,xx,yy)
      xx(1) = x + 0.33*w5
      xx(2) = xx(1)
      yy(1) = y + 3*w5
      yy(2) = y + 4*w5
      call ipl(2,xx,yy)
      xx(1) = x + 4.66*w5
      xx(2) = xx(1)
      call ipl(2,xx,yy)
*
      wb = 0.1*w5
      do j=0,3
         x1 = x + w5 + 0.5*wb - 2*j*wb
         y1 = y + w5 - (2.5+2*j)*wb
         do i=1,15+2*j
            call Igbox(x1,x1+wb,y1,y1+wb)
            x1 = x1 + 2*wb
         enddo
      enddo
      call igbox (x+2*w5,x+3*w5,y+w5,y+2*w5)
*
      End
