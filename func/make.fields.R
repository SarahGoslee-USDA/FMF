make.fields <- function(rlength, startpos=1) {
	# generate start and end positions for fixed-width fields
	# rlength: vector containing length of each field; NA for free-format
	# inverse of make.flen
	last.free <- FALSE
	if(any(is.na(rlength))) {
		if(which(is.na(rlength)) != length(rlength)) {
			stop("Only final field can be free-form unless file is delimited.\n")
		} else {
			rlength <- rlength[!is.na(rlength)]
			last.free <- TRUE
		}
	}
	fend <- cumsum(rlength)
	fstart <- c(1, fend[-length(fend)] + 1)
	ffields <- data.frame(fstart, fend) + startpos - 1
	if(last.free) {
		ffields <- rbind(ffields, c(ffields[nrow(ffields), 2] + 1, NA))
	}
	ffields
}

