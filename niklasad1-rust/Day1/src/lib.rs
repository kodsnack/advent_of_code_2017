use std::io::BufReader;
use std::fs::File;
use std::io::Read;

pub fn run() -> (u32, u32) {
    let nums = match file_to_vec("input.txt".to_string()) {
        Ok(v) => v,
        Err(err) => panic!("Error reading file: {:?}"),
    };
    (part_a(&nums), part_b(&nums))
}

pub fn part_a(numbers: &Vec<u32>) -> u32 {
    let s1 = numbers[0..numbers.len() - 1]
        .iter()
        .zip(numbers[1..numbers.len()].iter())
        .filter(|&p| p.0 == p.1)
        .fold(0, |acc, (i, _j)| acc + i);

    let s2 = if numbers[0] == numbers[numbers.len() - 1] {
        numbers[0]
    } else {
        0
    };

    s1 + s2
}

pub fn part_b(numbers: &Vec<u32>) -> u32 {
    let step = numbers.len() / 2;
    let mut sum: u32 = 0;
    for i in 0..numbers.len() {
        if numbers[i] == numbers[(i + step) % numbers.len()] {
            sum += numbers[i];
        }
    }
    sum
}


fn file_to_vec(f: String) -> std::io::Result<Vec<u32>> {
    let file = File::open(f)?;
    let mut buf_reader = BufReader::new(file);

    let mut s = String::new();
    match buf_reader.read_to_string(&mut s) {
        Err(_) => panic!("couldn't read {:?}", s),
        Ok(_) => (),
    }

    Ok(
        s.chars()
            .filter(|&c| c.is_digit(10))
            .map(|c| c.to_digit(10).unwrap())
            .collect::<Vec<u32>>(),
    )
}
