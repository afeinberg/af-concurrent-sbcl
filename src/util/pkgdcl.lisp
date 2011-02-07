(in-package :common-lisp-user)

(defpackage :af-concurrency.util
  (:use :cl :sb-thread :sb-ext)
  (:export
   ;; Functions
   :af/make-queue
   :af/enqueue
   :af/dequeue))
