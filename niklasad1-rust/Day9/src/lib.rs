use std::io::BufReader;
use std::fs::File;
use std::io::Read;

#[derive(Debug)]
pub enum State {
    Level(isize),
    Ignore(isize),
    Cancel,
    Idle,
}

#[derive(Debug)]
pub struct StreamProcessing {
    state: State,
    prev: State,
    group_cnt: isize,
    garbage_cnt: isize,
}

impl StreamProcessing {
    pub fn new(s: State, p: State, group: isize, garbage: isize) -> Self {
        StreamProcessing {
            state: s,
            prev: p,
            group_cnt: group,
            garbage_cnt: garbage,
        }
    }

    pub fn run() -> (isize, isize) {
        match ReadFile::read_file_to_string("input.txt") {
            Ok(s) => {

                let mut stream = StreamProcessing::new(State::Idle, State::Idle, 0, 0);

                for ch in s.chars() {
                    stream = stream.update_state(ch);
                }

                (stream.group_cnt, stream.garbage_cnt)
            }

            Err(e) => panic!("{:?}", e),
        }

    }
    // moves ownership thus the type don't need to be "copyable"
    fn update_state(self, ch: char) -> Self {
        let (new_state, prev, group_cnt, garbage_cnt) = match self.state {

            State::Idle => {
                match ch {
                    '<' => (State::Ignore(0), self.state, 0, 0),
                    '{' => (State::Level(1), self.state, 0, 0),
                    '!' => (State::Cancel, self.state, 0, 0),
                    _ => (self.state, self.prev, 0, 0),
                }
            }

            State::Ignore(n) => {
                match ch {
                    '>' if n > 0 => (State::Level(n), self.state, 0, 0),
                    '>' => (State::Idle, self.state, 0, 0),
                    '!' => (State::Cancel, self.state, 0, 0),
                    _ => (self.state, self.prev, 0, 1),
                }
            }

            State::Level(n) => {
                match ch {
                    '<' => (State::Ignore(n), self.state, 0, 0),
                    '{' => (State::Level(n + 1), self.state, 0, 0),
                    '}' => (State::Level(n - 1), self.state, n, 0),
                    '!' => (State::Cancel, self.state, 0, 0),
                    _ => (self.state, self.prev, 0, 0),
                }
            }

            State::Cancel => (self.prev, self.state, 0, 0),
        };

        StreamProcessing::new(
            new_state,
            prev,
            self.group_cnt + group_cnt,
            self.garbage_cnt + garbage_cnt,
        )
    }
}


struct ReadFile;

impl ReadFile {
    pub fn read_file_to_string<'a>(f: &'a str) -> std::io::Result<String> {
        let file = File::open(f)?;
        let mut buf_reader = BufReader::new(file);

        let mut s = String::new();

        // read_to_string returns usize that's why we return 's' in the match arm
        // instead of the 'matched valued'
        match buf_reader.read_to_string(&mut s) {
            Ok(_) => Ok(s),
            Err(e) => Err(e),
        }
    }
}
