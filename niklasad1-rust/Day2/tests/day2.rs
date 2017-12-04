extern crate day2;

#[test]
fn test_parta() {
    assert_eq!(
        18,
        day2::part_a(&vec![vec![5, 1, 9, 5], vec![7, 5, 3], vec![2, 4, 6, 8]])
    );
}

#[test]
fn test_partb() {
    assert_eq!(
        9,
        day2::part_b(&vec![vec![5, 9, 2, 8], vec![9, 4, 7, 3], vec![3, 8, 6, 5]])
    );
}

#[test]
fn test_all() {
    let task = day2::run();
    println!("\rpartA: {}\r\n partB: {}", task.0, task.1);
    assert_eq!((!task.0, !task.1), task);
}
