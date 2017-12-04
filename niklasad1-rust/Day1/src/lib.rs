use std::io::BufReader;
use std::fs::File;
use std::io::Read;

pub fn run() -> (u32, u32) {
    let nums = match file_to_vec("input.txt".to_string()) {
        Ok(v) => v,
        Err(err) => panic!("Error reading file: {:?}", err),
    };
    (part_a(&nums), part_b(&nums))
}

pub fn part_a(numbers: &Vec<u32>) -> u32 {
    inverse_captcha(numbers, 1)
}

pub fn part_b(numbers: &Vec<u32>) -> u32 {
    inverse_captcha(numbers, numbers.len() / 2)
}

fn inverse_captcha(numbers: &Vec<u32>, step: usize) -> u32 {
    numbers
        .iter()
        .zip(numbers.iter().cycle().skip(step))
        .filter(|&(i, j)| i == j)
        .fold(0, |acc, (i, _)| acc + i)
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
