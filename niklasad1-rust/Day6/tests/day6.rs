extern crate day6;

#[test]
fn test_parta_valid() {
    assert_eq!(5, day6::Day6::part_a(&vec![0, 2, 7, 0]));
}

#[test]
fn test_partb_valid() {
    assert_eq!(4, day6::Day6::part_b(&vec![0, 2, 7, 0]));
}

#[test]
fn test_all() {
    let task = day6::Day6::run();
    println!("\rpartA: {}\r\n partB: {}", task.0, task.1);
    assert_eq!((!task.0, !task.1), task);
}
