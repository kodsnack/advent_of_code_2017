extern crate day4;

#[test]
fn test_parta_valid() {
    assert_eq!(true, day4::Day4::is_valid_passphrase_a("aa bb cc dd ee"));
}

#[test]
fn test_parta_invalid() {
    assert_eq!(false, day4::Day4::is_valid_passphrase_a("aa bb cc dd aa"));
}

#[test]
fn test_parta_valid_different_substr() {
    assert_eq!(true, day4::Day4::is_valid_passphrase_a("aa bb cc dd aaa"));
}

#[test]
fn test_partb_valid_simple() {
    assert_eq!(true, day4::Day4::is_valid_passphrase_a("abcde fghij"));
}

#[test]
fn test_partb_invalid_simple() {
    assert_eq!(false, day4::Day4::is_valid_passphrase_b("abcde xyz ecdab"));
}

#[test]
fn test_partb_valid_another_word() {
    assert_eq!(
        true,
        day4::Day4::is_valid_passphrase_b("a ab abc abd abf abj")
    );
}

#[test]
fn test_partb_valid_oo() {
    assert_eq!(
        true,
        day4::Day4::is_valid_passphrase_b("iiii oiii ooii oooi oooo")
    );
}


#[test]
fn test_partb_valid_repeating() {
    assert_eq!(
        false,
        day4::Day4::is_valid_passphrase_b("oiii ioii iioi iiio")
    );
}

#[test]
fn test_all() {
    let task = day4::Day4::run();
    println!("\rpartA: {}\r\n partB: {}", task.0, task.1);
    assert_eq!((!task.0, !task.1), task);
}
