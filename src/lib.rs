#![feature(iter_array_chunks)]

use std::io::{Read, Write};

pub struct UniversalMachine {
    register: [u32; 8],
    array: Vec<Option<Vec<u32>>>,
    available_arrays: Vec<u32>,
    pc: usize,
}

impl UniversalMachine {
    fn init(program: &[u8]) -> Self {
        let program = program
            .iter()
            .copied()
            .array_chunks()
            .map(u32::from_be_bytes)
            .collect();

        Self {
            register: [0; 8],
            array: vec![Some(program)],
            available_arrays: vec![],
            pc: 0,
        }
    }

    #[inline]
    fn operation(instruction: u32) -> u32 {
        (instruction >> 28) & 0b1111
    }

    #[inline]
    fn registers(instruction: u32) -> [usize; 3] {
        [
            ((instruction >> 6) & 0b111) as usize,
            ((instruction >> 3) & 0b111) as usize,
            (instruction & 0b111) as usize,
        ]
    }

    fn run(mut self, input: &mut impl Read, output: &mut impl Write) {
        loop {
            let instruction = self.array[0].as_ref().unwrap()[self.pc];

            match Self::operation(instruction) {
                // Conditional Move
                0 => {
                    let [a, b, c] = Self::registers(instruction);

                    if self.register[c] != 0 {
                        self.register[a] = self.register[b];
                    }
                }
                // Array Index
                1 => {
                    let [a, b, c] = Self::registers(instruction);

                    self.register[a] = self.array[self.register[b] as usize].as_ref().unwrap()
                        [self.register[c] as usize];
                }
                // Array Amendment
                2 => {
                    let [a, b, c] = Self::registers(instruction);

                    self.array[self.register[a] as usize].as_mut().unwrap()
                        [self.register[b] as usize] = self.register[c];
                }
                // Addition
                3 => {
                    let [a, b, c] = Self::registers(instruction);

                    self.register[a] = u32::wrapping_add(self.register[b], self.register[c]);
                }
                // Multiplication
                4 => {
                    let [a, b, c] = Self::registers(instruction);

                    self.register[a] = u32::wrapping_mul(self.register[b], self.register[c]);
                }
                // Division
                5 => {
                    let [a, b, c] = Self::registers(instruction);

                    self.register[a] = self.register[b] / self.register[c];
                }
                // Not-And
                6 => {
                    let [a, b, c] = Self::registers(instruction);

                    self.register[a] = !(self.register[b] & self.register[c]);
                }
                // Halt
                7 => {
                    break;
                }
                // Allocation
                8 => {
                    let [_, b, c] = Self::registers(instruction);

                    let i = self.available_arrays.pop().unwrap_or_else(|| {
                        self.array.push(None);
                        (self.array.len() - 1).try_into().unwrap()
                    });
                    let n = self.register[c];

                    self.register[b] = i;
                    self.array[i as usize] = Some(vec![0; n as usize]);
                }
                // Abandonment
                9 => {
                    let [_, _, c] = Self::registers(instruction);

                    let i = self.register[c];

                    self.array[i as usize] = None;
                    self.available_arrays.push(i);
                }
                // Output
                10 => {
                    let [_, _, c] = Self::registers(instruction);

                    let v = self.register[c].try_into().unwrap();
                    assert!(output.write_all(std::slice::from_ref(&v)).is_ok());
                }
                // Input
                11 => {
                    let [_, _, c] = Self::registers(instruction);

                    assert!(output.flush().is_ok());

                    let mut v = 0;
                    let v = match input.read_exact(std::slice::from_mut(&mut v)) {
                        Ok(()) => u32::from(v),
                        Err(_) => u32::MAX,
                    };

                    self.register[c] = v;
                }
                // Load Program
                12 => {
                    let [_, b, c] = Self::registers(instruction);

                    if self.register[b] != 0 {
                        self.array[0] = self.array[self.register[b] as usize].clone();
                    }
                    self.pc = self.register[c] as usize;

                    continue;
                }
                // Orthography
                13 => {
                    let a = ((instruction >> 25) & 0b111) as usize;
                    let v = instruction & ((1 << 25) - 1);

                    self.register[a] = v;
                }
                _ => {
                    panic!("invalid operation");
                }
            }

            self.pc += 1;
        }
    }

    pub fn execute(program: &[u8], input: &mut impl Read, output: &mut impl Write) {
        let um = Self::init(program);
        um.run(input, output);
    }
}
