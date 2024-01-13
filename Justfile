run:
    cargo run --release data/codex.um

decompress:
    echo -En '(\b.bb)(\v.vv)06FHPVboundvarHRAkp' | cargo run --release data/codex.umz | tail -c +193 1>data/codex.um

benchmark:
    cargo run --release data/sandmark.umz | diff -s data/sandmark-output.txt -


login-guest:
    cat <(echo guest) - | just run

login-ftd:
    cat <(echo ftd) <(echo falderal90) - | just run

login-knr:
    cat <(echo knr) <(echo ???) - | just run

login-gardener:
    cat <(echo gardener) <(echo mathemantica) - | just run

login-ohmega:
    cat <(echo ohmega) <(echo bidirectional) - | just run

login-yang:
    cat <(echo yang) <(echo U+262F) - | just run

login-howie:
    cat <(echo howie) <(echo xyzzy) - | just run

login-hmonk:
    cat <(echo hmonk) <(echo COMEFROM) - | just run

login-bbarker:
    cat <(echo bbarker) <(echo plinko) - | just run
