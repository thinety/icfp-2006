use std::fs::File;
use std::io::Read;

use clap::Parser;

use icfp_2006::UniversalMachine;

#[derive(Parser)]
struct Args {
    filepath: String,
}

fn main() {
    let args = Args::parse();

    let mut program = Vec::new();
    let mut file = File::open(args.filepath).unwrap();
    file.read_to_end(&mut program).unwrap();

    let mut input = std::io::stdin();
    let mut output = std::io::stdout();

    UniversalMachine::execute(&program, &mut input, &mut output);
}
