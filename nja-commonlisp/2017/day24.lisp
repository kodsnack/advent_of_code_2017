;;;; day24.lisp

(in-package #:aoc2017.day24)

(defun parse (line)
  (destructuring-bind (a b) (mapcar #'parse-integer (ppcre:split "/" line))
    (cons a b)))

(defun connects? (port component)
  (or (eql (car component) port)
      (eql (cdr component) port)))

(defun other-port (port component)
  (if (eql port (car component))
      (cdr component)
      (car component)))

(defun strength (component)
  (+ (car component) (cdr component)))

(defun connections (port components)
  (remove-if-not (lambda (other) (connects? port other)) components))

(defun strongest-bridge (port component components)
  (+ (strength component)
     (apply #'max 0
            (mapcar (lambda (connection)
                      (strongest-bridge
                       (other-port port connection)
                       connection
                       (remove connection components :count 1)))
                    (connections port components)))))

(defun part1 (input)
  (strongest-bridge 0 (cons 0 0) (mapcar #'parse (aoc:lines input))))

(defun longest-bridge (length port component components)
  (destructuring-bind (longest strength)
      (first (sort (cons (list length 0)
                         (mapcar (lambda (connection)
                                   (longest-bridge
                                    (1+ length)
                                    (other-port port connection)
                                    connection
                                    (remove connection components :count 1)))
                                 (connections port components)))
                   (lambda (x y)
                     (if (= (first x) (first y))
                         (> (second x) (second y))
                         (> (first x) (first y))))))
    (list longest (+ (strength component) strength))))

(defun part2 (input)
  (second (longest-bridge 0 0 (cons 0 0) (mapcar #'parse (aoc:lines input)))))
