use std::io::BufReader;
use std::fs::File;
use std::io::Read;

pub struct Day5;

impl Day5 {
    pub fn run() -> (usize, usize) {
        match ReadFile::read_file_to_ints("input.txt".to_string()) {
            Ok(ints) => (Day5::part_a(&ints), Day5::part_b(&ints)),
            Err(_) => panic!("couldn't read file"),
        }
    }

    pub fn part_a(instructions: &Vec<isize>) -> usize {
        let mut vec = instructions.clone();
        let mut i: usize = 0;
        let size = vec.len();
        let mut steps: usize = 0;

        while i < size {
            let offset = Day5::get_offset(i, vec[i]);
            steps += 1;
            vec[i] += 1;
            i = offset;
        }
        steps
    }

    pub fn part_b(instructions: &Vec<isize>) -> usize {
        let mut vec = instructions.clone();
        let mut i: usize = 0;
        let size = vec.len();
        let mut steps: usize = 0;

        while i < size {
            let offset = Day5::get_offset(i, vec[i]);
            steps += 1;
            if vec[i] > 2 {
                vec[i] -= 1;
            } else {
                vec[i] += 1;
            }
            i = offset;
        }
        steps
    }

    // ugly but check for integer overflow etc
    fn get_offset(curr_idx: usize, val: isize) -> usize {
        match val >= 0 {
            true => curr_idx + val as usize,
            false => {
                if let Some(v) = curr_idx.checked_sub(val.abs() as usize) {
                    v as usize
                } else {
                    <usize>::max_value()
                }
            }
        }
    }
}


struct ReadFile;

impl ReadFile {
    pub fn read_file_to_ints(f: String) -> std::io::Result<Vec<isize>> {
        let file = File::open(f)?;
        let mut buf_reader = BufReader::new(file);

        let mut s = String::new();
        match buf_reader.read_to_string(&mut s) {
            Err(_) => panic!("couldn't read {:?}", s),
            Ok(_) => (),
        }

        let ints: Vec<isize> = s.lines().map(|s| s.parse::<isize>().unwrap()).collect();
        Ok(ints)
    }
}
