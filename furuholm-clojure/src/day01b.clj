(ns day01b)

(defn add-if-equal [ab]
  (let [[a b] ab]
  (cond
    (= a b) (* 2 (Character/getNumericValue a))
    :else 0)))

(defn capcha [s]
  (let [[xs ys] (partition (/ (count s) 2) s)]
    (reduce + (map add-if-equal (map vector xs ys)))))

(defn -main [arg]
  (println (capcha arg)))
