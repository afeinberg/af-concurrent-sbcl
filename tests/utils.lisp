(in-package :af-concurrency-tests)

(in-suite :af-concurrency.util)

(test af-queue-test
      "Test the queue"
      (let ((q (af/make-queue)))
        (loop 
           for i from 1 to 10
           do (af/enqueue i q))
        (is (equal 
             (loop
                for i from 1 to 10
                collect (af/dequeue q))
             (loop 
                for i from 1 to 10
                collect i)))))
