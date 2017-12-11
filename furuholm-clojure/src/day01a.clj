(ns day01a)

(defn first-if-equal [a b]
  (cond
    (= a b) (Character/getNumericValue a)
    :else 0))

(defn sum-adjecent [xs]
  (cond
    (second xs) (+ (first-if-equal (first xs) (second xs))
                   (sum-adjecent (rest xs)))
    :else 0))

(defn capcha [s]
  (sum-adjecent (conj (reverse s) (first s))))

(defn -main [arg]
  (println (capcha arg)))
