(ns adventofcode-2017.day01
  (:gen-class)
  (:require [clojure.string])
)

(defn rotate [lookahead xs]
  (let [[front back] (split-at lookahead xs)]
    (concat back front)
))

(defn solve [lookahead digits]
  (let [
        pairs (map vector digits (rotate lookahead digits))
        matching-pairs (filter (fn [[a b]] (= a b)) pairs)
        matched-digits (map first matching-pairs)
        sum (reduce + matched-digits)
        ]
    sum
))

(defn get-digits [lines]
  (let [
        digits (mapcat clojure.string/trim lines)
        numbers (map #(read-string (str %)) digits)
        ]
    numbers
))

(defn run
  "Solve day 1 of Advent of Code 2017"
  [input-lines & args]
  (let [ digits (get-digits input-lines) ]
    (do
      (println "A:" (solve 1 digits))
      (println "B:" (solve (/ (count digits) 2) digits))
    )
  )
)
