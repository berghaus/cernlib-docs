      Subroutine file(x1,x2,y1,y2,dy,ictop,icbot)
      dimension x(2),y(2)
*
      h1 = y1
      h2 = h1+2.*dy
      call Igset('FACI',float(icbot))
      Call Ellipse(x1,x2,h1,h2)
      Call Igset('BORD',0.)
      Call Igset('FAIS',1.)
      Call Igbox(x1,x2,y1+dy,y2-dy)
      h2 = y2
      h1 = h2-2.*dy
      call Igset('FACI',float(ictop))
      Call Ellipse(x1,x2,h1,h2)
      x(1) = x1
      x(2) = x1
      y(1) = y1+dy
      y(2) = y2-dy
      Call Ipl(2,x,y)
      x(1) = x2
      x(2) = x2
      Call Ipl(2,x,y)
*
      End

      Subroutine Ellipse(x1,x2,y1,y2)
      dimension x(51),y(51)
      a=(x2-x1)/2.
      b=(y2-y1)/2.
      xm=(x2+x1)/2.
      ym=(y2+y1)/2.
      dt=6.28/50.
      t=0.
      do 10 i=1,51
         x(i)=a*cos(t)+xm
         y(i)=b*sin(t)+ym
         t=t+dt
 10   continue
      call ifa(51,x,y)
      call ipl(51,x,y)
      end
