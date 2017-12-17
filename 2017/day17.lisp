 ;;;; day17.lisp

(in-package #:aoc2017.day17)

(defun circular-buffer (value)
  (alexandria:circular-list value))

(defun circular-insert-after (buffer value)
  (cdr (rplacd buffer (cons value (cdr buffer)))))

(defun spinlock (step-size)
  (declare (optimize speed))
  (let ((pos (circular-buffer 0))
        (value 0))
    (declare (type fixnum value)
             (type cons pos))
    (lambda ()
      (setf pos (circular-insert-after (nthcdr step-size pos) (incf value))))))

(defun spin (spinlock n)
  (declare (optimize speed)
           (type fixnum n)
           (type function spinlock))
  (loop repeat n
        for pos = (funcall spinlock)
        finally (return (values pos spinlock))))

(defun part1 (input)
  (cadr (spin (spinlock input) 2017)))

(defun circular-insert-before (buffer value)
  (declare (optimize speed))
  (rplacd buffer (cons (car buffer) (cdr buffer)))
  (rplaca buffer value))

(defun insert (vector value i)
  (declare (type (vector fixnum) vector)
           (type fixnum value i)
           (optimize speed))
  (loop for j downfrom (vector-push value vector) to (1+ i)
        do (rotatef (aref vector j) (aref vector (1- j)))
        finally (return vector)))

(defun make-chunk ()
  (make-array 1024
              :element-type 'fixnum
              :fill-pointer 0))

(defun split (vector i)
  (declare (optimize speed)
           (type (vector fixnum) vector)
           (type fixnum i))
  (let ((before (the (vector fixnum) (make-chunk))))
    (loop for j from 0 below i
          do (setf (aref before j) (aref vector j)))
    (loop for j from i below (length vector)
          for k from 0
          do (setf (aref vector k) (aref vector j)))
    (setf (fill-pointer before) i
          (fill-pointer vector) (- (length vector) i))
    (values before vector)))

(defun spinlock* (step-size)
  (declare (optimize speed)
           (type fixnum step-size))
  (let ((pos (circular-buffer (make-chunk)))
        (i 0)
        (value 0))
    (declare (type fixnum i value)
             (type cons pos))
    (symbol-macrolet ((chunk (the (vector fixnum) (car pos))))
      (insert chunk value i)
      (labels ((advance ()
                 (loop until (<= i (fill-pointer chunk))
                       do (decf i (fill-pointer chunk))
                          (setf pos (cdr pos)))))
        (lambda ()
          (incf i (1+ step-size))
          (incf value)
          (advance)
          (when (= (fill-pointer chunk) (array-total-size chunk))
            (circular-insert-before
             pos (split chunk (truncate (array-total-size chunk) 2)))
            (advance))
          (insert chunk value i)
          (values pos i))))))

(defun number-after (buffer number)
  (loop for pos = buffer then (cdr pos)
        for chunk = (car pos)
        for i = (position number chunk)
        when i return (or (and (< (1+ i) (length chunk)) (aref chunk (1+ i)))
                          (aref (cadr pos) 0))
        until (eq (cdr pos) buffer)))

(defun part2 (input)
  (number-after (spin (spinlock* input) 50000000 ) 0))
