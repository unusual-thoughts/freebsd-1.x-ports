1                    EXPLANATION OF COLUMN ENTRIES FOR THE SUMMARY STATISTICS

 -----------------------------------------------------------------------------------------------
 ORDER TQL2   TQLRAT IMTQL2 IMTQL1    LB      UB    M  IMTQLV   TSTURM   BISECT  M1 NO  TRIDIB  
 -----------------------------------------------------------------------------------------------

 UNDER 'ORDER' IS THE ORDER OF EACH TEST MATRIX SYSTEM.

 UNDER 'TQL2   TQLRAT' ARE THREE NUMBERS.  THE FIRST NUMBER, AN INTEGER, IS THE ABSOLUTE SUM OF
 THE ERROR FLAGS RETURNED SEPARATELY FROM  TQL2  AND  TQLRAT.  THE SECOND NUMBER IS THE MEASURE
 OF PERFORMANCE BASED UPON THE RESIDUAL COMPUTED FOR THE  TQL2  PATH.  THE THIRD NUMBER
 MEASURES THE AGREEMENT OF THE EIGENVALUES FROM THE  TQL2  AND  TQLRAT  PATHS.

 UNDER 'IMTQL2 IMTQL1' ARE THREE NUMBERS WITH MEANING LIKE THOSE UNDER  'TQL2   TQLRAT'.       

 UNDER 'LB' AND 'UB' ARE THE INPUT VARIABLES SPECIFYING THE INTERVAL TO  BISECT  AND  TSTURM.  

 UNDER 'M' IS THE NUMBER OF EIGENVALUES DETERMINED BY  BISECT  AND  TSTURM  THAT LIE IN THE    
 INTERVAL (LB,UB).

 UNDER EACH OF 'IMTQLV', 'TSTURM', 'BISECT', AND 'TRIDIB' ARE TWO NUMBERS.  THE FIRST NUMBER,  
 AN INTEGER, IS THE ABSOLUTE SUM OF THE ERROR FLAGS RETURNED FROM THE RESPECTIVE PATH.         
 THE SECOND NUMBER IS THE MEASURE OF PERFORMANCE BASED UPON THE RESIDUAL COMPUTED FOR THE PATH.

 UNDER 'M1' AND 'NO' ARE THE VARIABLES SPECIFYING THE LOWER BOUNDANY INDEX AND THE NUMBER      
 OF EIGENVALUES TO  TRIDIB. 

 -1.0  AS THE MEASURE OF PERFORMANCE IS PRINTED IF AN ERROR IN THE CORRESPONDING PATH HAS
 PREVENTED THE COMPUTATION OF THE EIGENVECTORS OR VALUES.

 THE  TQL2    PATH USES THE EISPACK CODES   REDUC2-TRED2-TQL2  -REBAK ,
 AS CALLED FROM DRIVER SUBROUTINE  RSGAB.
 THE  TQLRAT  PATH USES THE EISPACK CODES   REDUC2-TRED1-TQLRAT,
 AS CALLED FROM DRIVER SUBROUTINE  RSGAB.
 THE  IMTQL2  PATH USES THE EISPACK CODES   REDUC2-TRED2-IMTQL2-REBAK .
 THE  IMTQL1  PATH USES THE EISPACK CODES   REDUC2-TRED1-IMTQL1.
 THE  IMTQLV  PATH USES THE EISPACK CODES   REDUC2-TRED1-IMTQLV-TINVIT-TRBAK1-REBAK. 
 THE  TSTURM  PATH USES THE EISPACK CODES   REDUC2-TRED1-TSTURM-TRBAK1-REBAK .
 THE  BISECT  PATH USES THE EISPACK CODES   REDUC2-TRED1-BISECT-TINVIT-TRBAK1-REBAK. 
 THE  TRIDIB  PATH USES THE EISPACK CODES   REDUC2-TRED1-TRIDIB-TINVIT-TRBAK1-REBAK. 
 D.P. VERSION 04/15/83
1       TABULATION OF THE ERROR FLAG  ERROR  AND THE MEASURE OF PERFORMANCE  Y  FOR 
     THE  EISPACK  CODES.  THIS RUN DISPLAYS THESE STATISTICS FOR THE REAL SYMMETRIC
     GENERALIZED EIGENPROBLEM  A*B*X = (LAMBDA)*X .
0ORDER TQL2   TQLRAT IMTQL2 IMTQL1    LB      UB    M  IMTQLV   TSTURM   BISECT  M1 NO  TRIDIB 
   3  0  .030  .058  0  .029  .000 -1.e+30  1.e+30  3  0  .033  0  .033  0  .033  1  3  0  .033
   8  0  .029  .047  0  .060  .000 -1.e+30  1.e+30  8  0  .103  0  .031  0  .031  1  8  0  .031
  15  0  .031  .047  0  .018  .000 -1.e+30  1.e+30 15  0  .121  0  .030  0  .030  1 15  0  .030
  20  0  .031  .044  0  .017  .000 -1.e+30  1.e+30 20  0  .095  0  .032  0  .032  1 20  0  .032
   4  0  .066  .021  0  .069  .000 -1.e+30  1.e+30  4  0  .223  0  .097  0  .097  1  4  0  .097
  12  0  .018  .027  0  .019  .000 -1.e+30  1.e+30 12  0  .061  0  .021  0  .021  1 12  0  .021
   5  0  .039  .041  0  .027  .000 -1.e+30  1.e+30  5  0  .034  0  .014  0  .014  1  5  0  .014
  10  0  .032  .011  0  .040  .000 -1.e+30  1.e+30 10  0  .162  0  .029  0  .029  1 10  0  .029
   6  0  .070  .059  0  .029  .000 -1.e+30  1.e+30  6  0  .064  0  .058  0  .058  1  6  0  .058
   5  0  .055  .022  0  .072  .000 -1.e+30  1.e+30  5  0  .068  0  .068  0  .068  1  5  0  .068
   3  0  .000  .000  0  .000  .000 -1.e+30  1.e+30  3  0  .000  0  .000  0  .000  1  3  0  .000
  20  0  .019  .022  0  .029  .000 -1.e+30  1.e+30 20  0  .212  0  .021  0  .021  1 20  0  .021
   3  0  .091  .015  0  .056  .000 -1.e+30  1.e+30  3  0  .069  0  .075  0  .075  1  3  0  .075
   5  0  .034  .050  0  .047  .000 -1.e+30  1.e+30  5  0  .053  0  .023  0  .023  1  5  0  .023
   8  0  .037  .042  0  .021  .000 -1.e+30  1.e+30  8  0  .044  0  .029  0  .029  1  8  0  .029
   3  0  .045  .024  0  .029  .000 -1.e+30  1.e+30  3  0  .045  0  .025  0  .025  1  3  0  .025
   4  0  .067  .021  0  .063  .000 -1.e+30  1.e+30  4  0  .047  0  .095  0  .095  1  4  0  .095
   6  0  .037  .060  0  .033  .000 -1.e+30  1.e+30  6  0  .041  0  .040  0  .040  1  6  0  .040
   8  0  .087  .002  0  .087  .000 -1.e+30  1.e+30  8  0  .116  0  .116  0  .116  1  8  0  .116
   4  0  .065  .046  0  .098  .000 -1.e+30  1.e+30  4  0  .351  0  .227  0  .227  1  4  0  .227
   5  0  .044  .021  0  .062  .000 -1.e+30  1.e+30  5  0  .137  0  .046  0  .046  1  5  0  .046
0END OF DATA FOR SUBROUTINE  RMATIN(RSGREADI). 
1
