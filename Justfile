run:
    cargo run --release data/codex.um

basic-hack:
    cat <(echo -en 'guest\nmail\ncd code\nrm hack.bas\n/bin/umodem hack.bas EOF\n') src/hack.bas <(echo -en 'EOF/bin/qbasic hack.bas\n./hack.exe ftd\n./hack.exe knr\n./hack.exe gardener\n./hack.exe ohmega\n./hack.exe yang\n./hack.exe howie\n./hack.exe hmonk\n./hack.exe bbarker\n') \
        | cargo run --release data/codex.um

advise-arith:
    cat <(echo -en 'hmonk\nCOMEFROM\nrm arith.adv\n/bin/umodem arith.adv EOF\n') src/arith.adv <(echo -en 'EOF./advise arith arith.adv\n') \
        | cargo run --release data/codex.um

decompress:
    echo -En '(\b.bb)(\v.vv)06FHPVboundvarHRAkp' | cargo run --release data/codex.umz | tail -c +193 1>data/codex.um

clean:
    cargo clean
    rm -f data/codex.um

benchmark:
    cargo run --release data/sandmark.umz | diff -s data/sandmark-output.txt -
