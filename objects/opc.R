### *.OPC

# this creates a file description for the operations file
opc.desc <- make.desc(
  make.section(20, rdoc="header1: description"),  
  make.section(rep(4, 7), rfmt=rep("i", 7), rdoc="header2: auto variables"), 
  make.section(c(rep(3, 3), rep(5, 4), 4, rep(8, 8)), 
    rfmt = c(rep("i", 8), 0, 2, 2, 2, 1, 2, 2, 2), rdoc="body: operations parameters", times=NA),
  doc = "APEX FILE.OPS 2016-05-11", terminal = "\n"
) 

