      SUBROUTINE DQK51(F,A,B,RESULT,ABSERR,RESABS,RESASC)
C***BEGIN PROLOGUE  DQK51
C***DATE WRITTEN   800101   (YYMMDD)
C***REVISION DATE  830518   (YYMMDD)
C***CATEGORY NO.  H2A1A2
C***KEYWORDS  51-POINT GAUSS-KRONROD RULES
C***AUTHOR  PIESSENS,ROBERT,APPL. MATH. & PROGR. DIV. - K.U.LEUVEN
C           DE DONCKER,ELISE,APPL. MATH & PROGR. DIV. - K.U.LEUVEN
C***PURPOSE  TO COMPUTE I = INTEGRAL OF F OVER (A,B) WITH ERROR
C                           ESTIMATE
C                       J = INTEGRAL OF ABS(F) OVER (A,B)
C***DESCRIPTION
C
C           INTEGRATION RULES
C           STANDARD FORTRAN SUBROUTINE
C           DOUBLE PRECISION VERSION
C
C           PARAMETERS
C            ON ENTRY
C              F      - DOUBLE PRECISION
C                       FUNCTION SUBROUTINE DEFINING THE INTEGRAND
C                       FUNCTION F(X). THE ACTUAL NAME FOR F NEEDS TO BE
C                       DECLARED E X T E R N A L IN THE CALLING PROGRAM.
C
C              A      - DOUBLE PRECISION
C                       LOWER LIMIT OF INTEGRATION
C
C              B      - DOUBLE PRECISION
C                       UPPER LIMIT OF INTEGRATION
C
C            ON RETURN
C              RESULT - DOUBLE PRECISION
C                       APPROXIMATION TO THE INTEGRAL I
C                       RESULT IS COMPUTED BY APPLYING THE 51-POINT
C                       KRONROD RULE (RESK) OBTAINED BY OPTIMAL ADDITION
C                       OF ABSCISSAE TO THE 25-POINT GAUSS RULE (RESG).
C
C              ABSERR - DOUBLE PRECISION
C                       ESTIMATE OF THE MODULUS OF THE ABSOLUTE ERROR,
C                       WHICH SHOULD NOT EXCEED ABS(I-RESULT)
C
C              RESABS - DOUBLE PRECISION
C                       APPROXIMATION TO THE INTEGRAL J
C
C              RESASC - DOUBLE PRECISION
C                       APPROXIMATION TO THE INTEGRAL OF ABS(F-I/(B-A))
C                       OVER (A,B)
C
C***REFERENCES  (NONE)
C***ROUTINES CALLED  D1MACH
C***END PROLOGUE  DQK51
C
      DOUBLE PRECISION A,ABSC,ABSERR,B,CENTR,DABS,DHLGTH,DMAX1,DMIN1,
     *  D1MACH,EPMACH,F,FC,FSUM,FVAL1,FVAL2,FV1,FV2,HLGTH,RESABS,RESASC,
     *  RESG,RESK,RESKH,RESULT,UFLOW,WG,WGK,XGK
      INTEGER J,JTW,JTWM1
      EXTERNAL F
C
      DIMENSION FV1(25),FV2(25),XGK(26),WGK(26),WG(13)
C
C           THE ABSCISSAE AND WEIGHTS ARE GIVEN FOR THE INTERVAL (-1,1).
C           BECAUSE OF SYMMETRY ONLY THE POSITIVE ABSCISSAE AND THEIR
C           CORRESPONDING WEIGHTS ARE GIVEN.
C
C           XGK    - ABSCISSAE OF THE 51-POINT KRONROD RULE
C                    XGK(2), XGK(4), ...  ABSCISSAE OF THE 25-POINT
C                    GAUSS RULE
C                    XGK(1), XGK(3), ...  ABSCISSAE WHICH ARE OPTIMALLY
C                    ADDED TO THE 25-POINT GAUSS RULE
C
C           WGK    - WEIGHTS OF THE 51-POINT KRONROD RULE
C
C           WG     - WEIGHTS OF THE 25-POINT GAUSS RULE
C
C
C GAUSS QUADRATURE WEIGHTS AND KRONRON QUADRATURE ABSCISSAE AND WEIGHTS
C AS EVALUATED WITH 80 DECIMAL DIGIT ARITHMETIC BY L. W. FULLERTON,
C BELL LABS, NOV. 1981.
C
      DATA WG  (  1) / 0.0113937985 0102628794 7902964113 235 D0 /
      DATA WG  (  2) / 0.0263549866 1503213726 1901815295 299 D0 /
      DATA WG  (  3) / 0.0409391567 0130631265 5623487711 646 D0 /
      DATA WG  (  4) / 0.0549046959 7583519192 5936891540 473 D0 /
      DATA WG  (  5) / 0.0680383338 1235691720 7187185656 708 D0 /
      DATA WG  (  6) / 0.0801407003 3500101801 3234959669 111 D0 /
      DATA WG  (  7) / 0.0910282619 8296364981 1497220702 892 D0 /
      DATA WG  (  8) / 0.1005359490 6705064420 2206890392 686 D0 /
      DATA WG  (  9) / 0.1085196244 7426365311 6093957050 117 D0 /
      DATA WG  ( 10) / 0.1148582591 4571164833 9325545869 556 D0 /
      DATA WG  ( 11) / 0.1194557635 3578477222 8178126512 901 D0 /
      DATA WG  ( 12) / 0.1222424429 9031004168 8959518945 852 D0 /
      DATA WG  ( 13) / 0.1231760537 2671545120 3902873079 050 D0 /
C
      DATA XGK (  1) / 0.9992621049 9260983419 3457486540 341 D0 /
      DATA XGK (  2) / 0.9955569697 9049809790 8784946893 902 D0 /
      DATA XGK (  3) / 0.9880357945 3407724763 7331014577 406 D0 /
      DATA XGK (  4) / 0.9766639214 5951751149 8315386479 594 D0 /
      DATA XGK (  5) / 0.9616149864 2584251241 8130033660 167 D0 /
      DATA XGK (  6) / 0.9429745712 2897433941 4011169658 471 D0 /
      DATA XGK (  7) / 0.9207471152 8170156174 6346084546 331 D0 /
      DATA XGK (  8) / 0.8949919978 7827536885 1042006782 805 D0 /
      DATA XGK (  9) / 0.8658470652 9327559544 8996969588 340 D0 /
      DATA XGK ( 10) / 0.8334426287 6083400142 1021108693 570 D0 /
      DATA XGK ( 11) / 0.7978737979 9850005941 0410904994 307 D0 /
      DATA XGK ( 12) / 0.7592592630 3735763057 7282865204 361 D0 /
      DATA XGK ( 13) / 0.7177664068 1308438818 6654079773 298 D0 /
      DATA XGK ( 14) / 0.6735663684 7346836448 5120633247 622 D0 /
      DATA XGK ( 15) / 0.6268100990 1031741278 8122681624 518 D0 /
      DATA XGK ( 16) / 0.5776629302 4122296772 3689841612 654 D0 /
      DATA XGK ( 17) / 0.5263252843 3471918259 9623778158 010 D0 /
      DATA XGK ( 18) / 0.4730027314 4571496052 2182115009 192 D0 /
      DATA XGK ( 19) / 0.4178853821 9303774885 1814394594 572 D0 /
      DATA XGK ( 20) / 0.3611723058 0938783773 5821730127 641 D0 /
      DATA XGK ( 21) / 0.3030895389 3110783016 7478909980 339 D0 /
      DATA XGK ( 22) / 0.2438668837 2098843204 5190362797 452 D0 /
      DATA XGK ( 23) / 0.1837189394 2104889201 5969888759 528 D0 /
      DATA XGK ( 24) / 0.1228646926 1071039638 7359818808 037 D0 /
      DATA XGK ( 25) / 0.0615444830 0568507888 6546392366 797 D0 /
      DATA XGK ( 26) / 0.0000000000 0000000000 0000000000 000 D0 /
C
      DATA WGK (  1) / 0.0019873838 9233031592 6507851882 843 D0 /
      DATA WGK (  2) / 0.0055619321 3535671375 8040236901 066 D0 /
      DATA WGK (  3) / 0.0094739733 8617415160 7207710523 655 D0 /
      DATA WGK (  4) / 0.0132362291 9557167481 3656405846 976 D0 /
      DATA WGK (  5) / 0.0168478177 0912829823 1516667536 336 D0 /
      DATA WGK (  6) / 0.0204353711 4588283545 6568292235 939 D0 /
      DATA WGK (  7) / 0.0240099456 0695321622 0092489164 881 D0 /
      DATA WGK (  8) / 0.0274753175 8785173780 2948455517 811 D0 /
      DATA WGK (  9) / 0.0307923001 6738748889 1109020215 229 D0 /
      DATA WGK ( 10) / 0.0340021302 7432933783 6748795229 551 D0 /
      DATA WGK ( 11) / 0.0371162714 8341554356 0330625367 620 D0 /
      DATA WGK ( 12) / 0.0400838255 0403238207 4839284467 076 D0 /
      DATA WGK ( 13) / 0.0428728450 2017004947 6895792439 495 D0 /
      DATA WGK ( 14) / 0.0455029130 4992178890 9870584752 660 D0 /
      DATA WGK ( 15) / 0.0479825371 3883671390 6392255756 915 D0 /
      DATA WGK ( 16) / 0.0502776790 8071567196 3325259433 440 D0 /
      DATA WGK ( 17) / 0.0523628858 0640747586 4366712137 873 D0 /
      DATA WGK ( 18) / 0.0542511298 8854549014 4543370459 876 D0 /
      DATA WGK ( 19) / 0.0559508112 2041231730 8240686382 747 D0 /
      DATA WGK ( 20) / 0.0574371163 6156783285 3582693939 506 D0 /
      DATA WGK ( 21) / 0.0586896800 2239420796 1974175856 788 D0 /
      DATA WGK ( 22) / 0.0597203403 2417405997 9099291932 562 D0 /
      DATA WGK ( 23) / 0.0605394553 7604586294 5360267517 565 D0 /
      DATA WGK ( 24) / 0.0611285097 1705304830 5859030416 293 D0 /
      DATA WGK ( 25) / 0.0614711898 7142531666 1544131965 264 D0 /
C       NOTE: WGK (26) WAS CALCULATED FROM THE VALUES OF WGK(1..25)
      DATA WGK ( 26) / 0.0615808180 6783293507 8759824240 066 D0 /
C
C
C           LIST OF MAJOR VARIABLES
C           -----------------------
C
C           CENTR  - MID POINT OF THE INTERVAL
C           HLGTH  - HALF-LENGTH OF THE INTERVAL
C           ABSC   - ABSCISSA
C           FVAL*  - FUNCTION VALUE
C           RESG   - RESULT OF THE 25-POINT GAUSS FORMULA
C           RESK   - RESULT OF THE 51-POINT KRONROD FORMULA
C           RESKH  - APPROXIMATION TO THE MEAN VALUE OF F OVER (A,B),
C                    I.E. TO I/(B-A)
C
C           MACHINE DEPENDENT CONSTANTS
C           ---------------------------
C
C           EPMACH IS THE LARGEST RELATIVE SPACING.
C           UFLOW IS THE SMALLEST POSITIVE MAGNITUDE.
C
C***FIRST EXECUTABLE STATEMENT  DQK51
      EPMACH = D1MACH(4)
      UFLOW = D1MACH(1)
C
      CENTR = 0.5D+00*(A+B)
      HLGTH = 0.5D+00*(B-A)
      DHLGTH = DABS(HLGTH)
C
C           COMPUTE THE 51-POINT KRONROD APPROXIMATION TO
C           THE INTEGRAL, AND ESTIMATE THE ABSOLUTE ERROR.
C
      FC = F(CENTR)
      RESG = WG(13)*FC
      RESK = WGK(26)*FC
      RESABS = DABS(RESK)
      DO 10 J=1,12
        JTW = J*2
        ABSC = HLGTH*XGK(JTW)
        FVAL1 = F(CENTR-ABSC)
        FVAL2 = F(CENTR+ABSC)
        FV1(JTW) = FVAL1
        FV2(JTW) = FVAL2
        FSUM = FVAL1+FVAL2
        RESG = RESG+WG(J)*FSUM
        RESK = RESK+WGK(JTW)*FSUM
        RESABS = RESABS+WGK(JTW)*(DABS(FVAL1)+DABS(FVAL2))
   10 CONTINUE
      DO 15 J = 1,13
        JTWM1 = J*2-1
        ABSC = HLGTH*XGK(JTWM1)
        FVAL1 = F(CENTR-ABSC)
        FVAL2 = F(CENTR+ABSC)
        FV1(JTWM1) = FVAL1
        FV2(JTWM1) = FVAL2
        FSUM = FVAL1+FVAL2
        RESK = RESK+WGK(JTWM1)*FSUM
        RESABS = RESABS+WGK(JTWM1)*(DABS(FVAL1)+DABS(FVAL2))
   15 CONTINUE
      RESKH = RESK*0.5D+00
      RESASC = WGK(26)*DABS(FC-RESKH)
      DO 20 J=1,25
        RESASC = RESASC+WGK(J)*(DABS(FV1(J)-RESKH)+DABS(FV2(J)-RESKH))
   20 CONTINUE
      RESULT = RESK*HLGTH
      RESABS = RESABS*DHLGTH
      RESASC = RESASC*DHLGTH
      ABSERR = DABS((RESK-RESG)*HLGTH)
      IF(RESASC.NE.0.0D+00.AND.ABSERR.NE.0.0D+00)
     *  ABSERR = RESASC*DMIN1(0.1D+01,(0.2D+03*ABSERR/RESASC)**1.5D+00)
      IF(RESABS.GT.UFLOW/(0.5D+02*EPMACH)) ABSERR = DMAX1
     *  ((EPMACH*0.5D+02)*RESABS,ABSERR)
      RETURN
      END
