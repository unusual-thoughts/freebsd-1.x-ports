C
C     THIS DRIVER TESTS  EISPACK  FOR THE REAL SYMMETRIC GENERALIZED
C     EIGENPROBLEM  A*X = (LAMBDA)*B*X  WITH  B  POSITIVE DEFINITE,
C     SUMMARIZING THE FIGURES OF MERIT FOR ALL PATHS.
C
C     THIS DRIVER IS CATALOGUED AS  EISPDRV4(RSGSUMAR).
C
C     THE DIMENSION OF  A,B, AND  Z  SHOULD BE  NM  BY  NM.
C     THE DIMENSION OF  W,D,E,E2,IND,RV1,RV2,RV3,RV4,RV5,RV6,DL,
C     W1, AND  W2  SHOULD BE  NM.
C     THE DIMENSION OF  AHOLD  AND  BHOLD  SHOULD BE  NM  BY  NM.
C     HERE NM = 20.
C
C     4-28-92:  MODIFIED CALL TO TRED1 TO PASS SEPARATE ARRAYS
C               TO THE DUMMY ARGUMENTS E AND E2.  (ECA)
C
      REAL A( 20, 20),Z( 20, 20),W( 20),D( 20),E( 20),
     X        E2( 20),RV1( 20),RV2( 20),RV3( 20),RV4( 20),RV5( 20),
     X        RV6( 20),W1( 20),W2( 20),TCRIT( 8),EPSLON,RESDUL,MAXEIG,
     X        MAXDIF,U,LB,UB,EPS1,B( 20, 20),DL( 20),DFL
      REAL AHOLD( 20, 20),BHOLD( 20, 20) 
      REAL  XLB,XUB
      INTEGER  IND( 20),IERR( 6),ERROR
      DATA IREAD1/1/,IREAD2/2/,IREADC/5/,IWRITE/6/
C
      OPEN(UNIT=IREAD1,FILE='FILE35')
      OPEN(UNIT=IREAD2,FILE='FILE47')
      OPEN(UNIT=IREADC,FILE='FILE36')
      REWIND IREAD1
      REWIND IREAD2
      REWIND IREADC
C
      NM = 20
      LCOUNT = 0
      WRITE(IWRITE,1)
    1 FORMAT(1H1,19X,57H EXPLANATION OF COLUMN ENTRIES FOR THE SUMMARY S
     XTATISTICS//1H ,95(1H-)/96H ORDER TQL2   TQLRAT IMTQL2 IMTQL1    LB
     X      UB    M  IMTQLV   TSTURM   BISECT  M1 NO  TRIDIB  /1H ,95(
     X1H-)//55H UNDER 'ORDER' IS THE ORDER OF EACH TEST MATRIX SYSTEM.//
     X95H UNDER 'TQL2   TQLRAT' ARE THREE NUMBERS.  THE FIRST NUMBER, AN
     X INTEGER, IS THE ABSOLUTE SUM OF/
     X61H THE ERROR FLAGS RETURNED SEPARATELY FROM  TQL2  AND  TQLRAT.,
     X34H  THE SECOND NUMBER IS THE MEASURE/
     X62H OF PERFORMANCE BASED UPON THE RESIDUAL COMPUTED FOR THE  TQL2,
     X25H  PATH.  THE THIRD NUMBER        /
     X62H MEASURES THE AGREEMENT OF THE EIGENVALUES FROM THE  TQL2  AND,
     X16H  TQLRAT  PATHS.  //
     X95H UNDER 'IMTQL2 IMTQL1' ARE THREE NUMBERS WITH MEANING LIKE THOS
     XE UNDER  'TQL2   TQLRAT'.       //
     X95H UNDER 'LB' AND 'UB' ARE THE INPUT VARIABLES SPECIFYING THE INT
     XERVAL TO  BISECT  AND  TSTURM.  //
     X61H UNDER 'M' IS THE NUMBER OF EIGENVALUES DETERMINED BY  BISECT,
     X30H  AND  TSTURM  THAT LIE IN THE    /18H INTERVAL (LB,UB).//
     X95H UNDER EACH OF 'IMTQLV', 'TSTURM', 'BISECT', AND 'TRIDIB' ARE T
     XWO NUMBERS.  THE FIRST NUMBER,       )
      WRITE(IWRITE,2)
    2 FORMAT(
     X95H AN INTEGER, IS THE ABSOLUTE SUM OF THE ERROR FLAGS RETURNED FR
     XOM THE RESPECTIVE PATH.         /
     X95H THE SECOND NUMBER IS THE MEASURE OF PERFORMANCE BASED UPON THE
     X RESIDUAL COMPUTED FOR THE PATH.//
     X95H UNDER 'M1' AND 'NO' ARE THE VARIABLES SPECIFYING THE LOWER BOU
     XNDARY INDEX AND THE NUMBER       /
     X28H OF EIGENVALUES TO  TRIDIB.  //
     X62H -1.0  AS THE MEASURE OF PERFORMANCE IS PRINTED IF AN ERROR IN,
     X27H THE CORRESPONDING PATH HAS      /
     X57H PREVENTED THE COMPUTATION OF THE EIGENVECTORS OR VALUES. //
     X41H THE  TQL2    PATH USES THE EISPACK CODES,
     X30H   REDUC-TRED2-TQL2  -REBAK , /
     X39H AS CALLED FROM DRIVER SUBROUTINE  RSG. /
     X41H THE  TQLRAT  PATH USES THE EISPACK CODES,
     X23H   REDUC-TRED1-TQLRAT, /
     X39H AS CALLED FROM DRIVER SUBROUTINE  RSG. /
     X41H THE  IMTQL2  PATH USES THE EISPACK CODES,
     X30H   REDUC-TRED2-IMTQL2-REBAK . )
      WRITE(IWRITE,3)
    3 FORMAT(
     X41H THE  IMTQL1  PATH USES THE EISPACK CODES,
     X23H   REDUC-TRED1-IMTQL1. /
     X41H THE  IMTQLV  PATH USES THE EISPACK CODES,
     X44H   REDUC-TRED1-IMTQLV-TINVIT-TRBAK1-REBAK.  /
     X41H THE  TSTURM  PATH USES THE EISPACK CODES,
     X37H   REDUC-TRED1-TSTURM-TRBAK1-REBAK . /
     X41H THE  BISECT  PATH USES THE EISPACK CODES,
     X44H   REDUC-TRED1-BISECT-TINVIT-TRBAK1-REBAK.  /
     X41H THE  TRIDIB  PATH USES THE EISPACK CODES,
     X44H   REDUC-TRED1-TRIDIB-TINVIT-TRBAK1-REBAK.  )
      WRITE(IWRITE,15)
   15 FORMAT(1X,21HS.P. VERSION 04/15/83 )
    5 FORMAT( 53H1       TABULATION OF THE ERROR FLAG  ERROR  AND THE ,
     X    31HMEASURE OF PERFORMANCE  Y  FOR / 5X,
     X    56HTHE  EISPACK  CODES.  THIS RUN DISPLAYS THESE STATISTICS,
     X    23H FOR THE REAL SYMMETRIC / 5X,
     X    46HGENERALIZED EIGENPROBLEM  A*X = (LAMBDA)*B*X ./
     X    55H0ORDER TQL2   TQLRAT IMTQL2 IMTQL1    LB      UB    M   ,
     X    40HIMTQLV   TSTURM   BISECT  M1 NO  TRIDIB )
   10 CALL  RMATIN(NM,N,A,B,AHOLD,BHOLD,0)
      READ(IREADC,50) MM,LB,UB,M11,NO
   50 FORMAT(I4,2D24.16,2(4X,I4))
C
C     MM,LB,UB,M11,  AND  NO  ARE READ FROM SYSIN AFTER THE MATRICES
C     ARE GENERATED.  MM,LB,  AND  UB  SPECIFY TO  BISECT  THE MAXIMUM
C     NUMBER OF EIGENVALUES AND THE BOUNDS FOR THE INTERVAL WHICH IS
C     TO BE SEARCHED.  M11  AND  NO  SPECIFY TO  TRIDIB  THE LOWER
C     BOUNDARY INDEX AND THE NUMBER OF DESIRED EIGENVALUES.
C
      DO  230  ICALL = 1,10
         IF( ICALL .NE. 1 )  CALL  RMATIN(NM,N,A,B,AHOLD,BHOLD,1)
C
C     IF  TQLRAT  PATH (LABEL 80) IS TAKEN THEN  TQL2  PATH (LABEL 70)
C     MUST ALSO BE TAKEN IN ORDER THAT THE MEASURE OF PERFORMANCE BE
C     MEANINGFUL.
C     IF  IMTQL1  PATH (LABEL 85) IS TAKEN THEN  IMTQL2  PATH (LABEL 75)
C     MUST ALSO BE TAKEN IN ORDER THAT THE MEASURE OF PERFORMANCE BE
C     MEANINGFUL.
C     IF  TQL2  (IMTQL2)  PATH FAILS, THEN  TQLRAT  (IMTQL1)  PATH IS
C     OMITTED AND PRINTOUT FLAGGED WITH  -1.0.
C
         GO TO  (70,75,80,85,89,90,95,230,110,230),  ICALL
C
C     RSGWZ  USING  TQL2
C     INVOKED FROM DRIVER SUBROUTINE  RSG.
C
   70    ICT = 1
         CALL  RSG(NM,N,A,B,W,1,Z,E,E2,ERROR)
         IERR(ICT) = ERROR
         IF( ERROR .EQ. 7*N + 1 ) GO TO 200
         M = ERROR - 1
         IF( ERROR .NE. 0 ) GO TO 74
         DO 71 I =1,N
            W1(I) = W(I)
   71    CONTINUE
         M = N
   74    GO TO  190
C
C     RSGWZ  USING  IMTQL2
C
   75    ICT = 2
         CALL  REDUC(NM,N,A,B,DL,ERROR)
         IERR(ICT) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         CALL  TRED2(NM,N,A,W,E,Z)
         CALL  IMTQL2(NM,N,W,E,Z,ERROR)
         IERR(ICT) = ERROR
         M = ERROR - 1
         IF( ERROR .NE. 0 ) GO TO 79
         DO 78  I=1,N
   78       W2(I) = W(I)
         M = N
   79    CALL  REBAK(NM,N,B,DL,M,Z)
         GO TO  190
C
C     RSGW  USING  TQLRAT
C     INVOKED FROM DRIVER SUBROUTINE  RSG.
C
   80    ICT = 7
         IF( IERR(1) .NE. 0 ) GO TO 200
         CALL  RSG(NM,N,A,B,W,0,A,E,E2,ERROR)
         IERR(1) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         MAXEIG = 0.0E0
         MAXDIF = 0.0E0
         DO 81 I = 1,N
            IF( ABS(W(I)) .GT. MAXEIG ) MAXEIG = ABS(W(I))
            U = ABS(W1(I) - W(I))
            IF( U .GT. MAXDIF ) MAXDIF = U
   81    CONTINUE
         IF( MAXEIG .EQ. 0.0E0 ) MAXEIG = 1.0E0
         DFL = 10 * N
         TCRIT(7) = MAXDIF/EPSLON(MAXEIG*DFL)
         GO TO  230
C
C     RSGW  USING  IMTQL1
C
   85    ICT = 8
         IF( IERR(2) .NE. 0 ) GO TO 200
         CALL  REDUC(NM,N,A,B,DL,ERROR)
         CALL  TRED1(NM,N,A,W,E,E2)
         CALL  IMTQL1(N,W,E,ERROR)
         IERR(2) = ERROR
         MAXEIG = 0.0E0
         MAXDIF = 0.0E0
         DO 86 I = 1,N
            IF( ABS(W(I)) .GT. MAXEIG ) MAXEIG = ABS(W(I))
            U = ABS(W2(I) - W(I))
            IF( U .GT. MAXDIF ) MAXDIF = U
   86    CONTINUE
         IF( MAXEIG .EQ. 0.0E0 ) MAXEIG = 1.0E0
         DFL = 10 * N
         TCRIT(8) = MAXDIF/EPSLON(MAXEIG*DFL)
         GO TO  230
C
C     RSGW1Z  ( USAGE HERE COMPUTES ALL THE EIGENVECTORS )
C
   89    ICT = 3
         CALL  REDUC(NM,N,A,B,DL,ERROR)
         IERR(ICT) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         CALL  TRED1(NM,N,A,D,E,E2)
         CALL  IMTQLV(N,D,E,E2,W,IND,ERROR,RV1)
         IERR(ICT) = ERROR
         M = N
         IF( ERROR .NE. 0 ) M = ERROR - 1
         CALL  TINVIT(NM,N,D,E,E2,M,W,IND,Z,ERROR,RV1,RV2,RV3,RV4,RV6)
         IERR(ICT) = IERR(ICT) + IABS(ERROR)
         CALL  TRBAK1(NM,N,A,E,M,Z)
         CALL  REBAK(NM,N,B,DL,M,Z)
         GO TO  190
C
C     RSG1W1Z  USING  TSTURM
C
   90    ICT = 4
         EPS1 = 0.0E0
         CALL  REDUC(NM,N,A,B,DL,ERROR)
         IERR(ICT) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         CALL  TRED1(NM,N,A,D,E,E2)
         CALL  TSTURM(NM,N,EPS1,D,E,E2,LB,UB,MM,M,W,Z,ERROR,
     X                RV1,RV2,RV3,RV4,RV5,RV6)
         IERR(ICT) = ERROR
         XLB = LB
         XUB = UB
         IF( ERROR .EQ. 3*N + 1 ) GO TO 200
         IF( ERROR .GT. 4*N ) M = ERROR - 4*N - 1
         CALL  TRBAK1(NM,N,A,E,M,Z)
         CALL  REBAK(NM,N,B,DL,M,Z)
         GO TO  190
C
C     RSG1W1Z  USING  BISECT  AND  TINVIT
C
   95    ICT = 5
         EPS1 = 0.0E0
         CALL  REDUC(NM,N,A,B,DL,ERROR)
         IERR(ICT) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         CALL  TRED1(NM,N,A,D,E,E2)
         CALL  BISECT(N,EPS1,D,E,E2,LB,UB,MM,M,W,IND,ERROR,RV4,RV5)
         IERR(ICT) = ERROR
         MBISCT = M
         XLB = LB
         XUB = UB
         IF( ERROR .NE. 0 ) GO TO 200
         CALL  TINVIT(NM,N,D,E,E2,M,W,IND,Z,ERROR,RV1,RV2,RV3,RV4,RV6)
         IERR(ICT) = IABS(ERROR)
         CALL  TRBAK1(NM,N,A,E,M,Z)
         CALL  REBAK(NM,N,B,DL,M,Z)
         GO TO  190
C
C     RSG1W1Z  USING  TRIDIB  AND  TINVIT
C
  110    ICT = 6
         EPS1 = 0.0E0
         CALL  REDUC(NM,N,A,B,DL,ERROR)
         IERR(ICT) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         CALL  TRED1(NM,N,A,D,E,E2)
         CALL  TRIDIB(N,EPS1,D,E,E2,LB,UB,M11,NO,W,IND,ERROR,RV4,RV5)
         IERR(ICT) = ERROR
         IF( ERROR .NE. 0 ) GO TO 200
         M = NO - M11 + 1
         CALL  TINVIT(NM,N,D,E,E2,M,W,IND,Z,ERROR,RV1,RV2,RV3,RV4,RV6)
         IERR(ICT) = IABS(ERROR)
         CALL  TRBAK1(NM,N,A,E,M,Z)
         CALL  REBAK(NM,N,B,DL,M,Z)
C
  190    IF( M .EQ. 0 .AND. ERROR .NE. 0 ) GO TO 200
         CALL  RMATIN(NM,N,A,B,AHOLD,BHOLD,1)
         CALL  RSGWZR(NM,N,M,A,B,W,Z,RV1,RESDUL)
         DFL = 10 * N
         TCRIT(ICT) = RESDUL/EPSLON(DFL)
         GO TO  230
  200    TCRIT(ICT) = -1.0E0
  230 CONTINUE
C
      IF( MOD(LCOUNT,35) .EQ. 0 ) WRITE(IWRITE,5)
      LCOUNT = LCOUNT + 1
      WRITE(IWRITE,240) N,IERR(1),TCRIT(1),TCRIT(7),IERR(2),TCRIT(2),
     X             TCRIT(8),XLB,XUB,MBISCT,(IERR(I),TCRIT(I),I=3,5),
     X             M11,NO,IERR(6),TCRIT(6)
  240 FORMAT(I4,2(I3,2F6.3),2(1PE8.0),I3,3(I3,0PF6.3),3I3,F6.3)
      GO TO  10
      END
      SUBROUTINE RSGWZR(NM,N,M,A,B,W,Z,NORM,RESDUL)
C
      REAL NORM(M),W(M),A(NM,N),Z(NM,M),NORMA,TNORM,S,SUM,
     X       SUMZ, SUMA, RESDUL, B(NM,N), SUMQ
C
C     THIS SUBROUTINE FORMS THE 1-NORM OF THE RESIDUAL MATRIX
C     A*Z-B*Z*DIAG(W)  WHERE  A  IS A REAL SYMMETRIC MATRIX,
C     B  IS A REAL SYMMETRIC MATRIX ,  W  IS A VECTOR WHICH
C     CONTAINS  M  EIGENVALUES OF THE EIGENPROBLEM  A*Z-B*Z*DIAG(W),
C     AND  Z  IS AN ARRAY WHICH CONTAINS THE  M  CORRESPONDING
C     EIGENVECTORS OF THE EIGENPROBLEM. ALL NORMS APPEARING IN
C     THE COMMENTS BELOW ARE 1-NORMS.
C
C     THIS SUBROUTINE IS CATALOGUED AS EISPDRV4(RSGWZR).
C
C     INPUT.
C
C        NM IS THE ROW DIMENSION OF TWO-DIMENSIONAL ARRAY PARAMETERS
C           AS DECLARED IN THE CALLING PROGRAM DIMENSION STATEMENT;
C
C        M IS THE NUMBER OF EIGENVECTORS FOR WHICH RESIDUALS ARE
C           DESIRED;
C
C        N IS THE ORDER OF THE MATRIX  A;
C
C        A(NM,N) IS A REAL SYMMETRIC MATRIX.  ONLY THE FULL UPPER
C           TRIANGLE NEED BE SUPPLIED;
C
C        B(NM,N) IS A REAL SYMMETRIC MATRIX.  ONLY THE FULL UPPER
C           TRIANGLE NEED BE SUPPLIED;
C
C        Z(NM,M) IS A REAL MATRIX WHOSE FIRST  M  COLUMNS CONTAIN THE
C          APPROXIMATE EIGENVECTORS OF THE EIGENPROBLEM;
C
C        W(M) IS A VECTOR WHOSE FIRST  M   COMPONENTS CONTAIN THE
C           APPROXIMATE EIGENVALUES OF THE EIGENPROBLEM.  W(I) IS
C           ASSOCIATED WITH THE I-TH  COLUMN OF  Z.
C
C     OUTPUT.
C
C        Z(NM,M) IS AN ARRAY WHICH CONTAINS  M  NORMALIZED
C           APPROXIMATE EIGENVECTORS OF THE EIGENPROBLEM. THE EIGEN-
C           VECTORS ARE NORMALIZED USING THE 1-NORM IN SUCH A WAY THAT
C           THE FIRST ELEMENT WHOSE MAGNITUDE IS LARGER THAN THE NORM
C           OF THE EIGENVECTOR DIVIDED BY  N  IS POSITIVE;
C
C        A(NM,N) IS ALTERED BY MAKING THE LOWER TRIANGLE OF  A
C           SYMMETRIC WITH THE UPPER TRIANGLE OF  A;
C
C        B(NM,N) IS ALTERED BY MAKING THE LOWER TRIANGLE OF  B
C           SYMMETRIC WITH THE UPPER TRIANGLE OF  B;
C
C        NORM(M) IS AN ARRAY SUCH THAT FOR EACH  K,
C           NORM(K) = !!A*Z(K)-B*Z(K)*W(K)!!/(!!A!!*!!Z(K)!!)
C           WHERE  Z(K)  IS THE K-TH EIGENVECTOR;
C
C        RESDUL IS THE REAL NUMBER
C           !!A*Z-B*Z*DIAG(W)!!/(!!A!!*!!Z!!).
C
C
C     ----------------------------------------------------------------
C
      RESDUL = 0.0E0
      IF( M .EQ. 0 ) RETURN
      NORMA = 0.0E0
C
      DO 40 I=1,N
         SUMA = 0.0E0
         IF(I .EQ. 1) GO TO 20
C
         DO 10 L=2,I
           A(I,L-1) = A(L-1,I)
   10      SUMA =SUMA + ABS(A(L-1,I))
C
   20    DO 30 L=I,N
   30      SUMA = SUMA + ABS(A(I,L))
C
   40    NORMA = AMAX1(NORMA,SUMA)
C
      IF(NORMA .EQ. 0.0E0) NORMA = 1.0E0
C
      DO 100 I=1,M
         S = 0.0E0
         SUMZ = 0.0E0
C
         DO 60 L=1,N
           SUMZ = SUMZ + ABS(Z(L,I))
           SUMQ = 0.0E0
C
           DO 45 K=1,N
   45        SUMQ = SUMQ + B(L,K)*Z(K,I)
C
           SUM = -W(I)*SUMQ
C
           DO 50 K=1,N
   50        SUM = SUM + A(L,K)*Z(K,I)
C
   60      S =S + ABS(SUM)
C
         NORM(I) = SUMZ
         IF(SUMZ .EQ. 0.0E0) GO TO 100
C        ..........THIS LOOP WILL NEVER BE COMPLETED SINCE THERE
C                  WILL ALWAYS EXIST AN ELEMENT IN THE VECTOR Z(I)
C                  LARGER THAN !!Z(I)!!/N..........
         DO 70 L=1,N
            IF(ABS(Z(L,I)) .GE. NORM(I)/N) GO TO 80
   70       CONTINUE
C
   80    TNORM = SIGN(NORM(I),Z(L,I))
C
         DO 90 L=1,N
   90       Z(L,I) = Z(L,I)/TNORM
C
         NORM(I) = S/(NORM(I)*NORMA)
  100    RESDUL = AMAX1(NORM(I), RESDUL)
C
      RETURN
      END
      SUBROUTINE RMATIN(NM,N,A,B,AHOLD,BHOLD,INITIL)
C
C     THIS INPUT SUBROUTINE READS TWO REAL MATRICES  A  AND  B  FROM
C     SYSIN OF ORDER N.
C     TO GENERATE THE MATRICES INITIALLY,  INITIL  IS TO BE 0.
C     TO REGENERATE THE MATRICES FOR THE PURPOSE OF THE RESIDUAL
C     CALCULATION,  INITIL  IS TO BE  1.
C
C     THIS ROUTINE IS CATALOGUED AS  EISPDRV4(RSGREADI).
C
      REAL A(NM,NM),B(NM,NM),AHOLD(NM,NM),BHOLD(NM,NM) 
      INTEGER  IA( 20), IB( 20)
      DATA IREADA/1/,IREADB/2/,IWRITE/6/
C
      IF( INITIL .EQ. 1 )  GO TO  30
      READ(IREADA,5) N, M
    5 FORMAT(I6,6X,I6)
      IF( N .EQ. 0 )  GO TO  70
      IF (M .NE. 1) GO TO 16
      DO  10  I = 1,N
         READ(IREADA,17) (IA(J), J=I,N)  
         DO   9  J = I,N
           A(I,J) = IA(J)
    9      A(J,I) =  A(I,J)
   10 CONTINUE
   11 CONTINUE
      READ(IREADB,5) N,M
      IF( M .NE. 1 ) GO TO 20
      DO 15 I = 1,N
         READ(IREADB,17) (IB(J), J=I,N)   
         DO 14 J = I,N
            B(I,J)=IB(J)
   14       B(J,I)=B(I,J)
   15 CONTINUE
      GO TO 22
   16 CONTINUE
      DO  18  I = 1,N
         READ(IREADA,17) (IA(J), J=1,N)  
   17    FORMAT(6I12)
         DO  18  J = 1,N
   18      A(I,J) = IA(J)
      GO TO 11
   20 CONTINUE
      DO 25 I = 1,N
         READ(IREADB,17) (IB(J),J=1,N) 
         DO 25 J = 1,N
   25    B(I,J) = IB(J)
   22 CONTINUE
      DO  23  I = 1,N
         DO  23  J = 1,N
           BHOLD(I,J) = B(I,J)
   23      AHOLD(I,J) = A(I,J)
      RETURN
   30 CONTINUE
      DO  40  I = 1,N
         DO  40  J = 1,N
           B(I,J) = BHOLD(I,J)
   40      A(I,J) = AHOLD(I,J)
      RETURN
   70 WRITE(IWRITE,80)
   80 FORMAT(47H0END OF DATA FOR SUBROUTINE  RMATIN(RSGREADI). /1H1)
      STOP
      END
