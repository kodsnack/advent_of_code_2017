(ns adventofcode-2017.util
  (:require [clojure.test :refer [is]])
)

(declare bfs-expand)
(declare count-filter)

(defn abs
  "absolute value"
  { :test #(assert (= 1 (abs 1) (abs -1))) }
  [n]
  { :pre [(number? n)] :post [(number? %)]}
  (max n (-' n))
)

(defn bfs
  { :test (fn [] (do
             (is (=
                  0
                  (bfs {
                    :terminate? (constantly true)
                    :generate-next-states #(iterate inc %)
                    :initial-state 0
                    })
                  ))
             (is (=
                  11
                  (bfs {
                    :generate-next-states (fn [i] [(dec i) (inc i)])
                    :initial-state 0
                    :terminate? #(< 10 %)
                    })
                  ))
             (is (=
                  1001
                  (bfs {
                    :generate-next-states (fn [i] [(dec i) (inc i)])
                    :initial-state 0
                    :skip? (fn [state history] (< state (last history)))
                    :terminate? #(< 1000 %)
                    })
                  ))
             (is (=
                  nil
                  (bfs {
                    :generate-next-states (fn [i] [])
                    :initial-state 0
                    :terminate? (constantly false)
                    })
                  ))
             (is (=
                  nil
                  (bfs {
                    :generate-next-states (fn [i] [(inc i)])
                    :initial-state 0
                    :skip? (fn [state history] (> state 1000))
                    :terminate? (constantly false)
                    })
                  ))
             ))}
  [{
    :keys [generate-next-states initial-state skip? terminate?]
    :or { skip? (constantly false) }
    }]

  (let [
        initial-branch [initial-state []] ; [state history]
        branch-sequence (apply concat
                               (take-while seq
                                           (iterate
                                             (fn [branches]
                                               (mapcat
                                                 (partial bfs-expand generate-next-states skip?)
                                                 branches
                                                 )
                                               )
                                             [initial-branch]
                                             ))
                        )
        ]
    (->> branch-sequence
      (filter (fn [[state history]] (terminate? state)))
      (first)
      (first)
    )
  )
)

(defn- bfs-expand
  { :test #(do
             (is (=
                  [ [1 [0]] [-1 [0]] ]
                  (bfs-expand
                    (fn [i] [(inc i) (dec i)])
                    (constantly false)
                    [0 []]
                    )
                  ))
             (is (=
                  [ [2 [0 1]] [0 [0 1]] ]
                  (bfs-expand
                    (fn [i] [(inc i) (dec i)])
                    (constantly false)
                    [1 [0]]
                    )
                  ))
             (is (=
                  []
                  (bfs-expand
                    (fn [i] [(inc i) (dec i)])
                    (constantly true)
                    [1 [0]]
                    )
                  ))
             )}
  [generate-next-states skip? [state history]]
  (let [
        next-history (conj history state)
        ]
    (filter
      #(not (apply skip? %))
      (map
        (fn [state] [ state next-history ])
        (generate-next-states state)
      )
    )
  )
)

(defn count=
  "([value] [value coll])
  Shortcut for (count (filter #(= value %) coll)). Returns a curried function if called without coll."
  {
   :test #(do
            (assert (= 2 (count= 5 [1 2 5 3 5 7])))
            (assert (= [1 2] (map (count= 5) [[1 5] [5 2 5]])))
            )
  }
  ([ value ]
    (fn [ coll ] (count-filter #(= value %) coll)))

  ([ value coll ]
    ((count= value) coll))
)

(defn count-filter
  "([pred] [pred coll])
  Shortcut for (count (filter pred coll)). Returns a curried function if called without coll."
  {
   :test (fn []
           (assert (= 2 (count-filter #(= 5 %) [1 2 5 3 5 7])))
           (assert (= [1 2] (map (count-filter #(= 5 %)) [[1 5] [5 2 5]])))
           )
  }
  ([ pred coll ]
    ((count-filter pred) coll))

  ([ pred ]
    (fn [ coll ] (reduce (fn [count next] (+ count (if (pred next) 1 0))) 0 coll)))
)

(defn first-recurrence
  { :test #(assert (= 5 (first-recurrence [1 5 2 5 2]))) }

  ( [future]
    { :pre (seq? future) }
      (first-recurrence #{} future)
  )

  ( [history [present & future]]
    { :pre [(or (seq? future) (nil? future)) (coll? history)] }
      (if (nil? present)
        nil
        (if (contains? history present)
          present
          (recur (conj history present) future)
        )
      )
  )
)

(defn flip
  "Apply f and its following arguments with the first two arguments flipped"
  {
   :test (fn []
            (assert (= (flip - 5 1) (- 1 5)))
            (assert (= (flip - 5 1 3) (- 1 5 3)))
            (assert (= (flip - 5 1 3 3) (- 1 5 3 3)))
            (assert (= (flip map [1 2 3] #(+ 3 %)) (map #(+ 3 %) [1 2 3])))
            )
   }
  [f a b & more]
  (apply f (cons b (cons a more))))

(defn map-with-index
  [f coll]
    (map f coll (iterate inc 0))
  )

(defn pairs [ [a & bs] ]
  (if (seq bs)
    (concat
      (mapcat (fn [b] [[a b] [b a]]) bs)
      (pairs bs)
    )))

(defn splits
  { :test #(do
             (is (= (splits ()) [ [() ()] ]))
             (is (= (splits [0]) [ [() [0]] [[0] ()] ]))
             (is (= (splits [0 1]) [ [() [0 1]] [[0] [1]] [[0 1] ()]]))
             (is (= (splits [0 1 2]) [ [() [0 1 2]] [[0] [1 2]] [[0 1] [2]] [[0 1 2] ()]]))
             (is (= (first (first (splits (range 1e32)))) ()))
             ) }
  [coll]
    (lazy-cat
      (take-while #(not (= nil (second %)))
        (iterate (fn [ [prefix [middle & suffix]] ]
                   (if (nil? middle)
                     nil
                     [(lazy-cat prefix [middle]) suffix]
                   )
                 )
                 [() coll]
        )
      )
      (if (empty? coll)
        []
        [[coll ()]]
      )
    )
)

(defn split-around
  { :test (fn [] (do
                   (is (=
                            (split-around #(= 2 %) [])
                            []
                            ))
                   (is (=
                            (split-around #(= 2 %) [1 2 3])
                            [[1] [3]]
                            ))
                   (is (=
                            (split-around #{4 5 6} (range 10))
                            [[0 1 2 3] [7 8 9]]
                            ))
                   (is (=
                            (split-around #{0} [0 0 0 0 0 0 1 0 0 0 2 3 0 0 0 0 0 4 5])
                            [[1] [2 3] [4 5]]
                            ))
                   (is (=
                            (take 1 (split-around #(not (= 1 %)) (iterate inc 0)))
                            [[1]]
                            ))
                   ))
  }
  [f coll]
  (->> coll
       (partition-by f)
       (filter #(not (f (first %))))
       ))

(defn transpose
  "Transform seq [[a1 a2 ...] [b1 b2 ...] ...] to seq [[a1 b1 ...] [a2 b2 ...] ...]"
  {
   :test #(do
            (assert (= (transpose []) (transpose [[]]) (transpose [[] []]) []), "Transpose of empty input is empty")
            (assert (= (transpose [[1]]) [[1]]), "Transpose of single element is identity function")
            (assert (= (transpose [[1 2]]) [[1] [2]]), "Transpose of two-column row is two one-column rows")
            (assert (= (transpose [[1 2] [3 4]]) [[1 3] [2 4]]), "Transpose of 2x2 matrix is matrix transpose")
            (assert (= (transpose [[1 2] []]) []), "Rows are truncated to shortest row")
            (assert (= (transpose [[1 2] [3]]) [[1 3]]), "Rows are truncated to shortest row")
            (assert (= (transpose (transpose [[1 2] [3 4]])) [[1 2] [3 4]]), "Transpose is its own inverse")
            )
   }
  [seqs]
  (if (seq seqs)
    (apply map (cons vector seqs))
    ()
  ))
