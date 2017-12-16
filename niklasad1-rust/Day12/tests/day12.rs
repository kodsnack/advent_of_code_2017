extern crate day12;

use day12::ReadFile;
use day12::DigitalPlumber;

#[test]
fn test_part_a() {
    match ReadFile::read_file_to_numbers("test.txt") {
        Ok(nums) => assert_eq!(6, DigitalPlumber::part_a(&nums)),
        Err(err) => panic!("{:?}", err),
    }
}

#[test]
fn test_part_b() {
    match ReadFile::read_file_to_numbers("test.txt") {
        Ok(nums) => assert_eq!(2, DigitalPlumber::part_b(&nums)),
        Err(err) => panic!("{:?}", err),
    }
}

#[test]
fn test_all() {
    assert_eq!((0, 0), DigitalPlumber::run());
}
