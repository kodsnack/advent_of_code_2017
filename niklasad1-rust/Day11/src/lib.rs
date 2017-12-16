use std::io::BufReader;
use std::fs::File;
use std::io::Read;

#[derive(Debug, Copy, Clone, PartialEq, Eq)]
pub enum Direction {
    North,
    NorthEast,
    NorthWest,
    South,
    SouthEast,
    SouthWest,
}

#[derive(Debug, PartialEq, Eq)]
struct Position {
    x: isize,
    y: isize,
}

impl Position {
    fn new() -> Self {
        Position { x: 0, y: 0 }
    }

    fn north(self) -> Self {
        Position {
            x: self.x,
            y: self.y + 2,
        }
    }

    fn north_east(self) -> Self {
        Position {
            x: self.x + 1,
            y: self.y + 1,
        }
    }

    fn north_west(self) -> Self {
        Position {
            x: self.x - 1,
            y: self.y + 1,
        }
    }

    fn south(self) -> Self {
        Position {
            x: self.x,
            y: self.y - 2,
        }
    }

    fn south_east(self) -> Self {
        Position {
            x: self.x + 1,
            y: self.y - 1,
        }
    }

    fn south_west(self) -> Self {
        Position {
            x: self.x - 1,
            y: self.y - 1,
        }
    }
}

#[derive(Debug, PartialEq, Eq)]
pub struct HexEd {
    position: Position,
}

impl HexEd {
    fn new() -> Self {
        HexEd { position: Position::new() }
    }

    pub fn run() -> (isize, isize) {
        match ReadFile::read_file_to_dirs("input.txt") {
            Ok(directions) => (HexEd::part_a(&directions), HexEd::part_b(&directions)),
            Err(e) => panic!("{:?}", e),
        }
    }

    pub fn part_a(dirs: &Vec<Direction>) -> isize {
        let start = HexEd::new();
        let mut end = HexEd::new();

        for &dir in dirs.iter() {
            end = end.change_position(dir);
        }

        end.difference(&start)
    }
    
    pub fn part_b(dirs: &Vec<Direction>) -> isize {
        let start = HexEd::new();
        let mut curr = HexEd::new();

        let mut max_distance = <isize>::min_value();

        for &dir in dirs.iter() {
            curr = curr.change_position(dir);
            let candidate = curr.difference(&start);
            if candidate > max_distance {
                max_distance = candidate;
            }
        }
        max_distance
    }

    fn change_position(self, dir: Direction) -> Self {
        let new_pos = match dir {
            Direction::North => self.position.north(),
            Direction::NorthEast => self.position.north_east(),
            Direction::NorthWest => self.position.north_west(),
            Direction::South => self.position.south(),
            Direction::SouthEast => self.position.south_east(),
            Direction::SouthWest => self.position.south_west(),
        };

        HexEd { position: new_pos }
    }

    fn difference(&self, other: &HexEd) -> isize {
        ((self.position.y + other.position.y).abs() + (self.position.x + other.position.x).abs()) /
            2
    }

}


struct ReadFile;

impl ReadFile {
    pub fn read_file_to_dirs<'a>(f: &'a str) -> std::io::Result<Vec<Direction>> {
        let file = File::open(f)?;
        let mut buf_reader = BufReader::new(file);

        let mut s = String::new();

        // read_to_string returns usize that's why we return 's' in the match arm
        // instead of the 'matched valued'
        match buf_reader.read_to_string(&mut s) {
            Ok(_) => {
                Ok(
                    s.trim()
                        .split(",")
                        .map(|d| match d {
                            "s" => Some(Direction::South),
                            "se" => Some(Direction::SouthEast),
                            "sw" => Some(Direction::SouthWest),
                            "n" => Some(Direction::North),
                            "ne" => Some(Direction::NorthEast),
                            "nw" => Some(Direction::NorthWest),
                            _ => None,
                        })
                        .filter(|x| x.is_some())
                        .map(|x| x.unwrap())
                        .collect(),
                )
            }
            Err(e) => Err(e),
        }
    }
}
