(asdf:defsystem :af-concurrency.blocking
    :description "Blocking concurrency utilities"
    :author "Alex Feinberg <alex@strlen.net>"
    :maintainer "Alex Feinberg <alex@strlen.net>"
    :version "0.0.1"
    :license "MIT"
    :depends-on (:af-concurrency.util)
    :pathname "blocking/"
    :components
    ((:file "pkgdcl")
     (:file "blocking-queue" :depends-on ("pkgdcl"))))
