extern crate day11;

use day11::Direction;
use day11::HexEd;


#[test]
fn test_parta_1() {
    assert_eq!(
        3,
        HexEd::part_a(&vec![
            Direction::NorthEast,
            Direction::NorthEast,
            Direction::NorthEast,
        ])
    );

}


#[test]
fn test_parta_2() {
    assert_eq!(
        0,
        HexEd::part_a(&vec![
            Direction::NorthEast,
            Direction::NorthEast,
            Direction::SouthWest,
            Direction::SouthWest,
        ])
    );

}

#[test]
fn test_parta_3() {
    assert_eq!(
        2,
        HexEd::part_a(&vec![
            Direction::NorthEast,
            Direction::NorthEast,
            Direction::South,
            Direction::South,
        ])
    );

}


#[test]
fn test_parta_4() {
    assert_eq!(
        3,
        HexEd::part_a(&vec![
            Direction::SouthEast,
            Direction::SouthWest,
            Direction::SouthEast,
            Direction::SouthWest,
            Direction::SouthWest,
        ])
    );

}


#[test]
fn test_all() {
    assert_eq!((-1, -1), day11::HexEd::run());
}
