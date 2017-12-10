use std::io::BufReader;
use std::fs::File;
use std::io::Read;
use std::collections::HashMap;


#[derive(Debug, PartialEq, Eq, Copy, Clone)]
enum Branch {
    Equal,
    NotEqual,
    Greather,
    GreatherOrEqual,
    Less,
    LessOrEqual,
}

#[derive(Debug, PartialEq, Eq, Copy, Clone)]
enum Instruction {
    Increment,
    Decrement,
}

#[derive(Debug)]
pub struct Cpu<'a> {
    registers: HashMap<&'a str, isize>,
    branch: HashMap<&'a str, Branch>,
    instructions: HashMap<&'a str, Instruction>,
    input: &'a Vec<&'a str>,
}

impl<'a> Cpu<'a> {
    pub fn new(input: &'a Vec<&'a str>) -> Cpu<'a> {

        let mut r: HashMap<&str, isize> = HashMap::new();
        let mut b: HashMap<&str, Branch> = HashMap::new();
        let mut i: HashMap<&str, Instruction> = HashMap::new();

        b.insert("==", Branch::Equal);
        b.insert("!=", Branch::NotEqual);
        b.insert(">", Branch::Greather);
        b.insert(">=", Branch::GreatherOrEqual);
        b.insert("<", Branch::Less);
        b.insert("<=", Branch::LessOrEqual);

        i.insert("inc", Instruction::Increment);
        i.insert("dec", Instruction::Decrement);


        for stmt in input.iter() {
            let reg: Vec<&str> = stmt.split_whitespace().take(1).collect();
            r.entry(reg[0]).or_insert(0);
        }
        Cpu {
            registers: r,
            branch: b,
            instructions: i,
            input: input,
        }
    }


    pub fn run(&mut self) -> (isize, isize) {
        let mut highest_value: isize = 0;

        for stmt in self.input.iter() {
            let tokens: Vec<&str> = stmt.split_whitespace().collect();

            let branch = *self.branch.get(tokens[5]).unwrap();
            let b_operator1 = *self.registers.get(tokens[4]).unwrap();
            let b_operator2 = tokens[6].parse::<isize>().unwrap();

            let instruction = *self.instructions.get(tokens[1]).unwrap();
            let i_operator1 = tokens[0];
            let i_operator2 = tokens[2].parse::<isize>().unwrap();

            if self.valid_branch(branch, b_operator1, b_operator2) {
                let new_val = self.update_registers(
                    instruction,
                    i_operator1,
                    i_operator2,
                );
                if new_val > highest_value {
                    highest_value = new_val;
                }
            }
        }

        if let Some((_, &register_val_after)) = self.registers.iter().max_by_key(|&(_, x)| x) {
            (register_val_after, highest_value)

        } else {
            (0, 0)
        }

    }

    fn valid_branch(&self, branch: Branch, operator1: isize, operator2: isize) -> bool {
        match branch {
            Branch::Equal if operator1 == operator2 => true,
            Branch::NotEqual if operator1 != operator2 => true,
            Branch::Greather if operator1 > operator2 => true,
            Branch::GreatherOrEqual if operator1 >= operator2 => true,
            Branch::Less if operator1 < operator2 => true,
            Branch::LessOrEqual if operator1 <= operator2 => true,
            _ => false,
        }
    }

    fn update_registers<'b>(
        &mut self,
        instr: Instruction,
        operator1: &'b str,
        operator2: isize,
    ) -> isize {
        if let Some(val) = self.registers.get_mut(operator1) {
            match instr {
                Instruction::Increment => *val += operator2,
                Instruction::Decrement => *val -= operator2,
            }
            *val
        } else {
            0
        }
    }
}



pub struct ReadFile;

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
