# pdfmerge

A simple script to merge two PDF files into one.

## Requirements

- macOS
- Python 3 (`python3 --version` to check)

## Setup

**1. Clone or download** this folder to your machine.

**2. Make the script executable:**
```bash
chmod +x merge_pdfs.sh
```

**3. Add an alias** so you can run it from anywhere:
```bash
echo "alias pdfmerge='bash /full/path/to/merge_pdfs.sh'" >> ~/.zshrc
source ~/.zshrc
```
> Replace `/full/path/to/` with the actual path to the folder. Run `pwd` inside the folder if unsure.

## Usage

```bash
pdfmerge document1.pdf document2.pdf
pdfmerge document1.pdf document2.pdf output.pdf
```

- **output** is optional — if omitted, the output file will be named `document1-merged.pdf`
- The merged file is saved in your **current directory**

## How it works

Each time you run the script it will:
1. Create a temporary Python virtual environment
2. Install the `pypdf` library
3. Merge the two PDFs
4. Clean up the virtual environment
