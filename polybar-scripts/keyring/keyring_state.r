#!/usr/bin/env Rscript
library("keyring")

pf<-file.path(read.table("polybar-keyring.conf",sep="=")[1,2],"state.tmp")
sink(pf)

state=keyring_is_locked()
if (state == TRUE) {
cat("locked")
} else {
cat("unlocked")
}
