;;;; day10.lisp

(in-package #:aoc2016.day10)

(defclass node ()
  ((num :initarg :num :reader num)))
(defclass bot (node)
  ((lo :accessor lo-of :initform nil)
   (hi :accessor hi-of :initform nil)
   (values :accessor values-of :initform nil)))
(defclass output (node)
  ((values :accessor values-of :initform nil)))

(defmethod print-object ((object node) stream)
  (print-unreadable-object (object stream :type t)
    (princ (num object) stream)))

(defgeneric find-node (nodes what)
  (:method (nodes (what list))
    (find-if (lambda (n) (and (typep n (first what))
                              (eq (num n) (second what))))
             nodes))
  (:method (nodes (what node))
    (find what nodes)))

(defun make-node (type num)
  (make-instance type :num num))

(defun get-node (nodes id)
  (let ((node (or (find-node nodes id)
                  (apply #'make-node id))))
    (values node (pushnew node nodes))))

(defun get-nodes (nodes &rest ids)
  (values (loop for id in ids
                for (node new-nodes) = (multiple-value-list
                                        (get-node nodes id))
                do (setf nodes new-nodes)
                collect node)
          nodes))

(defun link (nodes from-id lo-id hi-id)
  (destructuring-bind ((from lo hi) nodes)
      (multiple-value-list (get-nodes nodes from-id lo-id hi-id))
    (setf (lo-of from) lo
          (hi-of from) hi)
    (forward nodes from)))

(defun input (nodes bot value)
  (multiple-value-bind (bot nodes) (get-node nodes bot)
    (assert (< (length (values-of bot)) 2))
    (push value (values-of bot))
    (forward nodes bot)))

(defun forward (nodes bot)
  (with-slots (lo hi values) bot
    (when (= 2 (length values))
      (when lo (input nodes lo (min (apply #'min values))))
      (when hi (input nodes hi (apply #'max values)))))
  nodes)

(defun id (type num)
  (list (cond ((symbolp type) type)
              ((equal "bot" type) 'bot)
              ((equal "output" type) 'output)
              (t (error "~S is neither bot nor output" type)))
        (if (integerp num)
            num
            (parse-integer num))))

(defun parse (string)
  (or (ppcre:register-groups-bind (a b c d e f)
          ("^(bot) ([0-9]+) gives low to (bot|output) ([0-9]+) and high to (bot|output) ([0-9]+)$" string)
        (list 'link (id a b) (id c d) (id e f)))
      (ppcre:register-groups-bind (a b c) ("value ([0-9]+) goes to (bot) ([0-9]+)" string)
        (list 'input (id b c) (when a (parse-integer a))))
      string))

(defun process (inputs)
  (let (nodes)
    (dolist (input inputs nodes)
      (setf nodes (apply (first input) nodes (rest input))))))

(defun part1 (input)
  (num (find '(61 17)
             (process (mapcar #'parse (aoc:lines input)))
             :key #'values-of
             :test #'equal)))

(defun part2 (input)
  (let ((nodes (process (mapcar #'parse (aoc:lines input)))))
    (apply #'* (mapcar (lambda (n)
                         (car (values-of (get-node nodes (id 'output n)))))
                       '(0 1 2)))))