;;;; day18.lisp

(in-package #:aoc2017.day18)

(defun string-symbol (string symbols)
  (find (string-upcase string) symbols
        :test #'equal
        :key #'symbol-name))

(defun parse (line)
  (ppcre:register-groups-bind (opcode x y)
      ("^(snd|set|add|mul|mod|rcv|jgz) ([a-z]|[0-9]+)(?: ([a-z]|-?[0-9]+))?$"
       line)
    (let ((opcode (string-symbol opcode '(snd set add mul mod rcv jgz))))
      (labels ((register (r) (string-symbol r '(a b c d e f i p)))
               (integer (i) (parse-integer i))
               (value (s) (or (register s) (integer s))))
        (cons opcode
              (ecase opcode
                ((snd rcv) (list (value x)))
                ((set add mul mod) (list (register x) (value y)))
                (jgz (list (value x) (value y)))))))))

(defun registers (instructions)
  (remove-duplicates
   (remove-if-not (lambda (x) (and x (symbolp x)))
                  (append (mapcar #'second instructions)
                          (mapcar #'third instructions)))))

(defun sound (instructions)
  (let ((values (loop for register in (registers instructions)
                      nconc (list register 0)))
        (pc 0)
        sound)
    (labels ((value (x) (or (when (integerp x) x) (getf values x)))
             (set-value (x value) (setf (getf values x) value))
             (execute (instruction)
               (let ((opcode (first instruction))
                     (x (second instruction))
                     (y (third instruction))
                     (pci 1))
                 (ecase opcode
                   (snd (setf sound (value x)))
                   (set (set-value x (value y)))
                   (add (set-value x (+ (value x) (value y))))
                   (mul (set-value x (* (value x) (value y))))
                   (mod (set-value x (mod (value x) (value y))))
                   (jgz (when (< 0 (value x)) (setf pci (value y))))
                   (rcv (when (/= 0 (value x)) (return-from execute sound))))
                 (incf pc pci)
                 nil)))
      (loop when (execute (elt instructions pc)) return it))))

(defun part1 (input)
  (sound (mapcar #'parse (aoc:lines input))))

(defun program (pid instructions)
  (let ((values (loop for register in (registers instructions)
                      nconc (list register (if (eq register 'p)
                                               pid
                                               0))))
        (pc 0))
    (labels ((value (x) (or (when (integerp x) x) (getf values x)))
             (set-value (x value) (setf (getf values x) value))
             (execute (snd rcv)
               (let* ((instruction (nth pc instructions))
                      (opcode (first instruction))
                      (x (second instruction))
                      (y (third instruction))
                      (pci 1))
                 (ecase opcode
                   (snd (funcall snd (value x)))
                   (set (set-value x (value y)))
                   (add (set-value x (+ (value x) (value y))))
                   (mul (set-value x (* (value x) (value y))))
                   (mod (set-value x (mod (value x) (value y))))
                   (jgz (when (< 0 (value x)) (setf pci (value y))))
                   (rcv (let ((received (funcall rcv)))
                          (if received
                              (set-value x received)
                              (return-from execute)))))
                 (incf pc pci))))
      (lambda (snd rcv) (loop while (execute snd rcv))))))

(defun parallel (instructions)
  (loop with p0 = (program 0 instructions)
        with q0 = (make-queue :simple-queue)
        with p1 = (program 1 instructions)
        with q1 = (make-queue :simple-queue)
        with p1-count = 0
        with p0-waiting
        with p1-waiting
        do (funcall p0
                    (lambda (x)
                      (setf p1-waiting nil)
                      (qpush q1 x))
                    (lambda ()
                      (or (qpop q0)
                          (not (setf p0-waiting t)))))
           (funcall p1
                    (lambda (x)
                      (incf p1-count)
                      (setf p0-waiting nil)
                      (qpush q0 x))
                    (lambda ()
                      (or (qpop q1)
                          (not (setf p1-waiting t)))))
        until (and p0-waiting p1-waiting)
        finally (return p1-count)))

(defun part2 (input)
  (parallel (mapcar #'parse (aoc:lines input))))
