(asdf:defsystem :af-concurrency.atomic
  :description "Atomic operations using memory barries and cas"
  :author "Alex Feinberg <alex@strlen.net>"
  :maintainer "Alex Feinberg <alex@strlen.net>"
  :version "0.0.1"
  :license "MIT"
  :pathname "atomic/"
  :components
  ((:file "pkgdcl")
   (:file "atomic-boolean" :depends-on ("pkgdcl"))))
