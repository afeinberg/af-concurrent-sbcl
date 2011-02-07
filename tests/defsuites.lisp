(in-package :af-concurrency-tests)

(def-suite :af-concurrency
    :description "Main test suite for af-concurrency")

(def-suite :af-concurrency.util :in :af-concurrency)

(def-suite :af-concurrency.blocking :in :af-concurrency)

(def-suite :af-concurrency.atomic :in :af-concurrency)