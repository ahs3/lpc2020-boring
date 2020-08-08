#
#	Build usable docs
#

ASCIIDOCTOR = asciidoctor
SLIDES = lpc2020-boring
PANDOC = pandoc
PARTS =

# Build the "slides"
all: $(SLIDES).md $(SLIDES).pdf $(SLIDES).html

$(SLIDES).md: $(SLIDES).xml
	$(PANDOC) -f docbook -t markdown_strict $< -o $@ 

$(SLIDES).xml: $(SLIDES).adoc
	$(ASCIIDOCTOR) -b docbook $<

$(SLIDES).pdf: $(SLIDES).adoc
	$(ASCIIDOCTOR) -r asciidoctor-pdf -b pdf $<

$(SLIDES).html: $(SLIDES).adoc
	$(ASCIIDOCTOR) -b html $<

$(SLIDES).adoc: $(PARTS)
	touch $@

clean:
	rm -f $(SLIDES).xml
	rm -f $(SLIDES).md
	rm -f $(SLIDES).pdf
	rm -f $(SLIDES).html

install-debs:
	sudo apt-get install pandoc asciidoctor ruby-asciidoctor-pdf

install-rpms:
	sudo dnf install pandoc rubygem-asciidoctor rubygem-asciidoctor-pdf

