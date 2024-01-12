run:
    cargo run --release data/codex.um

decompress:
    echo -En '(\b.bb)(\v.vv)06FHPVboundvarHRAkp' | cargo run --release data/codex.umz | tail -c +193 1>data/codex.um

clean:
    cargo clean
    rm -f data/codex.um

benchmark:
    cargo run --release data/sandmark.umz | diff -s data/sandmark-output.txt -
