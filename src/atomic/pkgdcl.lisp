(in-package :common-lisp-user)

(defpackage :af-concurrency.atomic
  (:use :cl :sb-thread :sb-ext)
  (:export
   :make-atomic-boolean
   :atomic-boolean-get
   :atomic-boolean-set
   :atomic-boolean-cas
   :atomic-boolean-get-and-set))
