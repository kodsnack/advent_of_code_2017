extern crate day5;

#[test]
fn test_parta_valid() {
    assert_eq!(5, day5::Day5::part_a(&vec![0, 3, 0, 1, -3]));
}

#[test]
fn test_partb_valid() {
    assert_eq!(10, day5::Day5::part_b(&vec![0, 3, 0, 1, -3]));
}


#[test]
fn test_all() {
    let task = day5::Day5::run();
    println!("\rpartA: {}\r\n partB: {}", task.0, task.1);
    assert_eq!((!task.0, !task.1), task);
}
