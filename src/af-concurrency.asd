(asdf:defsystem :af-concurrency
  :description "Concurrency utility library."
  :author "Alex Feinberg <alex@strlen.net>"
  :maintainer "Alex Feinberg <alex@strlen.net>"
  :version "0.0.1"
  :license "MIT"
  :depends-on (:af-concurrency.util :af-concurrency.blocking)
  :pathname ""
  :components ((:file "pkgdcl")))

(defmethod perform ((o test-op) (c (eql (find-system :af-concurrency))))
  (oos 'test-op :af-concurrency.tests))

(defmethod operation-done-p ((o test-op) (c (eql (find-system :af-concurrency))))
  nil)
