V        IF ARGS() > I THEN GOTO XX
X        PRINT "usage: ./hack.exe username" + CHR(X)
XV       END
XX       REM get username from command line
XXV      DIM username AS STRING
XXX      username = ARG(II)
XXXV     REM common words used in passwords
XL       DIM pwdcount AS INTEGER
XLV      pwdcount = LIII
L        DIM words(pwdcount) AS STRING
LV       words(I) = "airplane"
LX       words(II) = "alphabet"
LXV      words(III) = "aviator"
LXX      words(IV) = "bidirectional"
LXXV     words(V) = "changeme"
LXXX     words(VI) = "creosote"
LXXXV    words(VII) = "cyclone"
XC       words(VIII) = "december"
XCV      words(IX) = "dolphin"
C        words(X) = "elephant"
CV       words(XI) = "ersatz"
CX       words(XII) = "falderal"
CXV      words(XIII) = "functional"
CXX      words(XIV) = "future"
CXXV     words(XV) = "guitar"
CXXX     words(XVI) = "gymnast"
CXXXV    words(XVII) = "hello"
CXL      words(XVIII) = "imbroglio"
CXLV     words(XIX) = "january"
CL       words(XX) = "joshua"
CLV      words(XXI) = "kernel"
CLX      words(XXII) = "kingfish"
CLXV     words(XXIII) = "(\b.bb)(\v.vv)"
CLXX     words(XXIV) = "millennium"
CLXXV    words(XXV) = "monday"
CLXXX    words(XXVI) = "nemesis"
CLXXXV   words(XXVII) = "oatmeal"
CXC      words(XXVIII) = "october"
CXCV     words(XXIX) = "paladin"
CC       words(XXX) = "pass"
CCV      words(XXXI) = "password"
CCX      words(XXXII) = "penguin"
CCXV     words(XXXIII) = "polynomial"
CCXX     words(XXXIV) = "popcorn"
CCXXV    words(XXXV) = "qwerty"
CCXXX    words(XXXVI) = "sailor"
CCXXXV   words(XXXVII) = "swordfish"
CCXL     words(XXXVIII) = "symmetry"
CCXLV    words(XXXIX) = "system"
CCL      words(XL) = "tattoo"
CCLV     words(XLI) = "thursday"
CCLX     words(XLII) = "tinman"
CCLXV    words(XLIII) = "topography"
CCLXX    words(XLIV) = "unicorn"
CCLXXV   words(XLV) = "vader"
CCLXXX   words(XLVI) = "vampire"
CCLXXXV  words(XLVII) = "viper"
CCXC     words(XLVIII) = "warez"
CCXCV    words(XLIX) = "xanadu"
CCC      words(L) = "xyzzy"
CCCV     words(LI) = "zephyr"
CCCX     words(LII) = "zeppelin"
CCCXV    words(LIII) = "zxcvbnm"
CCCXX    REM try each password
CCCXXV   DIM i AS INTEGER
CCCXXX   DIM j AS INTEGER
CCCXXXV  DIM k AS INTEGER
CCCXL    DIM pass AS STRING
CCCXLV   i = I
CCCL     pass = words(i)
CCCLV    IF CHECKPASS(username, pass) THEN GOTO CDXX
CCCLX    j = I
CCCLXV   k = I
CCCLXX   pass = words(i) + CHR(j + XLVII) + CHR(k + XLVII)
CCCLXXV  IF CHECKPASS(username, pass) THEN GOTO CDXX
CCCLXXX  k = k + I
CCCLXXXV IF k <= X THEN GOTO CCCLXX
CCCXC    j = j + I
CCCXCV   IF j <= X THEN GOTO CCCLXV
CD       i = i + I
CDV      IF i <= pwdcount THEN GOTO CCCL
CDX      PRINT "no matches for user " + username + CHR(X)
CDXV     END
CDXX     PRINT "found match!! for user " + username + CHR(X)
CDXXV    PRINT "password: " + pass + CHR(X)
CDXXX    END
