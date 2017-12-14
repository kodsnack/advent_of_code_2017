struct State {
    pos: usize,
    skip: usize,
}

impl State {
    fn new() -> Self {
        State { pos: 0, skip: 0 }
    }
}


#[derive(Debug)]
pub struct KnotHash;

impl KnotHash {
    pub fn run() -> (usize, String) {
        let input = "46,41,212,83,1,255,157,65,139,52,39,254,2,86,0,204";
        (KnotHash::part_a(input), KnotHash::part_b(input))
    }

    pub fn part_a<'a>(input: &'a str) -> usize {
        let lens: Vec<usize> = input
            .trim()
            .split(",")
            .map(|c| c.parse::<usize>().unwrap())
            .collect();
        
        let mut list = (0..256).collect::<Vec<usize>>();
        let list_len = list.len();
        let mut state = State::new();

        for &len in lens.iter() {
            let tmp = list.clone();

            // sublist to reverse
            let sub_list: Vec<_> = tmp.into_iter().cycle().skip(state.pos).take(len).collect();

            for (i, &val) in sub_list.iter().rev().enumerate() {
                list[(i + state.pos) % list_len] = val;
            }

            // update
            state.pos = (state.pos + len + state.skip) % list_len;
            state.skip += 1;
        }


        list[0] * list[1]
    }

    pub fn part_b<'a>(input: &'a str) -> String {

        let lens: Vec<usize> = input
            .as_bytes()
            .iter()
            .chain(&vec![17, 31, 73, 47, 23])
            .map(|l| *l as usize)
            .collect();
        
        let mut list = (0..256).collect::<Vec<usize>>();
        let list_len = list.len();
        let mut state = State::new();

        for _ in 0..64 {
            for &len in lens.iter() {
                let tmp = list.clone();
                
                // sublist to reverse
                let sub_list: Vec<_> = tmp.iter().cycle().skip(state.pos).take(len).collect();

                for (i, &&val) in sub_list.iter().rev().enumerate() {
                    list[(i + state.pos) % list_len] = val;
                }

                // update
                state.pos = (state.pos + len + state.skip) % list_len;
                state.skip += 1;
            }
        }


        let dense_hash: Vec<_> = list.chunks(16)
            .map(|block| block.iter().fold(0, |acc, i| acc ^ i))
            .collect();
        
        dense_hash
            .iter()
            .map(|&n| format!("{:02x}", n))
            .collect::<String>()
    }
}
