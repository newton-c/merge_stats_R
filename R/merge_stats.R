# merge function to generate stats about how good your merge was

merge_stats <- function(x, y, by = intersect(names(x), names(y)), by.x = FALSE,
    by.y = FALSE, all = FALSE, all.x = FALSE, all.y = FALSE, sort = TRUE,
    suffixes = c(".x", ".y"), no.dups = TRUE, incomparables = NULL,
    show.stats = TRUE, ...) {
        x.name <- deparse(substitute(x))
        y.name <- deparse(substitute(y))
        if ("merge" %in% colnames(x)) {
            return(cat(paste("\n", "Error: variable 'merge' already exists in",
                  x.name, "\n", sep = " ")))
        } else if ("merge" %in% colnames(y)) {
            return(cat(paste("\n", "Error: variable 'merge' already exists in",
                  y.name, "\n", sep = " ")))
        } else if ("merge.x" %in% colnames(x)) {
            return(cat(paste("\n",
                   "Error: variable 'merge.x' already exists in",
                  x.name, "\n", sep = " ")))
        } else if ("merge.x" %in% colnames(y)) {
            return(cat(paste("\n",
                   "Error: variable 'merge.x' already exists in", y.name,
                   "\n", sep = " ")))
        } else if ("merge.y" %in% colnames(x)) {
            return(cat(paste("\n",
                   "Error: variable 'merge.y' already exists in", x.name,
                   "\n", sep = " ")))
        } else if ("merge.y" %in% colnames(y)) {
            return(cat(paste("\n",
                   "Error: variable 'merge.y' already exists in", y.name,
                   "\n", sep = " ")))
        } else {
            x$merge <- 1
            y$merge <- 1
            m.df <- merge(x, y, by = intersect(names(x), names(y)), by.x = by.x,
                  by.y = by.y, all = FALSE, all.x = all.x, all.y = all.y, sort = TRUE,
                  suffixes = c(".x", ".y"), no.dups = TRUE,
                  incomparables = NULL, ...)
                m.df$merge <- NA
                for (i in 1:nrow(m.df)) {
                       if (m.df$merge.x[i] == 1 & is.na(m.df$merge.y[i])) {
                              m.df$merge[i] <- 1
                       } else if (is.na(m.df$merge.x[i]) & m.df$merge.y[i] == 1) {
                              m.df$merge[i] <- 2
                       } else if (m.df$merge.x[i] == 1 & m.df$merge.y[i] == 1) {
                              m.df$merge[i] <- 3
                       } else {
                              m.df$merge[i]  <- NA
                       }
                   }
               }
               if (show.stats == TRUE) {
                        missing.x <- sum(is.na(m.df$merge) | m.df$merge == 2)
                        sm1 <- paste("Missing from 1st dataframe:",
                                     missing.x, sep = " ")
                        merging.x <- sum(m.df$merge == 1 | m.df$merge == 3,
                                         na.rm = TRUE)
                        sm2 <- paste("Merged from 1st dataframe:",
                                     merging.x, sep = " ")
                        missing.y <- sum(is.na(m.df$merge) | m.df$merge == 1)
                        sm3 <- paste("Missing from 2nd dataframe:",
                                     missing.y, sep = " ")
                        merging.y <- sum(m.df$merge == 2 | m.df$merge == 3,
                                         na.rm = TRUE)
                        sm4 <- paste("Merged from 2nd dataframe:",
                                     merging.y, sep = " ")
                        missing.all <- sum(m.df$merge == 1 | m.df$merge == 2 |
                                           is.na(m.df$merge))
                        sm5 <- paste("Total missing:",
                                     missing.all, sep = " ")
                        merging.all <- sum(m.df$merge == 3, na.rm = TRUE)
                        sm6 <- paste("Total merged:",
                                     merging.all, sep = " ")
                        cat(paste("Merging stats:", sm1, sm2, sm3, sm4, sm5, sm6,
                                  "", sep = "\n"))
           }
       cat(paste("",
                 "df$merge variable meaning:",
                 "1 = data from 1st dataframe merged, 2nd dataframe missing",
                 "2 = data from 1st dataframe missing, 2nd dataframe merged",
                 "3 = perfect merge",
                 "", sep = "\n"))
       m.df$merge.x <- NULL
       m.df$merge.y <- NULL
       return(m.df)
}
