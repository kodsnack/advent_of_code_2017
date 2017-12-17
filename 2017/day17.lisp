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

(defun value-after-zero (step-size n)
  (declare (optimize speed)
           (type fixnum step-size n))
  (loop with value fixnum = 0
        for i fixnum from 1
        for pos fixnum = 0 then (mod (+ pos step-size 1) i)
        when (zerop pos) do (setf value i)
        repeat n
        finally (return value)))

(defun part2 (input)
  (value-after-zero input 50000000))
