(in-package :af-concurrency.blocking)

(defgeneric take (q)
  (:documentation "Retrieves and removes head of the queue, waiting if
needed until an element becomes available."))

(defgeneric put (obj q)
  (:documentation "Inserts the specified element into this queue, waiting
if needed for space to become available"))

(defgeneric blocking-queue-empty-p (q)
  (:documentation "Return true if this queue contains no elements."))

(defgeneric remaining-capacity (q)
  (:documentation "Return the number of additional elements that this queue
can ideally (in absence of resource constraints) accept without blocking, or
-1 if there is no intrinisic limit."))

(defclass list-blocking-queue ()
  ((cond-empty
    :initform (make-waitqueue))
   (cond-full 
    :initform (make-waitqueue))
   (queue-mutex
    :initform (make-mutex :name "queue lock"))
   (queue
    :initform (af/make-queue))
   (size
    :initform 0)
   (capacity
    :initarg :capacity
    :initform -1)))

(defun make-list-blocking-queue (&optional capacity)
  (if capacity
      (make-instance 'list-blocking-queue :capacity capacity)
      (make-instance 'list-blocking-queue)))

(defmethod take ((q list-blocking-queue))
  (with-slots (cond-empty cond-full queue-mutex queue size capacity) q
    (let ((val 
           (with-mutex (queue-mutex)
             (loop
                (unless (= size 0) (return))
                (condition-wait cond-empty queue-mutex))
             (decf size)
             (af/dequeue queue))))   
      (condition-broadcast cond-full)
      val)))

(defmethod put (o (q list-blocking-queue))
  (with-slots (cond-empty cond-full queue-mutex queue size capacity) q
    (let ((val
           (with-mutex (queue-mutex)
            (loop
               (unless (= size capacity) (return))
               (condition-wait cond-full queue-mutex))
            (incf size)
            (af/enqueue o queue))))
      (condition-broadcast cond-empty)
      val)))

(defmethod remaining-capacity ((q list-blocking-queue))
  (with-slots (queue-mutex capacity size) q
      (with-mutex (queue-mutex)        
         (if (not (= -1 capacity))
             (- capacity size)
             -1))))

(defmethod blocking-queue-empty-p ((q list-blocking-queue))
  (with-slots (queue-mutex size) q
      (with-mutex (queue-mutex) 
        (= size 0))))


   