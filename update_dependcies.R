require("desc")
require("renv")

x<-desc::description$new(cmd="!new")

walk(
  renv::dependencies()$Package,
  ~x$set_dep(.,type=desc::dep_types)
)

x$write("DESCRIPTION")
