run_model <- function(file_path) {
    logger::log_info("Reading data file")
    data <- data.table::fread(file_path)
    logger::log_info("Fitting model")
    res <- epikinetics::run_model(data = data, priors = epikinetics::epikinetics_priors())
    logger::log_info("Processing fits")
    fits <- process_fits(res, data, ~0 + infection_history)
    logger::log_info("Saving processed fits")
    write.csv(fits, "/epikinetics/results.csv")
}

lambdr::start_lambda()
