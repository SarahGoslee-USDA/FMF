make.desc <- function(..., doc = NA_character_, terminal = NA) {
    # create specification for a text file comprising a series 
    # of fixed-width and fixed-precision or freeform rows
    # ending with a final row terminal

    # desc object is a list containing:
    #  - rows:  list of section specifications created by make.section()
    #  - doc:  descriptive character string
    #  - terminal: newline or fixed final row; after terminal no more lines are read
    #     if NA, read to end of file
    
    # input is a series of pairs c(row specification, number of times to be repeated)

    rowspec  <- list(...)

    list(rowspec = rowspec, doc = doc, terminal = terminal)
}


