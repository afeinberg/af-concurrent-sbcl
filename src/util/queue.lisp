;; Packaged version of singly-linked list based FIFO queue described
;; by Paul Graham in Ansi Common Lisp. Functions names changed not to
;; conflict with the lock free queue in sb-concurrency.

;; Taken from
;; http://cs.northwestern.edu/academics/courses/325/programs/graham.lisp

;; Changes from original version: fixed a leak found by Matt Knox. 

(in-package :af-concurrency.util)

(defun af/make-queue () (cons nil nil))

(defun af/enqueue (o q)
  (if (null (car q))
      (setf (cdr q) (setf (car q) (list o)))
      (setf (cdr (cdr q)) (list o)
            (cdr q) (cdr (cdr q))))
  (car q))

(defun af/dequeue (q)
  (let ((val (pop (car q))))
    (when (null (car q))
      (setf (cdr q) nil))
    val))
