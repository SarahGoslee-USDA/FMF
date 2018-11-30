# S-curve information taken from Cody's shinyBiomass server.R


scurvy <- function(p1, p2, add=FALSE, yrange=c(0, 100), newy=c(10, 90), ...) {
    # plot an APEX S-curve
    # p1 = c(x1, y1), p2 = c(x2, y2)

	X1 <- p1[2]/max(yrange)
	X2 <- p2[2]/max(yrange)
	X3 <- p1[1]
	X4 <- p2[1]


	# adapted from the APEX fortran code ASCRV.f90
	XX <- log(X3/X1 - X3)
	X2 <- (XX-log(X4/X2 - X4))/(X4 - X3)
	X1 <- XX + X3*X2


	#create a set of points for plotting a smooth line
	x <- seq(0, p2[1]*2, length.out=1000)
	y <- x / (x + exp(X1 - X2*x))	

	dat <- data.frame(x=x, y=y)		 

	# get the range for the x and y axis
	xrange <- range(x)

	if(!add) plot(dat, type='n', xlim=xrange, ylim=yrange/max(yrange), xlab='X', ylab='Y')
	points(c(p1[1], p2[1]), c(p1[2], p2[2])/max(yrange), ...)
	lines(dat, ...)

    # return x values at which y is newy
    # tried returning y values, but that doesn't work for steep curves like c(10, 2), c(20, 95)
    # this is a kludge
    newx <- rep(NA, length(newy))
    for(i in seq_along(newy)) {
        newx[i] <-  x[which.min(abs(y - newy[i]/max(yrange)))]
    }
    newx

}

## extract coefficients for 10 and 90%

s19 <- function(x) {
    # convenience function to plot scurvy 10%, 90% output on top of existing scurvy plot
    y <- scurvy(c(x[1], 10), c(x[2], 90), newy=c(10, 90), add=TRUE, col="red")
    
    # format x into model parameter
    x <- round(x)
    z <- rep(NA_character_, 2)
    z[1] <- paste(sprintf("%02d", x[1]), "10", sep=".")
    z[2] <- paste(sprintf("%02d", x[2]), "90", sep=".")
    print(z, quote=FALSE)
}




