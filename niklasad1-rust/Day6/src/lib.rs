use std::collections::HashSet;

pub struct Day6;

impl Day6 {
    pub fn run() -> (usize, usize) {
        let input = vec![4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5];
        (Day6::part_a(&input), Day6::part_b(&input))
    }

    pub fn part_a(memory_bank: &Vec<usize>) -> usize {
        let (no_reallocations, _) = Day6::get_next_cycle(memory_bank.clone());
        no_reallocations
    }

    pub fn part_b(memory_bank: &Vec<usize>) -> usize {
        let (_, cycle) = Day6::get_next_cycle(memory_bank.clone());
        let (no_reallocations, _) = Day6::get_next_cycle(cycle);
        no_reallocations
    }

    fn get_next_cycle(mut memory_bank: Vec<usize>) -> (usize, Vec<usize>) {
        let mut seen: HashSet<Vec<usize>> = HashSet::new();
        let mut no_reallocations = 0;
        let len = memory_bank.len();

        while !seen.contains(&memory_bank) {
            seen.insert(memory_bank.clone());

            // important that enumerate() is performed before rev()
            // inorder to get the correct index
            if let Some((i, &max)) = memory_bank.iter().enumerate().rev().max_by_key(
                |&(_, max)| max)
            {
                memory_bank[i] = 0;

                // get a cyclic iterator over the vector 
                // start at position i + 1 and iterate over max values
                for i in (0..len).cycle().skip(i + 1).take(max) {
                    memory_bank[i] += 1;
                }
            }

            no_reallocations += 1;
        }
        (no_reallocations, memory_bank)
    }
}
