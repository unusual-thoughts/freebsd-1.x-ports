      subroutine cblas()
      call caxpy(n,ca,cx,incx,cy,incy)
      call  ccopy(n,cx,incx,cy,incy)
      c =  cdotc(n,cx,incx,cy,incy)
      c =  cdotu(n,cx,incx,cy,incy)
      r = cmach(job)
      call crotg(ca,cb,c,s)
      call  cscal(n,ca,cx,incx)
      call  csrot (n,cx,incx,cy,incy,c,s)
      call  csscal(n,sa,cx,incx)
      call  cswap (n,cx,incx,cy,incy)
      i = icamax(n,cx,incx)
      r = scasum(n,cx,incx)
      r = scnrm2( n, cx, incx)
      call srotg(sa,sb,c,s)
      stop
      end
