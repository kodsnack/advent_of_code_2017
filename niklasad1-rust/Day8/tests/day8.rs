extern crate day8;

#[test]
fn test_simple() {
    if let Ok(input) = day8::ReadFile::read_file_to_string("test.txt") {
        let lines = input.lines().collect::<Vec<_>>();
        assert_eq!((1, 10), day8::Cpu::new(&lines).run());
    }
}
#[test]
fn test_all() {
    if let Ok(input) = day8::ReadFile::read_file_to_string("input.txt") {
        let lines = input.lines().collect::<Vec<_>>();
        assert_eq!((0, 0), day8::Cpu::new(&lines).run());
    }
}
