Hier is een gedetailleerde aanpak voor de oefeningen in **Labo 9.4: Makefiles**:

---

### **9.4.1 Hello!**
1. **Run `make` twice**:
   - The first run compiles `hello.c` into an executable (`hello`).
   - The second run doesn’t recompile because the output (`hello`) is up to date with `hello.c`.

2. **Run the executable**:
   - Execute `./hello` to verify it works.

3. **Touch the source file**:
   - Running `touch hello.c` updates its modification time.
   - When you run `make` again, the file is recompiled because `hello.c` is newer than `hello`.

4. **Add a newline**:
   - Modify `hello.c` to include `\n` in the `printf` statement for proper output formatting.
   - Example change:
     ```c
     printf("Hello, World!\n");
     ```

5. **Add a `clean` rule**:
   - Update the Makefile:
     ```makefile
     clean:
         rm -f hello
     ```
   - Run `make clean` to remove the executable, and `make` to recompile.

6. **Test Bash completion**:
   - If Bash completion is installed, pressing `<TAB><TAB>` after `make` should list the available targets (`all`, `clean`).

---

### **9.4.2 Booleans**
1. **Compile `true`**:
   - Run `make` to build the `true` executable.
   - To ensure you're running the custom `true`, use `./true` in the current directory.

2. **Implement `false`**:
   - Add a `false.c` file:
     ```c
     #include <stdio.h>
     int main() {
         return 1;
     }
     ```
   - Add a rule for `false` in the Makefile.

3. **Declare a `targets` variable**:
   - Update the Makefile:
     ```makefile
     targets = true false
     ```

4. **Add an `all` rule**:
   - Use the `targets` variable:
     ```makefile
     all: $(targets)
     ```

5. **Replace specific rules with a pattern rule**:
   - Simplify the Makefile:
     ```makefile
     %.o: %.c
         gcc -o $@ $<
     ```

6. **Add a `clean` rule**:
   - Clean up all executables:
     ```makefile
     clean:
         rm -f $(targets)
     ```

---

### **9.4.3 PDF Documenten Genereren**
1. **Basic Makefile**:
   - Create a Makefile to compile `example.tex`:
     ```makefile
     LATEX = xelatex
     LATEX_FLAGS = -synctex=1 -interaction=nonstopmode -shell-escape

     example.pdf: example.tex
         $(LATEX) $(LATEX_FLAGS) $<
     ```

2. **Pattern Rule**:
   - Generalize the rule for any `.tex` file:
     ```makefile
     %.pdf: %.tex
         $(LATEX) $(LATEX_FLAGS) $<
     ```

3. **Define variables for all `.tex` and `.pdf` files**:
   ```makefile
   sources = $(wildcard *.tex)
   pdfs = $(patsubst %.tex, %.pdf, $(sources))
   ```

4. **Add `all` rule**:
   - Ensure all PDFs are built:
     ```makefile
     all: $(pdfs)
     ```

5. **Clean and `mrproper` rules**:
   - Add cleanup rules:
     ```makefile
     aux_files = *.aux *.log *.out *.synctex.gz
     clean:
         rm -f $(aux_files)
     mrproper: clean
         rm -f $(pdfs)
     ```

6. **Add `help` rule**:
   - Display available targets:
     ```makefile
     help:
         @echo "The following build targets are available:"
         @echo "  help          Show this help message (default)"
         @echo "  all           Generate all PDFs"
         @echo "  clean         Clean up auxiliary files"
         @echo "  mrproper      Clean up auxiliary files and PDFs"
         @echo "  Individual targets:"
         @echo "  $(pdfs)"
     ```

7. **Repeat LaTeX Compilation**:
   - Re-run LaTeX for cross-references:
     ```makefile
     %.pdf: %.tex
         while $(LATEX) $(LATEX_FLAGS) $< | grep -q "Rerun to get cross-references right"; do :; done
     ```

8. **Add `.gitignore`**:
   - Include patterns for LaTeX temporary files:
     ```
     *.aux
     *.log
     *.synctex.gz
     *.out
     *.pdf
     ```

---

### **9.4.4 Markdown to Reveal.js**
1. **Prepare Environment**:
   - Create a `slides` directory and download the necessary files:
     ```bash
     mkdir -p slides
     cd slides
     wget https://example.com/hogent.css
     wget https://example.com/Makefile
     ```

2. **Create a Markdown File**:
   - Write a sample Markdown file (`slides.md`):
     ```markdown
     # Slide 1
     - Welcome to the presentation

     # Slide 2
     - This is another slide
     ```

3. **Build HTML Slides**:
   - Run `make` in the `slides` directory.  
   - Example Makefile target:
     ```makefile
     slides.html: slides.md hogent.css
         pandoc -s -t revealjs -o $@ --css hogent.css $<
     ```

4. **Generate PDF Handouts**:
   - Add a rule for generating PDFs:
     ```makefile
     slides.pdf: slides.md
         pandoc -s -o $@ $<
     ```

---

### **Summary**
- **Hello and Booleans**: Demonstrates basic compilation and Makefile rules.
- **LaTeX PDF Generation**: Applies advanced features like pattern rules, wildcard functions, and cleanup.
- **Markdown to Reveal.js**: Highlights the flexibility of Makefiles for various build processes beyond code compilation.