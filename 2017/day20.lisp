;;;; day20.lisp

(in-package #:aoc2017.day20)

(defun integers (string)
  (mapcar #'parse-integer (ppcre:split "," string)))

(defun parse (line)
  (ppcre:register-groups-bind (p v a)
      ("p=<([0-9,\\-]+)>, v=<([0-9,-]+)>, a=<([0-9,-]+)>" line)
    (list (integers p) (integers v) (integers a))))

(defun particles (input)
  (loop for i from 0
        for line in (aoc:lines input)
        collect (cons i (parse line))))

(defun id (particle) (first particle))
(defun pos (particle) (second particle))
(defun vel (particle) (third particle))
(defun acc (particle) (fourth particle))

(defun total (list) (reduce #'+ (mapcar #'abs list)))
(defun total-acc (particle) (total (acc particle)))
(defun total-vel (particle) (total (vel particle)))
(defun total-pos (particle) (total (pos particle)))

(defun min-accelerators (particles)
  (let ((min-acc (apply #'min (mapcar #'total-acc particles))))
    (assert (< 0 min-acc))
    (values (remove min-acc particles
                    :key #'total-acc
                    :test #'<))))

(defun add (a b)
  (mapcar #'+ a b))

(defun update (particle)
  (let ((vel (add (vel particle) (acc particle))))
    (list (id particle)
          (add (pos particle) vel)
          vel
          (acc particle))))

(defun tick (particles)
  (mapcar #'update particles))

(defun stable (particle)
  (and (< (/ (total-acc particle) (total-vel particle)) 1/100)
       (< (/ (total-vel particle) (total-pos particle) 1/100))))

(defun stabilize (particles update)
  (loop for p = particles then (funcall update p)
        until (every #'stable p)
        finally (return p)))

(defun part1 (input)
  (caar (sort (stabilize (min-accelerators (particles input)) #'tick)
              #'<
              :key #'total-pos)))

(defun pos-sort (particles)
  (sort (copy-list particles) #'< :key #'total-pos))

(defun collide (particles)
  (loop with collided = nil
        for (a b) on (pos-sort particles)
        when (equal (pos a) (pos b))
          do (pushnew a collided)
             (pushnew b collided)
        finally (return (set-difference particles collided))))

(defun part2 (input)
  (length (stabilize (particles input)
                     (alexandria:compose #'collide #'tick))))
