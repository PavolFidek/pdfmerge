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

---

## Add MacOS automation by Automator
1. Workflow receives: PDF files
2. In: Finder
3. Shell: /bin/bash
4. Script:

```bash
if [ "$#" -ne 2 ]; then
  osascript -e 'display alert "Please select exactly 2 PDF files."'
  exit 1
fi

for f in "$1" "$2"; do
  case "${f:l}" in
    *.pdf) ;;
    *)
      osascript -e 'display alert "Both selected files must be PDFs."'
      exit 1
      ;;
  esac
done

"/<youpath>/pdfmerge/merge_pdfs.sh" "$1" "$2"
```

## Create a keyboard shortcut
1. Open System Settings.
2. Go to Keyboard.
3. Click Keyboard Shortcuts….
4. Select Services (on some macOS versions this may be called Quick Actions).
5. Find your Automator Quick Action in the list. It's under "Files and Folders" category.
6. Click none (or the existing shortcut) next to it.
7. Press the key combination you want to assign
8. Press Done. The shortcut is saved immediately.
