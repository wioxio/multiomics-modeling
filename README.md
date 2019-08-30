# multiomics-modeling


***ridge_pval.r***

Calls TestRidge and test lambda values given alpha=0. A lambda value is the only parameter for this script.

ex) R CMD BATCH --no-restore '--args 1' ./ridge_pval.r	


***immune_pca.r***

Takes the top PC loadings (feature selection) from the first PC and runs TestGLM_immune. TestGLM_immune calls wrapTest1layer with a given set of alpha and lambda. The final return is the same as TestGLM. 53 lambda values used in the paper were tested and 25, 50, 100, and 200 top PC loading features were tested. The first input of immune_pca.r is 'lambda' and the second input is 'number of features'.

ex) R CMD BATCH --no-restore '--args 1 25' ./immune_pca.r	


***correlation_analysis.r***

Performs correlation analysis between Metabolomics and PlasmaSomalogic features and plot the results with weighted edges. 


***ablation_analysis.r***

Performs ablation analysis for all the combination of data sets.


***traintest.r***

Only function TestRidge and TestGLM_immune are listed. To run, it should be merged to the original traintest.r
