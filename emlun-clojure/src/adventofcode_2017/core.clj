(ns adventofcode-2017.core
  (:gen-class)
  (:require clojure.string)
)

(defn pad [day]
  (if (number? day)
    (recur (str day))
    (if (< 1 (count day)) day (str "0" day))))

(defn day-namespace [day] (symbol (str "adventofcode-2017.day" (pad day))))

(defn -main
  "Run the solver for the given day (or all) with lines from file as argument. If file is -, use standard input; if not given, use default."
  ([]
    (try
      (loop [day 1]
        (require (day-namespace day))
        (println "\n===" "Day" day "===\n")
        (-main day)
        (recur (inc day))
      )
      (catch java.io.FileNotFoundException e ())
    )
  )
  ([day] (-main day (str "resources/day" (pad day) ".in")))
  ([day file & args]
    (do
      (def dayspace (day-namespace day))
      (require dayspace)
      (def input (if (= "-" file) *in* file))
      (def lines (clojure.string/split-lines (slurp input)))
      (def run (resolve (symbol (str dayspace) "run")))
      (run lines)
    )
  )
)
