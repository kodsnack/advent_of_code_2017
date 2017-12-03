extern crate itertools;

use itertools::Itertools;
use std::io::BufReader;
use std::fs::File;
use std::io::Read;

pub fn run() -> (u32, u32) {
    let nums = match read_file_to_matrix("input.txt".to_string()) {
        Ok(v) => v,
        Err(err) => panic!("Error reading file: {:?}", err),
    };
    (part_a(&nums), part_b(&nums))
}

pub fn part_a(matrix: &Vec<Vec<u32>>) -> u32 {
    matrix
        .iter()
        .map(|r| (r.iter().max().unwrap(), r.iter().min().unwrap()))
        .fold(0, |acc, (max, min)| acc + (max - min))
}

pub fn part_b(matrix: &Vec<Vec<u32>>) -> u32 {
    let mut crc = 0;
    for row in matrix.iter() {
        // get potential pairs and pick the first one that are even divisable
        // because of the ordering in the vector of two elements I must convert them in the fold
        let i = row.iter()
            .combinations(2)
            .filter(|ref i| i[0] % i[1] == 0 || i[1] % i[0] == 0)
            .fold(0, |acc, t| if t[0] > t[1] {
                acc + t[0] / t[1]
            } else {
                acc + t[1] / t[0]
            });
        crc += i;
    }
    crc
}


fn read_file_to_matrix(f: String) -> std::io::Result<Vec<Vec<u32>>> {
    let file = File::open(f)?;
    let mut buf_reader = BufReader::new(file);

    let mut s = String::new();
    match buf_reader.read_to_string(&mut s) {
        Err(_) => panic!("couldn't read {:?}", s),
        Ok(_) => (),
    }
    let mut matrix: Vec<Vec<u32>> = Vec::new();
    for line in s.lines() {
        let row = line.split_whitespace()
            .map(|s| s.trim().parse::<u32>().unwrap())
            .collect::<Vec<_>>();
        matrix.push(row);
    }
    Ok(matrix)
}
