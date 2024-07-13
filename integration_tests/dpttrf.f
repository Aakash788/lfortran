      SUBROUTINE DPTTRF(N, D, E, INFO)
*
*  -- LAPACK computational routine --
*  -- LAPACK is a software package provided by Univ. of Tennessee,    --
*  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
*
*     .. Scalar Arguments ..
      INTEGER            INFO, N
*     ..
*     .. Array Arguments ..
      DOUBLE PRECISION   D( * ), E( * )
*     ..
*
*  =====================================================================
*
*     .. Parameters ..
      DOUBLE PRECISION   ZERO
      parameter( zero = 0.0d+0 )
*     ..
*     .. Local Scalars ..
      INTEGER            I, I4
      DOUBLE PRECISION   EI
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          mod
*     ..
*     .. Executable Statements ..
*
*     Test the input parameters.
*
      info = 0
*
*     Quick return if possible
*
      IF( n.EQ.0 )
     $   RETURN
*
*     Compute the L*D*L**T (or U**T*D*U) factorization of A.
*
      i4 = mod( n-1, 4 )
      DO 10 i = 1, i4
         IF( d( i ).LE.zero ) THEN
            info = i
            GO TO 30
         END IF
         ei = e( i )
         e( i ) = ei / d( i )
         d( i+1 ) = d( i+1 ) - e( i )*ei
   10 CONTINUE
*
      DO 20 i = i4 + 1, n - 4, 4
*
*        Drop out of the loop if d(i) <= 0: the matrix is not positive
*        definite.
*
         IF( d( i ).LE.zero ) THEN
            info = i
            GO TO 30
         END IF
*
*        Solve for e(i) and d(i+1).
*
         ei = e( i )
         e( i ) = ei / d( i )
         d( i+1 ) = d( i+1 ) - e( i )*ei
*
         IF( d( i+1 ).LE.zero ) THEN
            info = i + 1
            GO TO 30
         END IF
*
*        Solve for e(i+1) and d(i+2).
*
         ei = e( i+1 )
         e( i+1 ) = ei / d( i+1 )
         d( i+2 ) = d( i+2 ) - e( i+1 )*ei
*
         IF( d( i+2 ).LE.zero ) THEN
            info = i + 2
            GO TO 30
         END IF
*
*        Solve for e(i+2) and d(i+3).
*
         ei = e( i+2 )
         e( i+2 ) = ei / d( i+2 )
         d( i+3 ) = d( i+3 ) - e( i+2 )*ei
*
         IF( d( i+3 ).LE.zero ) THEN
            info = i + 3
            GO TO 30
         END IF
*
*        Solve for e(i+3) and d(i+4).
*
         ei = e( i+3 )
         e( i+3 ) = ei / d( i+3 )
         d( i+4 ) = d( i+4 ) - e( i+3 )*ei
   20 CONTINUE
*
*     Check d(n) for positive definiteness.
*
      IF( d( n ).LE.zero )
     $   info = n
*
   30 CONTINUE
      RETURN
*
*     End of DPTTRF
*
      END SUBROUTINE

      PROGRAM MAIN
              INTEGER :: N = 3, INFO
              DOUBLE PRECISION :: D(3), E(2)
              D = [4, 5, 6]
              E = [1, 2]
              CALL DPTTRF(N, D, E, INFO)
              print *, "D: ", D
              print *, "E: ", E
              print *, "INFO: ", INFO
      END PROGRAM