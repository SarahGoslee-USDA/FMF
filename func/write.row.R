write.row <- function(rlength, rfmt, rjust, rvalue, filename, eol="\r\n", append=TRUE, truncToFit=TRUE, free.delim="  ") {
	# assemble a fixed-width and precision row
	# rlength: vector containing length of each field; NA for free-format
	# rfmt: vector containing number of decimal places of each field, or "c" or "i"
    #  - if number of decimal places is 0, write eg 123. instead of 123
    #    because FORTRAN distinguishes between floats with no decimals and integers
	# if truncToFit, decimal places of floating-point values will be truncated as needed to fit
	# rvalue: vector containing values for each field
	# filename: file to create or append to
	#  - would be more efficient to use an open connection, but not worthwhile for files this size

	# padded with spaces
    #  - numeric padded on left
    #  - character padded on right
	# free-format fields are separated with free.delim
	#  - not used; hook for later

	n <- length(rlength)
	if(length(rfmt) != n) stop("rlength and rfmt are different lengths.\n")
	if(length(rvalue) != n) stop("rlength and rvalue are different lengths.\n")

	# strip off trailing NA padding
	while(is.na(rvalue[n])) {
		rvalue <- rvalue[-n]
		rfmt <- rfmt[-n]
		rlength <- rlength[-n]
		n <- length(rlength)
	}

	thisrow <- ""
	for(i in seq_len(n)) {
		thisval <- rvalue[i]

		if(is.na(thisval)) {
			thisval <- ""
		} else {

			# convert to appropriate format
			if(rfmt[i] == "i") {
				thisval <- round(thisval)
			}
			if(is.numeric(type.convert(rfmt[i])) & rfmt[i] == 0) {
				thisval <- paste0(sprintf("%0.f", thisval), ".")
			}
			if(is.numeric(type.convert(rfmt[i])) & rfmt[i] > 0) {
				thisval <- sprintf(paste0("%0.", rfmt[i], "f"), thisval)
			}
			
			thisval <- as.character(thisval)
		}


		# rlength of NA indicates a free-format field
		if(is.na(rlength[i])) {
			# free-format fields are separated with free.delim
            if(i > 1)
			    thisval <- paste0(free.delim, thisval)
		} else {
			# fixed-width field

			# value cannot be longer than field length
			if(nchar(thisval) > rlength[i]) {
				if(rfmt[i] == "c" | rfmt[i] == "i") {
					stop("Value ", rvalue[i], " doesn't fit in ", rlength[i], " characters.\n")
				} else {
					if(truncToFit) {
						# shorten it to fit by removing decimal places
						while(nchar(thisval) > rlength[i] | substring(thisval, nchar(thisval), nchar(thisval)) != ".") {
							thisval <- substring(thisval, 1, nchar(thisval) - 1)
						}
					}
					if(nchar(thisval) > rlength[i])
						stop("Value ", rvalue[i], " doesn't fit in ", rlength[i], " characters.\n")
				}
			}

			if(rjust[i] == "l") {
                thisval <- sprintf(paste0("%-", rlength[i], "s"), thisval)
            } else {
                thisval <- sprintf(paste0("% ", rlength[i], "s"), thisval)
            }
		}
		thisrow <- paste0(thisrow, thisval)
	}

    cat(paste0(thisrow, eol), file=filename, append=TRUE)
	invisible()
}


