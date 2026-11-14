fn highlight_lines(lines: Vec<String>) -> Vec<String> {
    let mut seed = std::time::SystemTime::now()
        .duration_since(std::time::UNIX_EPOCH)
        .map(|d| d.as_nanos() as u64)
        .unwrap_or(0x9E37_79B9_7F4A_7C15);
    const COLORS: [&str; 7] = [
        "\x1b[31m", "\x1b[32m", "\x1b[33m", "\x1b[34m", "\x1b[35m", "\x1b[36m", "\x1b[37m",
    ];
    lines
        .into_iter()
        .map(|line| {
            seed ^= seed << 13;
            seed ^= seed >> 7;
            seed ^= seed << 17;
            format!("{}{}{}", COLORS[(seed % 7) as usize], line, "\x1b[0m")
        })
        .collect()
}

pub fn bash(file: &str, highlight: bool) -> Vec<String> {
    if file != "shared.sh" {
        return Vec::new();
    }
    let lines = [
        "[WELCOME TO shared.sh HELP]",
        "",
        "Usage:",
        "  source \"shared.sh\"",
        "",
        "Open functions:",
        "  NowTime [color]",
        "      Print the current timestamp. Pass \"True\" as color to wrap",
        "      the timestamp in ANSI color escapes.",
        "  MsgFatal --color --msgot <msg>",
        "      Print a fatal-level log line to STDOUT.",
        "  MsgError --color --msgot <msg>",
        "      Print an error-level log line to STDOUT.",
        "  MsgAllow --color --msgot <msg>",
        "      Print an allow-level log line to STDOUT.",
        "  MsgInfo --color --msgot <msg>",
        "      Print an info-level log line to STDOUT.",
        "  MsgWarn --color --msgot <msg>",
        "      Print a warning-level log line to STDOUT.",
        "  MsgDone --color --msgot <msg>",
        "      Print a done-level log line to STDOUT.",
        "",
        "Open constants:",
        "  RESET BLACK RED GREEN YELLOW BLUE PURPLE CYAN WHITE",
        "      ANSI color escape sequences for terminal styling.",
        "  ONCE_TIME",
        "      Timestamp captured when this file was sourced.",
        "",
        "Forbidden members (must NOT be used by other files):",
        "  Constants: __ANSI__ __FONT__ __CHAR__ __SEMI_RED__ __SEMI__",
        "             __FATAL__ __ERROR__ __ALLOW__ __INFO__ __WARN__",
        "             __DONE__",
        "  Functions: none.",
    ]
    .map(String::from)
    .to_vec();
    if highlight {
        highlight_lines(lines)
    } else {
        lines
    }
}

pub fn ps1(_file: &str, _highlight: bool) -> Vec<String> {
    vec![String::from("")]
}

pub fn py3(_file: &str, _highlight: bool) -> Vec<String> {
    vec![String::from("")]
}

pub fn ccxx(_file: &str, _highlight: bool) -> Vec<String> {
    vec![String::from("")]
}
