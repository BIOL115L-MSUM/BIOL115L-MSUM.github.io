
# load packages -----------------------------------------------------------

library(readxl)                # load readxl, for reading Excel files
library(tidyverse)             # load tidyverse, for working with datasets


# read data ---------------------------------------------------------------

finches <- read_excel("finches_data.xlsx")  # read the data

# two ways to look at the data
finches
glimpse(finches)


# histograms --------------------------------------------------------------

# histogram of beak length
ggplot(
  data = finches,                  # use the finches dataset
  mapping = aes(x = beak_length)   # put beak length on the x axis
) +
  geom_histogram(bins = 12)        # use 12 bins (default is 30)

# grouped by survival
ggplot(
  data = finches, 
  mapping = aes(x = beak_length, fill = outcome)
) +
  geom_histogram(bins = 14) +
  facet_wrap(~ outcome, ncol = 1)

# with labels
ggplot(
  data = finches, 
  mapping = aes(x = beak_length, fill = outcome)
) +
  geom_histogram(bins = 14) +
  facet_wrap(~ outcome, ncol = 1) +
  labs(
    x = "Beak Length (mm)",
    y = "Number of Birds",
    title = "Beak length vs. drought survival"
  )

# save the figure
ggsave("Beak Length Histogram.png",   # name your file, use .png
       width = 6.5, height = 6.5,     # height and width of output
       units = "in")                  # what units are height & width? in=inches


# summarize ---------------------------------------------------------------

# quick summary
summary(finches)

# mean and standard deviation of beak length
summary <- finches %>% 
  summarize(mean = mean(beak_length),
            sd = sd(beak_length),
            n = n()) %>% 
  mutate(sem = sd / sqrt(n),
         upper = mean + 2 * sem,
         lower = mean - 2 * sem)
summary

# means and sds for each group
grouped_summary <- finches %>% 
  group_by(outcome) %>% 
  summarize(mean = mean(beak_length),
            sd = sd(beak_length),
            n = n()) %>% 
  mutate(sem = sd / sqrt(n),
         upper = mean + 2 * sem,
         lower = mean - 2 * sem)
grouped_summary


# bar charts --------------------------------------------------------------

ggplot(
  data = grouped_summary, 
  mapping = aes(x = outcome,          # put surival outcome on the x axis
                y = mean,             # put mean on the y axis
                fill = outcome)       # use different colors for outcome
) +
  geom_col() +
  geom_errorbar(
    mapping = aes(ymin = lower,       # "lower" is the column name
                  ymax = upper),      # "upper" is the column name
    width = .3                        # controls the width of the
  ) +                                 #   horizontal part of error bars
  labs(
    x = "Survival Outcome",           # x-axis label
    y = "Beak Length (mm)",           # y-axis label
    title = "Mean beak lengths vs. survival"
  )

# save the figure
ggsave("Beak Length Bar Chart.png", 
       width = 3, height = 3, units = "in")


# t-test ------------------------------------------------------------------

# get a vector of beak lengths for birds that died
beak_length_died <-
  finches %>%                     # start with finches dataset
  filter(outcome == "died") %>%   # only include rows w/ outcome=died
  pull(beak_length)               # extract the beak_length column

# print the new object in the console... it is a vector
beak_length_died

# get a vector of beak lengths for birds that survived
beak_length_survived <-
  finches %>% 
  filter(outcome == "survived") %>% 
  pull(beak_length)
beak_length_survived

# perform a two-sample t-test assuming unequal variances
t.test(beak_length_died, beak_length_survived)
