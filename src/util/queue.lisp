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
