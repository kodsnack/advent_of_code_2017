#!/bin/bash
INPUT=$(mktemp)
NAMES=$(mktemp)
SCRIPT=$(mktemp)

cat > "${INPUT}"

cat "${INPUT}" | cut -d ' ' -f 1 | sort -u > "${NAMES}"

cat "${NAMES}" | sed 's/$/ = 0/' > "${SCRIPT}"

cat >> "${SCRIPT}" << EOF

max_ever = 0

def updatemax():
    global max_ever
    max_ever = max(max_ever, getmax())

def getmax():
    return max([
EOF
cat "${NAMES}" | sed 's/.*/        &,/' >> "${SCRIPT}"
cat >> "${SCRIPT}" << EOF
    ])

EOF

cat "${INPUT}" | sed 's/ inc / += /' | sed 's/ dec / -= /' | sed 's/$/ else 0\nupdatemax()/' >> "${SCRIPT}"

cat >> "${SCRIPT}" << EOF

print("A:", getmax())
print("B:", max_ever)
EOF

python "${SCRIPT}"

rm -f "${INPUT}" "${SCRIPT}" "${NAMES}"
