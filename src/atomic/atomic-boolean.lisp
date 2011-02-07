(in-package :af-concurrency.atomic)

(defmacro bool->int (b)
  `(if ,b
       1
       0))

(defmacro int->bool (i)
  `(= 1 ,i))

(defun make-atomic-boolean (&optional (initial nil))
  (list 
     (bool->int initial)))

(defun atomic-boolean-get (ab)
  (barrier (:memory)
    (int->bool (car ab))))

(defun atomic-boolean-set (new-value ab)
  (barrier (:memory)
    (setf (car ab)
          (bool->int new-value))))

(defun atomic-boolean-cas (expect update ab)
  (let ((e (bool->int expect))
        (u (bool->int update)))
    (= e (compare-and-swap (car ab) e u))))

(defun atomic-boolean-get-and-set (new-value ab)
  (loop
     for current = (atomic-boolean-get ab)
     when (atomic-boolean-cas current new-value ab)
     return current))

