write.fmf <- function(x, desc, filename, eol="\r\n") {
	# save a formatted object x to disk using format description desc

	# create empty file
	cat("", file = filename, append=FALSE)

	if(!is.null(desc$doc)) {
		cat("Writing ", desc$doc, " to ", filename, "\n")
		desc <- desc[!(names(desc) %in% c("doc"))]
	} else {
		cat("Writing ", filename, "\n")
	}

	for(thissecno in seq_along(desc$rowspec)) {
		thisdesc <- desc$rowspec[[thissecno]]
		thissection <- x[[thissecno]]

		for(i in seq_len(nrow(thissection))) {
			write.row(thisdesc$len, thisdesc$fmt, thisdesc$just, thissection[i,], filename)
		}
	}

    if(!is.na(desc$terminal)) {
        cat(paste0(desc$terminal, eol), file=filename, append=TRUE)
    }
    
	invisible()
}

