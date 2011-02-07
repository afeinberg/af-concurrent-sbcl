(in-package :af-concurrency-tests)

(in-suite :af-concurrency.atomic)

(test atomic-boolean-test
  (let* ((keep-running (make-atomic-boolean t))
         (toggle-switch (make-atomic-boolean nil))
         (thread-1 (make-thread
                    (lambda ()
                      (loop
                         (unless (atomic-boolean-get keep-running)
                           (return))))))
         (thread-2 (make-thread
                    (lambda ()
                      (loop 
                         when (atomic-boolean-cas t nil toggle-switch) 
                         return
                           (atomic-boolean-get-and-set nil keep-running))))))
    (atomic-boolean-set t toggle-switch)
    (join-thread thread-2)
    (join-thread thread-1)
    (is 
     (and 
      (eq nil (atomic-boolean-get toggle-switch))
      (eq nil (atomic-boolean-get keep-running))))))
