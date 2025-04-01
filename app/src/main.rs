fn main() {
    let mut name = String::new();

    while name.is_empty() {
        println!("Enter your name: ");
        std::io::stdin().read_line(&mut name).unwrap();
        name = name.trim().to_string();
    }
    println!("Hello, {}!", name);
}
