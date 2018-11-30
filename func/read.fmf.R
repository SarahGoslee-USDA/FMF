read.fmf <- function(filename, desc) {
	# read formatted text file
	# filename: file on disk
	# desc: format description

	# output: a list of data frames
	#   data frames because they can hold multiple formats

	if(!is.null(desc$doc)) {
		cat("Reading ", desc$doc, " from ", filename, "\n")
		desc <- desc[!(names(desc) %in% c("doc"))]
	} else {
		cat("Reading ", filename, "\n")
	}


	result <- vector(length=length(desc$rowspec), mode="list")

    if(desc$terminal == "\n" & !is.na(desc$terminal)) {
        file.delim <- ""
    } else {
        file.delim <- desc$terminal
    }

	infile <- readLines(filename)
	if(!is.na(file.delim)) {
		# ignore everything after file.delim
		if(any(grepl(paste0("^", file.delim, "*$"), infile))) {
			infile <- infile[1:(min(which(grepl(paste0("^", file.delim, "*$"), infile)))-1)]
		}
	}

	sec.len <- as.vector(sapply(desc$rowspec, function(x)x$times))

    if(length(sec.len) == 1 && is.na(sec.len)) sec.len <- length(infile)

	rfields <- make.fields(sec.len)
	if(max(rfields, na.rm=TRUE) > length(infile)) {
		warning("Fewer lines than sections; padding output with NA.\n", call.=FALSE)
	}

	if(is.na(rfields[nrow(rfields), 2])) {
		rfields[nrow(rfields), 2] <- length(infile)
	}

	for(thissecno in seq_along(desc$rowspec)) {
		thissection <- infile[rfields[thissecno, 1]:rfields[thissecno, 2]]
		thissection.out <- data.frame(matrix(NA_character_, nrow=length(thissection), ncol=length(desc$rowspec[[thissecno]]$len)), stringsAsFactors=FALSE)
		colnames(thissection.out) <- desc$rowspec[[thissecno]]$names

		for(i in seq_along(thissection)) {
			thissection.out[i, ] <- read.row(desc$rowspec[[thissecno]]$len, thisrow=thissection[i], free.delim=desc$rowspec[[thissecno]]$delim)
		}

		for(i in seq_len(ncol(thissection.out))) {
			thisfmt <- desc$rowspec[[thissecno]]$fmt
			if(thisfmt[i] != "c") {
				thissection.out[[i]] <- type.convert(thissection.out[[i]], as.is=TRUE)
			}
		}

		result[[thissecno]] <- thissection.out
	}

	result
}

