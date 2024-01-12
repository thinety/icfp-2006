use clap::Parser;

use icfp_2006::UniversalMachine;

#[derive(Parser)]
struct Args {
    filepath: String,
}

fn main() {
    let args = Args::parse();

    let program = std::fs::read(args.filepath).unwrap();

    let mut input = std::io::stdin();
    let mut output = std::io::stdout();

    UniversalMachine::execute(&program, &mut input, &mut output);
}
