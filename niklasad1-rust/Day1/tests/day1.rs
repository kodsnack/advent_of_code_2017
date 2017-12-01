extern crate day1;

#[test]
fn test_parta_is_two() {
    assert_eq!(3, day1::part_a(&vec![1, 1, 2, 2]));
}

#[test]
fn test_parta_same_number() {
    assert_eq!(4, day1::part_a(&vec![1, 1, 1, 1]));
}

#[test]
fn test_parta_sequence() {
    assert_eq!(0, day1::part_a(&vec![1, 2, 3, 4]));
}

#[test]
fn test_parta_long() {
    assert_eq!(9, day1::part_a(&vec![9, 1, 2, 1, 2, 1, 2, 9]));
}

#[test]
fn test_partb_all_match() {
    assert_eq!(6, day1::part_b(&vec![1, 2, 1, 2]));
}

#[test]
fn test_partb_all_miss() {
    assert_eq!(0, day1::part_b(&vec![1, 2, 2, 1]));
}

#[test]
fn test_partb_medium() {
    assert_eq!(12, day1::part_b(&vec![1, 2, 3, 1, 2, 3]));
}

#[test]
fn test_partb_long() {
    assert_eq!(4, day1::part_b(&vec![1, 2, 1, 3, 1, 4, 1, 5]));
}

#[test]
fn test_all() {
    let task = day1::run();
    println!("\rpartA: {}\r\n partB: {}", task.0, task.1);
    assert_eq!((!task.0, !task.1), task);
}
