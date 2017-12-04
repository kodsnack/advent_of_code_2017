(ns adventofcode-2017.day02
  (:gen-class)
  (:require [clojure.string])
  (:require [adventofcode-2017.util :refer [pairs]])
)

(defn parse-cells [input-line]
  (map read-string (clojure.string/split input-line #"\s+")))

(defn solve [input-lines metric]
  (->> input-lines
       (map parse-cells)
       (map metric)
       (reduce +)
       ))

(defn spread [nums]
  (- (apply max nums) (apply min nums)))

(defn quotient [nums]
  (->> nums
       (pairs)
       (filter #(= 0 (apply mod %)))
       (first)
       (apply /)
       ))

(defn run
  "Solve day 2 of Advent of Code 2017"
  [input-lines & args]
  (do
    (println "A:" (solve input-lines spread))
    (println "B:" (solve input-lines quotient))
  )
)
