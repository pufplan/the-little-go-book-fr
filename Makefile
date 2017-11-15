SOURCE_FILE_NAME = go.md
BOOK_FILE_NAME = go

PDF_BUILDER = pandoc
PDF_BUILDER_FLAGS = \
	--latex-engine xelatex \
	--template ../common/pdf-template.tex \
	--listings

EPUB_BUILDER = pandoc
EPUB_BUILDER_FLAGS = \
	--epub-cover-image

MOBI_BUILDER = kindlegen


fr/go.pdf:
	cd fr && $(PDF_BUILDER) $(PDF_BUILDER_FLAGS) $(SOURCE_FILE_NAME) -o $(BOOK_FILE_NAME).pdf

fr/go.epub: fr/title.png fr/title.txt fr/go.md
	$(EPUB_BUILDER) $(EPUB_BUILDER_FLAGS) $^ -o $@

fr/go.mobi: fr/go.epub
	$(MOBI_BUILDER) $^

all: fr/go.pdf fr/go.mobi

clean:
	rm -f */$(BOOK_FILE_NAME).pdf
	rm -f */$(BOOK_FILE_NAME).epub
	rm -f */$(BOOK_FILE_NAME).mobi
