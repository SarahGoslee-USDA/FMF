make.section <- function(rlength, rfmt, rjust, times = 1, rnames, rdoc, rfielddoc, ctype = NA, cval = NA, delim = NA) {
	# create specification for a fixed-width and precision row or rows
	# rlength: vector containing length of each field; NA for free-format
	# rfmt: vector containing number of decimal places of each field, or 
	#   "c" for char or "i" for integer
	#   OR a single value which will be repeated as necessary
	#   can be gotten from a character vector with make.fmt()
    #   note that in FORTRAN 0 decimal places is not the same as integer
    # rjust: justify the info to the left or right of the field width
    #   - default is right for numeric and left for character
	# times: a row can be repeated a fixed number of times, or until end of file (times = NA)
	# rnames: field names for this section; may be omitted
	# rdoc: documentation for this section (overview); may be omitted
	# rfielddoc: documentation for each field; may be omitted

    # constraints: specified by two arguments:
    # (would this make more sense as a list?)
    #   ctype: "r" for range, "l" for list of possible values; NA for none
    #   cval: the required range eg c(0, 10) or list eg c(-1, 0, 1, 2); NA for none

	# free-format fields are separated with delim

    n <- length(rlength)

	# default format is character
	if(missing(rfmt)) rfmt <- rep("c", n)
    if(!all(rfmt %in% c("c", "i", seq(0, 10)))) 
        stop("Format in rfmt must be c, i, or number of decimal places 0-10.\n")

    if(missing(rjust)) {
        rjust <- rep("r", n)
        rjust[rfmt == "c"] <- "l"
    }
    if(!all(rjust %in% c("r", "l", NA))) 
        stop("Justification in rjust must be l or r.\n")

	if(missing(rnames)) rnames <- paste0("col", seq_len(n))

	if(missing(rdoc)) rdoc <- NA_character_

	if(missing(rfielddoc)) rfielddoc <- rep(NA_character_, length.out=n)

	if(length(rfmt) == 1) {
		# repeat a single value the right number of times
		rfmt <- rep(rfmt, length.out=n)
	}
	# pad rfmt with default values if needed
    if(length(rfmt) < n) {
	    rfmt <- c(rfmt, rep("c", length.out = (n - length(rfmt))))
    }

	if(length(rjust) == 1) {
		# repeat a single value the right number of times
		rjust <- rep(rjust, length.out=n)
	}
	# pad rjust with default values if needed
    if(length(rjust) < n) {
        rjustdefault <- rep("r", n)
        rjustdefault[rfmt == "c"] <- "l"
        rjustdefault <- rjustdefault[seq(length(rjust) + 1, n)]

        rjust <- c(rjust, rjustdefault)
    }

	# pad ctype with default value if needed
    if(length(ctype) < n) {
        ctypedefault <- rep(NA, n)
        ctypedefault <- ctypedefault[seq(length(ctype) + 1, n)]

        ctype <- c(ctype, ctypedefault)
    }

	# pad cval with default value if needed
    if(length(cval) < n) {
        cvaldefault <- rep(NA, n)
        cvaldefault <- cvaldefault[seq(length(cval) + 1, n)]

        cval <- c(cval, cvaldefault)
    }



	list(len=rlength, fmt=rfmt, just=rjust, times = times, names = rnames, doc = rdoc, constraints = list(ctype = ctype, cval = cval), fielddoc = rfielddoc, delim=delim)
}

