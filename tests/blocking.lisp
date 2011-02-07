(in-package :af-concurrency-tests)

(in-suite :af-concurrency.blocking)

(test block-when-empty-test
  "Queue should block when empty"
  (let* ((seen nil)
         (q (make-list-blocking-queue))
         ;; Consumer
         (consumer-thread
          (make-thread 
           (lambda ()
             (setf seen (loop
                           for i from 1 to 10
                           collect (take q))))))
         ;; Producer
         (producer-thread
          (make-thread
           (lambda ()
             (loop 
                for i from 1 to 10
                do (put i q))))))
    (join-thread producer-thread)
    (join-thread consumer-thread)
    (is (equal (loop 
                  for i from 1 to 10 
                  collect i)
               seen))))

