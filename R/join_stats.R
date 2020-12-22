
join_inputs <- c("inner", "right", "left", "full", "semi", "anti")

join_stats <- function(x, y, by = NULL, copy = FALSE,
    suffix = c(".x", ".y"), join = NULL, show_stats = TRUE, ...) {
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
        if (!(join %in% join_inputs)) {
            return(cat(paste("\n",
                             "Error: ", "'", join, "' ",
                             "not a valid input for 'join'.",
                             "\n",
                             "Input options are: ",
                             "'inner', 'right', 'left', 'full', 'semi', or ",
                             "'anti'.", sep = "")))
        } else if (join == "inner") {
            m_df <- dplyr::inner_join(x, y, by = by, copy = copy,
                               suffix = c(".x", ".y"), ...)
        } else if (join == "left") {
            m_df <- dplyr::left_join(x, y, by = by, copy = copy,
                              suffix = c(".x", ".y"), ...)
        } else if (join == "right") {
            m_df <- dplyr::right_join(x, y, by = by, copy = copy,
                               suffix = c(".x", ".y"), ...)
        } else if (join == "full") {
            m_df <- dplyr::full_join(x, y, by = by, copy = copy,
                              suffix = c(".x", ".y"), ...)
        } else if (join == "semi") {
            m_df <- dplyr::semi_join(x, y, by = by, copy = copy, ...)
        } else if (join == "anti") {
            m_df <- dplyr::anti_join(x, y, by = by, copy = copy, ...)
        } else {
            return(cat(paste("\n",
                             "Error: ", "'", join, "' ",
                             "not a valid input for 'join'.",
                             "\n",
                             "Input options are: ",
                             "'inner', 'right', 'left', 'full', 'semi', or ",
                             "'anti'.", sep = "")))
        }
        m_df$merge <- NA
        for (i in 1:nrow(m_df)) {
               if (m_df$merge.x[i] == 1 & is.na(m_df$merge.y[i])) {
                      m_df$merge[i] <- 1
               } else if (is.na(m_df$merge.x[i]) & m_df$merge.y[i] == 1) {
                      m_df$merge[i] <- 2
               } else if (m_df$merge.x[i] == 1 & m_df$merge.y[i] == 1) {
                      m_df$merge[i] <- 3
               } else {
                      m_df$merge[i]  <- NA
               }
           }
           if (show_stats == TRUE) {
                    missing.x <- sum(is.na(m_df$merge) | m_df$merge == 2)
                    sm1 <- paste("Missing from 1st dataframe:",
                                 missing.x, sep = " ")
                    merging.x <- sum(m_df$merge == 1 | m_df$merge == 3,
                                     na.rm = TRUE)
                    sm2 <- paste("Merged from 1st dataframe:",
                                 merging.x, sep = " ")
                    missing.y <- sum(is.na(m_df$merge) | m_df$merge == 1)
                    sm3 <- paste("Missing from 2nd dataframe:",
                                 missing.y, sep = " ")
                    merging.y <- sum(m_df$merge == 2 | m_df$merge == 3,
                                     na.rm = TRUE)
                    sm4 <- paste("Merged from 2nd dataframe:",
                                 merging.y, sep = " ")
                    missing.all <- sum(m_df$merge == 1 | m_df$merge == 2 |
                                       is.na(m_df$merge))
                    sm5 <- paste("Total missing:",
                                 missing.all, sep = " ")
                    merging.all <- sum(m_df$merge == 3, na.rm = TRUE)
                    sm6 <- paste("Total merged:",
                                 merging.all, sep = " ")
                    total.obvs <- nrow(m_df)
                    sm7 <- paste("Total observations:",
                                 total.obvs, sep = " ")
                    cat(paste("Merging stats:", sm1, sm2, sm3, sm4, sm5, sm6,
                              sm7,
                              "", sep = "\n"))
       }
   cat(paste("",
             "df$merge variable meaning:",
             "1 = data from 1st dataframe merged, 2nd dataframe missing",
             "2 = data from 1st dataframe missing, 2nd dataframe merged",
             "3 = perfect merge",
             "", sep = "\n"))
   m_df$merge.x <- NULL
   m_df$merge.y <- NULL
   return(m_df)
    }
}
