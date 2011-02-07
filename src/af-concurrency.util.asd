(asdf:defsystem :af-concurrency.util
  :description "Generic utilities"
  :author "Alex Feinberg <alex@strlen.net>"
  :maintainer "Alex Feinberg <alex@strlen.net>"
  :version "0.0.1"
  :license "MIT"
  :pathname "util/"
  :components
  ((:file "pkgdcl")
   (:file "queue" :depends-on ("pkgdcl"))))

