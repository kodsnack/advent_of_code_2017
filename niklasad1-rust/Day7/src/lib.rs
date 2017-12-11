use std::io::BufReader;
use std::fs::File;
use std::io::Read;
use std::collections::HashMap;
use std::collections::HashSet;
use std::collections::hash_map::Entry;
use std::collections::VecDeque;
use std::cmp::Ordering;

pub struct Day7;

impl Day7 {
    pub fn run() -> (String, usize) {
        match ReadFile::read_file_to_string("input.txt") {
            Ok(s) => (Day7::part_a(&s), Day7::part_b(&s)),
            Err(e) => panic!("readfile error: {:?}", e),
        }
    }

    pub fn part_a(input: &str) -> String {
        Day7::find_root(input)
    }

    pub fn part_b(input: &str) -> usize {
        let root = Day7::find_root(input);

        let tower = Tower::new(&root, input);

        tower.traverse() as usize
    }


    fn find_root(input: &str) -> String {
        let mut rc: HashMap<&str, usize> = HashMap::new();

        for line in input.lines() {
            let words = line.split_whitespace().collect::<Vec<_>>();

            rc.entry(words[0]).or_insert(0);

            if Day7::is_a_pointer(words.len()) {

                for ptr in words.into_iter().skip(2) {
                    let val = rc.entry(ptr).or_insert(0);
                    *val += 1;
                }

            }
        }
        if let Some((key, &0)) = rc.iter().min_by_key(|&(_, pair)| *pair) {
            key.to_string()
        } else {
            "".to_string()
        }
    }


    fn is_a_pointer(input: usize) -> bool {
        input > 2
    }
}

#[derive(Debug, Eq, PartialEq)]
struct Node<'a> {
    weight: usize,
    name: &'a str,
}


struct Tower<'a> {
    root: &'a str,
    children: HashMap<&'a str, Vec<Node<'a>>>,
    weights: HashMap<&'a str, usize>,
}

impl<'a> Tower<'a> {
    fn new(r: &'a str, input: &'a str) -> Tower<'a> {

        let mut weights: HashMap<&str, usize> = HashMap::new();
        let mut children: HashMap<&str, Vec<Node<'a>>> = HashMap::new();

        for l in input.lines() {
            let words: Vec<&str> = l.split_whitespace().collect();
            weights.entry(words[0]).or_insert(
                words[1].parse::<usize>().unwrap(),
            );
        }

        for l in input.lines() {
            let words: Vec<&str> = l.split_whitespace().collect();
            if Day7::is_a_pointer(words.len()) {
                let mut tmp: Vec<Node> = Vec::new();
                for i in words.iter().skip(2) {
                    tmp.push(Node {
                        weight: *weights.get(i).unwrap(),
                        name: i,
                    });
                }
                children.entry(words[0]).or_insert(tmp);
            }
        }


        Tower {
            root: r,
            children: children,
            weights: weights,
        }
    }


    fn traverse(&self) -> isize {
        let root = Node {weight: *self.weights.get(self.root).unwrap(), name: self.root};
        let mut queue: VecDeque<&Node> = VecDeque::new();

        queue.push_back(&root);

        let mut sums: HashMap<isize, (isize, isize)> = HashMap::new();


        while !queue.is_empty() {
            if let Some(parent) = queue.pop_front() {

                let x: Vec<usize> = Vec::new();

                if let Some(children) = self.children.get(parent.name) {
                    let sum = parent.weight + children.iter().fold(0, |acc, c| acc + c.weight);
                    println!("parent {:?}\t children: {:?} \t sum: {}", parent, children, sum);
                    // let valid = children.iter().all(|c| c.weight == children[0].weight);
                    
                    // if valid {
                    //     println!("{} {:?} {}", valid, children, sum);
                    //
                    // }
                    for child in children.iter() {
                        queue.push_back(child)
                    }

                }    
                // let sum = self.dfs(node);
                // let val = sums.entry(sum).or_insert((0, node.weight as isize));
                // val.0 += 1;
            }
        }
        // let common = sums.iter().max_by_key(|&(_, &(cnt, _))| cnt).unwrap();
        // let single = sums.iter().min_by_key(|&(_, &(cnt, _))| cnt).unwrap();
        // let diff = *single.0 - *common.0;
        // println!("diff {}", diff);
        // for i in sums.iter() {
        //     println!("item {:?}", i);
        // }
        0
        // (single.1).1 - diff
    }
}




pub struct ReadFile;

impl ReadFile {
    pub fn read_file_to_string<'a>(f: &'a str) -> std::io::Result<String> {
        let file = File::open(f)?;
        let mut buf_reader = BufReader::new(file);

        let mut s = String::new();

        // read_to_string returns usize that's why we return 's' in the match arm
        // instead of the 'matched valued'
        match buf_reader.read_to_string(&mut s) {
            Ok(_) => Ok(
                s.chars()
                    .filter(|&c| c.is_alphanumeric() || c.is_whitespace())
                    .collect::<String>(),
            ),
            Err(e) => Err(e),
        }
    }
}
