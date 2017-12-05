use std::io::BufReader;
use std::fs::File;
use std::io::Read;
use std::collections::HashSet;

pub struct Day4;

impl Day4 {
    pub fn run() -> (usize, usize) {
        match ReadFile::read_file_to_string("input.txt".to_string()) {
            Ok(passphrases) => (Day4::part_a(&passphrases), Day4::part_b(&passphrases)),
            Err(_) => panic!("couldn't read file"),
        }
    }

    pub fn part_a(passphrases: &str) -> usize {
        passphrases
            .lines()
            .filter(|&x| Day4::is_simple_passphrase(x))
            .collect::<Vec<_>>()
            .len()
    }

    pub fn part_b(passphrases: &str) -> usize {
        passphrases
            .lines()
            .filter(|&x| Day4::is_no_duplicate_passphrase(x))
            .collect::<Vec<_>>()
            .len()
    }

    pub fn is_simple_passphrase(phrase: &str) -> bool {
        let tokens = phrase.split_whitespace().collect::<Vec<_>>();
        let unique_tokens: HashSet<_> = tokens.iter().collect();

        unique_tokens.len() == tokens.len()
    }

    pub fn is_no_duplicate_passphrase(phrase: &str) -> bool {
        let mut lookup: HashSet<String> = HashSet::new();
        let tokens = phrase.split_whitespace().collect::<Vec<_>>();

        for substr in tokens.iter() {
            let mut v = substr.chars().collect::<Vec<_>>();
            v.sort();
            lookup.insert(v.into_iter().collect::<String>());
        }

        lookup.len() == tokens.len()
    }
}


struct ReadFile;

impl ReadFile {
    pub fn read_file_to_string(f: String) -> std::io::Result<String> {
        let file = File::open(f)?;
        let mut buf_reader = BufReader::new(file);

        let mut s = String::new();
        match buf_reader.read_to_string(&mut s) {
            Err(_) => panic!("couldn't read {:?}", s),
            Ok(_) => (),
        }
        Ok(s)
    }
}
