*
************************************************************************
*
      SUBROUTINE ECTPSV( UPLO, TRANS, DIAG, N, AP, X, INCX )
*     .. Scalar Arguments ..
      INTEGER            INCX, N
      CHARACTER*1        DIAG, TRANS, UPLO
*     .. Array Arguments ..
      COMPLEX*16         X( * )
      COMPLEX            AP( * )
*     ..
*
*  Purpose
*  =======
*
*  ECTPSV solves one of the systems of equations
*
*     A*x = b,   or   A'*x = b,   or   conjg( A' )*x = b,
*
*  where b and x are n element vectors and A is an n by n unit, or
*  non-unit, upper or lower triangular matrix. Additional precision
*  arithmetic is used in the computation.
*
*  No test for singularity or near-singularity is included in this
*  routine. Such tests must be performed before calling this routine.
*
*  Parameters
*  ==========
*
*  UPLO   - CHARACTER*1.
*           On entry, UPLO specifies whether the matrix is an upper or
*           lower triangular matrix as follows:
*
*              UPLO = 'U' or 'u'   A is an upper triangular matrix.
*
*              UPLO = 'L' or 'l'   A is a lower triangular matrix.
*
*           Unchanged on exit.
*
*  TRANS  - CHARACTER*1.
*           On entry, TRANS specifies the equations to be solved as
*           follows:
*
*              TRANS = 'N' or 'n'   A*x = b.
*
*              TRANS = 'T' or 't'   A'*x = b.
*
*              TRANS = 'C' or 'c'   conjg( A' )*x = b.
*
*           Unchanged on exit.
*
*  DIAG   - CHARACTER*1.
*           On entry, DIAG specifies whether or not A is unit
*           triangular as follows:
*
*              DIAG = 'U' or 'u'   A is assumed to be unit triangular.
*
*              DIAG = 'N' or 'n'   A is not assumed to be unit
*                                  triangular.
*
*           Unchanged on exit.
*
*  N      - INTEGER.
*           On entry, N specifies the order of the matrix A.
*           N must be at least zero.
*           Unchanged on exit.
*
*  AP     - COMPLEX          array of DIMENSION at least
*           ( ( n*( n + 1 ) )/2 ).
*           Before entry with  UPLO = 'U' or 'u', the array AP must
*           contain the upper triangular matrix packed sequentially,
*           column by column, so that AP( 1 ) contains a( 1, 1 ),
*           AP( 2 ) and AP( 3 ) contain a( 1, 2 ) and a( 2, 2 )
*           respectively, and so on.
*           Before entry with UPLO = 'L' or 'l', the array AP must
*           contain the lower triangular matrix packed sequentially,
*           column by column, so that AP( 1 ) contains a( 1, 1 ),
*           AP( 2 ) and AP( 3 ) contain a( 2, 1 ) and a( 3, 1 )
*           respectively, and so on.
*           Note that when  DIAG = 'U' or 'u', the diagonal elements of
*           A are not referenced, but are assumed to be unity.
*           Unchanged on exit.
*
*  X      - COMPLEX*16       array of dimension at least
*           ( 1 + ( n - 1 )*abs( INCX ) ).
*           Before entry, the incremented array X must contain the n
*           element right-hand side vector b. On exit, X is overwritten
*           with the solution vector x. At least double precision
*           arithemtic is used in the computation of x.
*
*  INCX   - INTEGER.
*           On entry, INCX specifies the increment for the elements of
*           X. INCX must not be zero.
*           Unchanged on exit.
*
*
*  Level 2 Blas routine.
*
*  -- Written on 20-July-1986.
*     Sven Hammarling, Nag Central Office.
*     Richard Hanson, Sandia National Labs.
*
*
*     .. Parameters ..
      COMPLEX*16         ZERO
      PARAMETER        ( ZERO = ( 0.0D+0, 0.0D+0 ) )
*     .. Local Scalars ..
      INTEGER            I, INFO, IX, J, JX, K, KK, KX
      LOGICAL            NOCONJ, NOUNIT
*     .. External Functions ..
      LOGICAL            LSAME
      EXTERNAL           LSAME
*     .. External Subroutines ..
      EXTERNAL           XERBLA
*     .. Intrinsic Functions ..
      INTRINSIC          CONJG
*     ..
*     .. Executable Statements ..
*
*     Test the input parameters.
*
      INFO = 0
      IF      ( .NOT.LSAME( UPLO, 'U' ).AND.
     $          .NOT.LSAME( UPLO, 'L' )      ) THEN
         INFO = 1
      ELSE IF ( .NOT.LSAME( TRANS, 'N' ).AND.
     $          .NOT.LSAME( TRANS, 'T' ).AND.
     $          .NOT.LSAME( TRANS, 'C' )      ) THEN
         INFO = 2
      ELSE IF ( .NOT.LSAME( DIAG, 'U' ).AND.
     $          .NOT.LSAME( DIAG, 'N' )      ) THEN
         INFO = 3
      ELSE IF ( N.LT.0 ) THEN
         INFO = 4
      ELSE IF ( INCX.EQ.0 ) THEN
         INFO = 7
      END IF
      IF( INFO.NE.0 )THEN
         CALL XERBLA( 'ECTPSV', INFO )
         RETURN
      END IF
*
*     Quick return if possible.
*
      IF( N.EQ.0 )
     $   RETURN
*
      NOCONJ = LSAME( TRANS, 'T' )
      NOUNIT = ( DIAG .EQ.'N' ).OR.( DIAG .EQ.'n' )
*
*     Set up the start point in X if the increment is not unity. This
*     will be  ( N - 1 )*INCX  too small for descending loops.
*
      IF( INCX.LE.0 )THEN
         KX = 1 - ( N - 1 )*INCX
      ELSE IF( INCX.NE.1 )THEN
         KX = 1
      END IF
*
*     Start the operations. In this version the elements of AP are
*     accessed sequentially with one pass through AP.
*
      IF( LSAME( TRANS, 'N' ) )THEN
*
*        Form  x := inv( A )*x.
*
         IF( LSAME( UPLO, 'U' ) )THEN
            K = ( N*( N + 1 ) )/2
            IF( INCX.EQ.1 )THEN
               DO 20, J = N, 1, -1
                  IF( X( J ).NE.ZERO )THEN
                     IF( NOUNIT )
     $                  X( J ) = X( J )/AP( K )
                     K = K - 1
                     DO 10, I = J - 1, 1, -1
                        X( I ) = X( I ) - X( J )*AP( K )
                        K      = K      - 1
   10                CONTINUE
                  ELSE
                     K = K - J
                  END IF
   20          CONTINUE
            ELSE
               JX = KX + ( N - 1 )*INCX
               DO 40, J = N, 1, -1
                  IF( X( JX ).NE.ZERO )THEN
                     IF( NOUNIT )
     $                  X( JX ) = X( JX )/AP( K )
                     IX = JX
                     KK = K  - 1
                     DO 30, K = KK, KK - J + 2, -1
                        IX      = IX      - INCX
                        X( IX ) = X( IX ) - X( JX )*AP( K )
   30                CONTINUE
                  ELSE
                     K = K - J
                  END IF
                  JX = JX - INCX
   40          CONTINUE
            END IF
         ELSE
            K = 1
            IF( INCX.EQ.1 )THEN
               DO 60, J = 1, N
                  IF( X( J ).NE.ZERO )THEN
                     IF( NOUNIT )
     $                  X( J ) = X( J )/AP( K )
                     K = K + 1
                     DO 50, I = J + 1, N
                        X( I ) = X( I ) - X( J )*AP( K )
                        K      = K      + 1
   50                CONTINUE
                  ELSE
                     K = K + N - J + 1
                  END IF
   60          CONTINUE
            ELSE
               JX = KX
               DO 80, J = 1, N
                  IF( X( JX ).NE.ZERO )THEN
                     IF( NOUNIT )
     $                  X( JX ) = X( JX )/AP( K )
                     IX = JX
                     KK = K + 1
                     DO 70, K = KK, KK + N - ( J + 1 )
                        IX      = IX      + INCX
                        X( IX ) = X( IX ) - X( JX )*AP( K )
   70                CONTINUE
                  ELSE
                     K = K + N - J + 1
                  END IF
                  JX = JX + INCX
   80          CONTINUE
            END IF
         END IF
      ELSE
*
*        Form  x := inv( A' )*x  or  x := inv( conjg( A' ) )*x.
*
         IF( LSAME( UPLO, 'U' ) )THEN
            K = 1
            IF( INCX.EQ.1 )THEN
               DO 110, J = 1, N
                  IF( NOCONJ )THEN
                     DO 90, I = 1, J - 1
                        X( J ) = X( J ) - AP( K )*X( I )
                        K      = K      + 1
   90                CONTINUE
                     IF( NOUNIT )
     $                  X( J ) = X( J )/AP( K )
                  ELSE
                     DO 100, I = 1, J - 1
                        X( J ) = X( J ) - CONJG( AP( K ) )*X( I )
                        K      = K      + 1
  100                CONTINUE
                     IF( NOUNIT )
     $                  X( J ) = X( J )/CONJG( AP( K ) )
                  END IF
                  K = K + 1
  110          CONTINUE
            ELSE
               JX = KX
               DO 140, J = 1, N
                  IX = KX
                  KK = K
                  IF( NOCONJ )THEN
                     DO 120, K = KK, KK + J - 2
                        X( JX ) = X( JX ) - AP( K )*X( IX )
                        IX      = IX      + INCX
  120                CONTINUE
                     IF( NOUNIT )
     $                  X( JX ) = X( JX )/AP( K )
                  ELSE
                     DO 130, K = KK, KK + J - 2
                        X( JX ) = X( JX ) - CONJG( AP( K ) )*X( IX )
                        IX      = IX      + INCX
  130                CONTINUE
                     IF( NOUNIT )
     $                  X( JX ) = X( JX )/CONJG( AP( K ) )
                  END IF
                  K  = K  + 1
                  JX = JX + INCX
  140          CONTINUE
            END IF
         ELSE
            K = ( N*( N + 1 ) )/2
            IF( INCX.EQ.1 )THEN
              DO 170, J = N, 1, -1
                  IF( NOCONJ )THEN
                     DO 150, I = N, J + 1, -1
                        X( J ) = X( J ) - AP( K )*X( I )
                        K      = K      - 1
  150                CONTINUE
                     IF( NOUNIT )
     $                  X( J ) = X( J )/AP( K )
                  ELSE
                    DO 160, I = N, J + 1, -1
                        X( J ) = X( J ) - CONJG( AP( K ) )*X( I )
                        K      = K      - 1
  160                CONTINUE
                     IF( NOUNIT )
     $                  X( J ) = X( J )/CONJG( AP( K ) )
                  END IF
                  K = K - 1
  170          CONTINUE
            ELSE
               KX = KX + ( N - 1 )*INCX
               JX = KX
               DO 200, J = N, 1, -1
                  IX = KX
                  KK = K
                  IF( NOCONJ )THEN
                     DO 180, K = KK, KK - ( N - ( J + 1 ) ), -1
                        X( JX ) = X( JX ) - AP( K )*X( IX )
                        IX      = IX      - INCX
  180                CONTINUE
                     IF( NOUNIT )
     $                  X( JX ) = X( JX )/AP( K )
                  ELSE
                     DO 190, K = KK, KK - ( N - ( J + 1 ) ), -1
                        X( JX ) = X( JX ) - CONJG( AP( K ) )*X( IX )
                        IX      = IX      - INCX
  190                CONTINUE
                     IF( NOUNIT )
     $                  X( JX ) = X( JX )/CONJG( AP( K ) )
                  END IF
                  K  = K  - 1
                  JX = JX - INCX
  200          CONTINUE
            END IF
         END IF
      END IF
*
      RETURN
*
*     End of ECTPSV.
*
      END
