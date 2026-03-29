#!/bin/bash

: <<'COMMENT'
    Usage: ./merge_pdfs.sh <pdf1> <pdf2> [output]

    Setup:
        1. make it runnable 'chmod +x merge_pdfs.sh'
COMMENT

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "⚠️ Usage: ./merge_pdfs.sh <pdf1> <pdf2> [output]"
    exit 1
fi

PDF1="$1"
PDF2="$2"
OUTPUT="${3:-$(basename "$PDF1" .pdf)-merged.pdf}"

if [ -f "$OUTPUT" ]; then
    BASE=$(basename "$OUTPUT" .pdf)
    DIR=$(dirname "$OUTPUT")
    COUNTER=1
    while [ -f "$DIR/$BASE ($COUNTER).pdf" ]; do
        COUNTER=$((COUNTER + 1))
    done
    OUTPUT="${BASE} ($COUNTER).pdf"
    echo "⚠️  Output already exists, saving as '$OUTPUT' instead"
fi

SCRIPT_DIR="$(dirname "$0")"

# Setup
python3 -m venv "$SCRIPT_DIR/venv"
source "$SCRIPT_DIR/venv/bin/activate"
pip install pypdf --quiet

# Merge
python3 - "$PDF1" "$PDF2" "$OUTPUT" <<'EOF'
import sys
from pypdf import PdfReader, PdfWriter
from pathlib import Path

pdf1, pdf2, output = sys.argv[1], sys.argv[2], sys.argv[3]

for f in (pdf1, pdf2):
    if not Path(f).exists():
        print(f"❌ Error: File not found: {f}")
        sys.exit(1)

writer = PdfWriter()
for pdf_path in (pdf1, pdf2):
    reader = PdfReader(pdf_path)
    pages = len(reader.pages)
    print(f"  📄 Adding '{Path(pdf_path).name}' ({pages} page{'s' if pages != 1 else ''})")
    for page in reader.pages:
        writer.add_page(page)

with open(output, "wb") as f:
    writer.write(f)

print(f"\n✅ Done! - '{output}' created")
EOF

# Cleanup
deactivate
rm -rf "$SCRIPT_DIR/venv"
