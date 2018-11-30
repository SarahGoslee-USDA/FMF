read.row <- function(thisrow, rlength, free.delim=" ") {
	# parse a formatted string
	# rlength: vector containing length of each field; NA for free-format
	# multiple free-format fields are separated by free.delim

	# can't use gdata:read.fwf() directly because of the possibility of free-form fields
	if(missing(thisrow)) {
		thisrow <- scan(filename, what=character(), skip = rownum - 1, nlines = 1, sep = NULL, multi.line=FALSE)
	}

    if(all(is.na(rlength))) {
        results <- strsplit(thisrow, paste0(free.delim, "+"))[[1]]
    } else {

        rfields <- make.fields(rlength)
        if(max(rfields, na.rm=TRUE) > nchar(thisrow))
            cat("Not enough data; padding fields with NA.\n")
        
        if(is.na(rfields[nrow(rfields), 2]))
            rfields[nrow(rfields), 2] <- nchar(thisrow)

        results <- rep(NA, length(rlength))

        for(i in seq_along(rlength)) {
            thisval <- substring(thisrow, rfields[i, 1], rfields[i, 2])
            if(grepl("^\\s+$", thisval)) { 
                thisval <- NA_character_
            } else {
                thisval <- sub("^\\s+", "", thisval) # strip leading whitespace
                thisval <- sub("\\s+$", "", thisval) # strip trailing whitespace
                results[i] <- thisval
            }
        }
    }
    
	# returns character; need to handle type conversion later
	results
}

