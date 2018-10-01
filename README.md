# BIOL115L-MSUM.github.io

Main repository for BIOL 115L Organismal Biology Lab @ Minnesota State University Moorhead, featuring an introduction to data analysis.

## Data

Finch Data Source:
- https://www.hhmi.org/biointeractive/evolution-action-data-analysis
- This is saved in [data/Finches_Dataset.xls](data/Finches_Dataset.xls)

## Web design

### R Markdown Websites

Here are some resources for understanding how this site was built using R Markdown documents and hosted on GitHub:

- [R Markdown Websites](https://rmarkdown.rstudio.com/rmarkdown_websites.htm)
- [HTML document](https://bookdown.org/yihui/rmarkdown/html-document.html), section from [R Markdown: The Definitive Guide](https://bookdown.org/yihui/rmarkdown/)

### CSS

This website uses the Flatly theme, from Bootswatch, which is based on Bootstrap. Here are some resources useful for understanding the CSS:

- [Bootstrap documentation](https://getbootstrap.com/docs/4.1/getting-started/introduction/)
- [Flatly documentation](https://bootswatch.com/3/flatly/)

### Lightbox

I installed lightbox to make viewing screenshots easier. I mostly followed the instructions here: https://lokeshdhakar.com/projects/lightbox2/

Here's an overview:
- saved lightbox.css to root drive
- saved lightbox.js to root drive
- created a lightbox.html file which contains the code to link the css file (you can't just do it in _site.yml as with styles.css because you can only have one css file in _site.yml)
- added an include in the footer.html file, just before the end of the <body> tag
- used appropriate html in the Rmd documents, instead of Rmd's shortcut code for inserting images