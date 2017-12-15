use std::io::BufReader;
use std::fs::File;
use std::io::Read;
use std::collections::HashMap;
use std::collections::HashSet;
use std::collections::VecDeque;


#[derive(Debug, PartialEq, Eq)]
pub struct DigitalPlumber;

impl DigitalPlumber {
    pub fn run() -> (usize, usize) {
        match ReadFile::read_file_to_numbers("input.txt") {
            Ok(directions) => (
                DigitalPlumber::part_a(&directions),
                DigitalPlumber::part_b(&directions),
            ),
            Err(e) => panic!("{:?}", e),
        }
    }

    pub fn part_a(pipes: &HashMap<usize, Vec<usize>>) -> usize {
        let mut group_zero: HashSet<usize> = HashSet::new();
        let mut queue: VecDeque<usize> = VecDeque::new();
        let mut visited: HashSet<usize> = HashSet::new();

        group_zero.insert(0);
        queue.push_back(0);

        while !queue.is_empty() {
            let k = queue.pop_front().unwrap();
            group_zero.insert(k);
            visited.insert(k);
            if let Some(v) = pipes.get(&k) {
                v.iter().filter(|&x| !visited.contains(x)).for_each(|&x| {
                    queue.push_back(x);
                });
            }
        }

        group_zero.len()
    }


    pub fn part_b(pipes: &HashMap<usize, Vec<usize>>) -> usize {
        let mut groups: HashSet<usize> = HashSet::new();
        let mut visited: HashSet<usize> = HashSet::new();
        let mut queue: VecDeque<usize> = VecDeque::new();

        for g in 0..pipes.len() {
            if !visited.contains(&g) {
                queue.push_back(g);

                while !queue.is_empty() {
                    let k = queue.pop_front().unwrap();

                    groups.insert(g);
                    visited.insert(k);

                    if let Some(v) = pipes.get(&k) {
                        v.iter().filter(|&x| !visited.contains(x)).for_each(|&x| {
                            queue.push_back(x);
                        });
                    }
                }
            }
        }

        groups.len()
    }
}


pub struct ReadFile;

impl ReadFile {
    pub fn read_file_to_numbers<'a>(f: &'a str) -> std::io::Result<HashMap<usize, Vec<usize>>> {
        let file = File::open(f)?;
        let mut buf_reader = BufReader::new(file);

        let mut s = String::new();

        // read_to_string returns usize that's why we return 's' in the match arm
        // instead of the 'matched valued'
        match buf_reader.read_to_string(&mut s) {
            Ok(_) => {
                let mut pipes: HashMap<usize, Vec<usize>> = HashMap::new();

                for line in s.lines() {
                    let words: Vec<&str> = line.split("<->").map(str::trim).collect();
                    let k = words[0].parse::<usize>().unwrap();
                    let v: Vec<_> = words[1]
                        .split(",")
                        .map(str::trim)
                        .filter_map(|s| s.parse::<usize>().ok())
                        .collect();
                    pipes.insert(k, v);
                }
                Ok(pipes)
            }
            Err(e) => Err(e),
        }
    }
}
