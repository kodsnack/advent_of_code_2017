extern crate day10;

#[test]
fn test_part_b_1() {
    assert_eq!("a2582a3a0e66e6e86e3812dcb672a272".to_string(), day10::KnotHash::part_b(""));
}


#[test]
fn test_part_b_2() {
    assert_eq!("33efeb34ea91902bb2f59c9920caa6cd".to_string(), day10::KnotHash::part_b("AoC 2017"));
}


#[test]
fn test_part_b_3() {
    assert_eq!("3efbe78a8d82f29979031a4aa0b16a9d".to_string(), day10::KnotHash::part_b("1,2,3"));
}


#[test]
fn test_part_b_4() {
    assert_eq!("63960835bcdc130f0b66d7ff4f6a5a8e".to_string(), day10::KnotHash::part_b("1,2,4"));
}


#[test]
fn test_all() {
    assert_eq!((0, " ".to_string()), day10::KnotHash::run());
}
