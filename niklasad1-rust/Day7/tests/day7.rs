extern crate day7;

#[test]
fn test_parta_valid() {
    if let Ok(input) = day7::ReadFile::read_file_to_string("test.txt") {
        assert_eq!("thnk", day7::Day7::part_a(&input));
    }
}

#[test]
fn test_partb_valid() {
    if let Ok(input) = day7::ReadFile::read_file_to_string("test.txt") {
        assert_eq!(60, day7::Day7::part_b(&input));
    }
}

#[test]
// #[ignore]
fn test_all() {
    let task = day7::Day7::run();
    println!("\rpartA: {}\r\n partB: {}", task.0, task.1);
    assert_eq!(("".to_string(), 0), task);
}
