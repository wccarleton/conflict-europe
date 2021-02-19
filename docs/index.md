# Description

This repository contains the files and data necessary to replicate the analyses described in the following paper:

[*A reassessment of the impact of temperature change on
European conflict during the second millennium CE using a bespoke
Bayesian time-series model
*](https://doi.org/10.1007/s10584-021-03022-2)

In this study, we set out to re-evaluate published results regarding the impact of long-term temperature change on conflict in Europe during the 2nd millennium CE. The previously published results were based on a statistical model that wasn't optimal given the data at hand, namely the historical record of European conflicts. So, we developed a new Bayesian time-series (state-space) model that better accounts for the nature and structure of the historical conflict record. Our findings indicate that there was no long-term relationship between changing temperatures and conflict levels.

# Replication
To replicate the analysis described in the paper, start an R session with the working directory set to `./Src` in this repository. Then, sun `source("start.R")`. Assuming you have the required libraries installed, the scripts will build the appropriate model and run the MCMC using Nimble. To produce plots, uncomment the plot commands in `./Src/NimblePoisTS_change.R` and/or explore the plotting scripts in the `./Src/Plotting/` folder.

# Contact

[ORCID](https://orcid.org/0000-0001-7463-8638) |
[Google Scholar](https://scholar.google.com/citations?hl=en&user=0ZG-6CsAAAAJ) |
[Website](https://wccarleton.me)

# License

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
