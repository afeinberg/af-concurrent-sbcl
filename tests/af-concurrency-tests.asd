(asdf:defsystem :af-concurrency-tests
  :description "Concurrency test suite."
  :author "Alex Feinberg <alex@strlen.net>"
  :version "0.0.1"
  :license "MIT"
  :depends-on (:fiveam :af-concurrency)
  :components
  ((:file "pkgdcl")
   (:file "defsuites" :depends-on ("pkgdcl"))
   (:file "utils" :depends-on ("pkgdcl" "defsuites"))
   (:file "blocking" :depends-on ("pkgdcl" "defsuites"))
   (:file "atomic" :depends-on ("pkgdcl" "defsuites"))))

(defmethod perform ((o test-op)
                    (c (eql (find-system :af-concurrency-tests))))
  (operate 'load-op :af-concurrency-tests)
  (funcall (intern (symbol-name '#:run!) '#:5am) :af-concurrency))

(defmethod operation-done-p ((o test-op)
                             (c (eql (find-system :af-concurrency-tests))))
  nil)