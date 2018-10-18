#|

MANOEL VILELA © 2018

MULTIPLE LINEAR REGRESSION ALGORITHM FROM SCRATCH.

FOR EDUCATIONAL PURPOSES.

|#

(defpackage :linear-regression
  (:use :cl :cl-user)
  (:export
   :coefs
   :main))

(in-package :linear-regression)

(defparameter X #2A((1 3)
                    (2 5)
                    (4 7)))

(defparameter Y #2A((4)
                    (7)
                    (11)))

(defun transpose (matrix)
  "Calculate the transposed matrix."
  (let* ((dim (array-dimensions matrix))
         (trans-dim (reverse dim))
         (transposed (make-array trans-dim)))
    (loop for i from 0 below (car dim)
          do (loop for j from 0 below (cadr dim)
                   do (setf (aref transposed j i) (aref matrix i j)))
          finally (return transposed))))


(defun matrix* (A B)
  "Performs a matrix multiplication between A and B if possible,
  otherwise returns NIL."
  (let ((m-a (array-dimension A 0))
        (n-a (array-dimension A 1))
        (m-b (array-dimension B 0))
        (n-b (array-dimension B 1)))
    (when (= n-a m-b)
      (let ((C (make-array (list m-a n-b))))
        (loop for i from 0 below m-a
              do (loop for j from 0 below n-b
                       do (setf (aref C i j)
                                (loop for k from 0 below n-a
                                      sum (* (aref A i k)
                                             (aref B k j)))))
              finally (return C))))))

(defun scale (const matrix)
  "Scale a MATRIX 2D to a CONST."
  (loop with m = (array-dimension matrix 0)
        with n = (array-dimension matrix 1)
        with output-matrix = (make-array (list m n))
        for i from 0 below m
        do (loop for j from 0 below n
                 do (setf (aref output-matrix i j)
                          (* const (aref matrix i j))))
        finally (return output-matrix)))


(defun reduced-matrix (matrix i j)
  "New matrix with I line and J column eliminated"
  ;;; 0 | 0 0
  ;;; - | - -
  ;;; 0 | 0 0
  ;;; 0 | 0 0

  ;;; The cross line/column is removed

  (let* ((m (array-dimension matrix 0))
         (n (array-dimension matrix 1))
         (new-matrix (make-array (list (1- m) (1- n)))))
    (loop for x from 0 below m
          do (loop for y from 0 below n
                   for x_i = x
                   for y_j = y
                   when (> x_i i)
                     do (decf x_i)
                   end
                   when (> y_j j)
                     do (decf y_j)
                   end
                   when (not (or (= x i)
                                 (= y j)))
                     do (setf (aref new-matrix x_i y_j)
                              (aref matrix x y))
                   end)
          finally (return new-matrix))))


(defun cofactor (X i j)
  "Return the cofactor of the matrix X => X(i,y)"
  (* (expt -1 (+ i j))
     (det (reduced-matrix X i j))))


(defun adj (X)
  "Calculate the adjunct matrix of X"
  (destructuring-bind (m n) (array-dimensions X)
    (loop with C = (make-array (list m n))
          for i from 0 below m
          do (loop for j from 0 below n
                   do (setf (aref C i j)
                            (cofactor X i j)))
          finally (return (transpose C)))))


(defun det (X)
  "Calculate the determinant of X applying the Laplace's Theorem
   This have a complexity of O(n!), be careful, CPU-bound procedure.
   FIXME: Implement Gauss-Elimination determinant O(n³)."
  (let* ((dims (array-dimensions X))
         (lines (car dims)))
    (when (apply #'= dims)
      (case (car dims)
        (1 (aref X 0 0))
        (2 (- (* (aref X 0 0) (aref X 1 1))
              (* (aref X 0 1) (aref X 1 0))))
        (otherwise (loop for k from 0 below lines
                         sum (* (aref X k 0)
                                (cofactor X k 0))))))))



(defun inverse (matrix)
  "Inverse of MATRIX"
  (scale (/ 1 (det matrix)) (adj matrix)))


(defun add-ones (X)
  "Add first column as bunch of ones."
  (destructuring-bind (m n) (array-dimensions X)
    (let ((Y (make-array (list m (1+ n)) :initial-element 1)))
      (loop for i from 0 below m
            do (loop for j from 0 below n
                     do (setf (aref Y i (1+ j))
                              (aref X i j)))
            finally (return Y)))))


(defun beta-estimator (X Y)
  "Calculate the estimator as Ŷ = Xβ + e as β = (X'X)-¹X'Y"
  (let ((X1 (add-ones X))
        (Y1 (loop with dims = (array-dimensions Y)
                  with Y-copy = (make-array dims)
                  with n = (apply #'* dims)
                  for i from 0 below n
                  do (setf (row-major-aref Y-copy i)
                           (1+ (row-major-aref Y i)))
                  finally (return Y-copy))))
      (matrix* (matrix* (inverse (matrix* (transpose X1) X1))
                        (transpose X1))
               Y1)))

(defun coefs (X Y)
  "Return the coefficients for estimators of X and Y data as LIST."
  (let* ((beta (beta-estimator X Y))
         (n (array-dimension beta 0)))
    (loop for i from 0 below n
          collect (aref beta i 0))))


(defun main ()
  (let* ((b (coefs X Y))
         (parts (mapcar (lambda (x)
                          (format nil "(~a)*X~a" (car x) (cdr x)))
                        (loop for i in (cdr b)
                              for j from 1
                              collect (cons i j)))))
    (format t "~:{B~a=~a~%~^~}~%" (loop for i from 0
                                        for j in b
                                        collect (list i j)))
    (format t "Ŷ = (~a) + ~{~a~^ + ~}~%" (car b) parts)))


(eval-when (:execute)
  (main))
