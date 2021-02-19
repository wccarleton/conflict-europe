# Project
## Overview
This repo contains the data and code used for the study presented in the following paper:

[*A reassessment of the impact of temperature change on
European conflict during the second millennium CE using a bespoke
Bayesian time-series model
*](https://doi.org/10.1007/s10584-021-03022-2)

### Repository DOI
[![DOI](https://zenodo.org/badge/195126666.svg)](https://zenodo.org/badge/latestdoi/195126666)

## Abstract
Recently, there has been a lot of discussion about the impact of climate change on human conflict. Here, we report a study in which we revisited the findings of a paper that has been cited many times in the discussion. The paper in question focused on the association between temperature and conflict in Europe between 1000 and 1980 CE and suggested that colder temperatures led to more conflict. However, there are reasons to skeptical of this finding. Most importantly, the analytical technique used by the paper’s authors was not suitable for the conflict dataset because the dataset is count-based and contains autocorrelation. With this in mind, we developed a Bayesian time-series model that is capable of dealing with these features, and then we reanalysed the dataset in conjunction with several temperature reconstructions. The results we obtained were unambiguous. None of the models that included temperature as a covariate outperformed a null hypothesis in which conflict levels at any given time were determined only by previous levels. Thus, we found no evidence that colder temperatures led to more conflict in Europe during the second millennium CE. When this finding is placed alongside the results of other studies that have examined temperature and conflict over the long term, it is clear that the impact of temperature on conflict is context dependent. Identifying the factor(s) that mediate the relationship between temperature and conflict should now be a priority.

## Software
The R scripts contained in this repository are intended for replication efforts and to improve the transparency of research. They are, of course, provided without warranty or technical support. That said, questions about the code can be directed to me, Chris Carleton, at ccarleton@protonmail.com.

### R
This analysis described in the associated manuscript was performed in R. Thus, you may need to download the latest version of [R](https://www.r-project.org/) in order to make use of the scripts described below.

### Nimble
This project made use of a Bayesian Analysis package called [Nimble](https://r-nimble.org/). See the Nimble website for documentation and a tutorial. Then, refer to the R scripts in this repo.

## Replication
To replicate the analysis described in the paper, start an R session with the working directory set to `./Src` in this repository. Then, sun `source("start.R")`. Assuming you have the required libraries installed, the scripts will build the appropriate model and run the MCMC using Nimble. To produce plots, uncomment the plot commands in `./Src/NimblePoisTS_change.R` and/or explore the plotting scripts in the `./Src/Plotting/` folder.

## Contact

[ORCID](https://orcid.org/0000-0001-7463-8638) |
[Google Scholar](https://scholar.google.com/citations?hl=en&user=0ZG-6CsAAAAJ) |
[Website](https://wccarleton.me)

## License

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
