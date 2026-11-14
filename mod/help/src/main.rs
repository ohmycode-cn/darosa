mod help;

fn rund() {
    let args: Vec<String> = std::env::args().skip(1).collect();
    let mut highlight = false;
    let mut language = "";
    let mut file = "";
    for arg in &args {
        match arg.as_str() {
            "--color" => highlight = true,
            "--bash" | "--ps1" | "--py3" | "--ccxx" => language = arg.as_str(),
            _ => file = arg.as_str(),
        }
    }
    if language.is_empty() || file.is_empty() {
        eprintln!("Usage: help [--color] --bash|--ps1|--py3|--ccxx <file>");
        return;
    }
    let lines = match language {
        "--bash" => help::bash(file, highlight),
        "--ps1" => help::ps1(file, highlight),
        "--py3" => help::py3(file, highlight),
        "--ccxx" => help::ccxx(file, highlight),
        _ => Vec::new(),
    };
    for line in lines {
        println!("{}", line);
    }
}

fn main() {
    rund();
}
