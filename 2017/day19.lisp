;;;; day19.lisp

(in-package #:aoc2017.day19)

(defun grid (lines)
  (make-array (list (length lines)
                    (length (first lines)))
              :initial-contents lines
              :element-type 'standard-char))

(defun start (grid)
  (loop for i from 0
        when (char= #\| (aref grid 0 i))
          return (list 0 i)))

(defun turns (direction)
  (list (reverse direction)
        (mapcar #'- (reverse direction))))

(defun add (a b)
  (mapcar #'+ a b))

(defun char-at (grid pos)
  (when (and (< -1 (first pos) (array-dimension grid 0))
             (< -1 (second pos) (array-dimension grid 1)))
    (apply #'aref grid pos)))

(defun turn-for (char)
  (char= #\+ char))

(defun stop-for (char)
  (cond ((or (alpha-char-p char) (turn-for char) (char= #\Space char))
         t)
        ((find char "-|")
         nil)
        (t (error "char ~a" char))))

(defun next-direction (grid direction from)
  (if (turn-for (char-at grid from))
      (flet ((walkable (new-direction)
               (let ((char (char-at grid (add from new-direction))))
                 (or (alpha-char-p char)
                     (find char "-|")))))
        (car (remove-if-not #'walkable (turns direction))))
      (unless (char= #\Space (char-at grid (add from direction)))
        direction)))

(defun leg (grid direction from)
  (loop for pos = (add from direction) then (add pos direction)
        for char = (char-at grid pos)
        for steps from 1
        until (stop-for char)
        finally (return
                  (values char (next-direction grid direction pos) pos steps))))

(defun walk (grid)
  (loop for (char direction pos steps) = (multiple-value-list
                                          (leg grid '(1 0) (start grid)))
          then (multiple-value-list (leg grid direction pos))
        for total-steps = steps then (+ steps total-steps)
        with chars = nil
        when (alpha-char-p char) do (push char chars)
        while direction
        finally (return (values (nreverse chars) (1+ total-steps)))))

(defun part1 (input)
  (coerce (walk (grid (aoc:lines input))) 'string))

(defun part2 (input)
  (nth-value 1 (walk (grid (aoc:lines input)))))
