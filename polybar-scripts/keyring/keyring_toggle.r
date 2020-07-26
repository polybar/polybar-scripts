#!/usr/bin/env Rscript

library("keyring")

pf<-file.path(read.table("polybar-keyring.conf",sep="=")[1,2],"state.tmp")

state <- paste(readLines(pf), collapse=" ")
if (state == "locked") {
keyring_unlock()
} else {
keyring_lock()
}
sink(pf)
cat(state)