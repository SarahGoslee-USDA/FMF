### CROP.DAT

# row from the body of a CROP.DAT file to pull formatting from
# could read it straight from a sample file, or type in the details from the documentation
# currently just pulls precision (number of decimal places)
samplerow <- "  154 WWEA   18.00    0.02   15.00    3.00    2.50    0.65    5.01   50.95    0.10    0.10    4.00  0.0083    0.85    5.00    0.60    1.50  660.45  0.0151  0.0024  0.0111    0.01    0.60    0.69   20.00    5.00    0.10  0.0300  0.0200  0.0120  0.0020  0.0015  0.0013  0.0230  0.0230  0.0230   3.390   3.390   3.390      6.    5.01   15.10    8.00    0.50    4.75    0.90    0.50  100.00    4.20   50.95    0.07    6.00    0.06    0.15    0.00    0.00    0.00    0.30    1.00   75.00   50.00    0.00    0.00    0.00  0.0015    0.00    0.00    0.00    0.00    0.00       0   35.WESTERN WHEAT GR"

samplefmt <- make.fmt(read.row(thisrow=samplerow, c(1, 4, 1, 4, rep(8, 70), NA)))
# some are not actually numeric despite appearances
samplefmt[c(11, 12, 44, 45, 52, 53)] <- "c"

# this creates a file description for the crop file
crop.desc <- make.desc(
  make.section(c(1, 4, 1, 4, rep(8, 70)), rfmt=c(rep("c", 4), rep("i", 70)), rdoc="header1: column numbers"), 
  make.section(c(1, 4, 1, 4, rep(8, 70)), rjust="r", rdoc="header2: column names"), 
  make.section(c(1, 4, 1, 4, rep(8, 70), NA), rfmt=samplefmt, rjust="r", rdoc="body: crop parameters", times=NA),
  doc = "APEX CROP.DAT with grazing 2016-05-11",
  terminal = "\n"
) 

rm(samplerow, samplefmt)

