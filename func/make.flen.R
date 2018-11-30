make.flen <- function(fieldstart, fieldend) {

	# calculate lengths for fixed-width start and end
	# inverse of make.fields

    # can take either a matrix with start and end in columns 1 and 2
    # or two vectors of start and end


    if(!is.null(dim(fieldstart))) {
        fieldend <- fieldstart[, 2]
        fieldstart <- fieldstart[, 1]
    }

	fieldend - fieldstart + 1
}

