# SMU vs Seattle University
"""
A Business Stats class here at SMU was polled, and students were asked how much money (cash) they had in their pockets at that very moment.  The idea was to see if there was evidence that those in charge of the vending machines should include the expensive bill / coin accept or or if the machines should just have the credit card reader. Also, a professor from Seattle University polled her class last year with the same question.  Below are the results of the polls.  
"""


import numpy as np
import scipy.stats as stats
import matplotlib.pyplot as plt
import seaborn as sns
#%matplotlib inline

smu = [34, 1200, 23, 50, 60, 50, 0, 0, 30, 89, 0, 300, 400, 20, 10, 0]
sea = [20, 10, 5, 0, 30, 50, 0, 100, 110, 0, 40, 10, 3, 0]

diff_mean = np.mean(smu) - np.mean(sea)

# Permutation simulation 
nperm = 10000
perms = np.zeros(nperm + 1)

perm_result = []

for i in range(0, nperm):
    smu_sample = np.random.choice(smu, size = 10, replace = False)
    sea_sample = np.random.choice(sea, size = 10, replace = False)
    sample_diff = np.mean(smu_sample) - np.mean(sea_sample)
    perm_result.append(sample_diff)

print("Number of values greater than the observed mean difference: ", len([i for i in perm_result if i > diff_mean]))


pvalue =  sum(perm_result > diff_mean) / nperm
print("the pvalue from this permutation test is: ", pvalue)

# t test
t_test_results = stats.ttest_ind(smu, sea)
print(t_test_results)

"""
result from the t-test = Ttest_indResult(statistic=1.397643422206484, pvalue=0.17319645942304948)

Interpretation of these results:
* t-statistic is 1.387
* p-value is 0.173, which agains is above the standard threshold of both 0.05 and 0.01, we we will fail to reject the null hypotehsis and we can sat that there was not enough evidece to show a statistically significant difference between the SMU student dollar amound and seattle University students. 

"""
