testData = createData(sampleSize = 200, family = poisson(), 
                      randomEffectVariance = 1, numGroups = 5)
fittedModel <- glm(observedResponse ~ Environment1, 
                   family = "poisson", data = testData)
simulationOutput <- simulateResiduals(fittedModel = fittedModel)

######### main plotting function #############

# for all functions, quantreg = T will be more
# informative, but slower

plot(simulationOutput, quantreg = FALSE)

#############  Distribution  ######################

plotQQunif(simulationOutput = simulationOutput)

hist(simulationOutput )

#############  residual plots  ###############

# rank transformation, using a simulationOutput
plotResiduals(simulationOutput, rank = TRUE, quantreg = FALSE)

# residual vs predictors, using explicit values for pred, residual 
plotResiduals(pred = testData$Environment1, 
              residuals = simulationOutput$scaledResiduals, quantreg = FALSE)

# if pred is a factor, or asFactor = T, will produce a boxplot
plotResiduals(pred = testData$group, residuals = simulationOutput$scaledResiduals, 
              quantreg = FALSE, asFactor = TRUE)

# All these options can also be provided to the main plotting function
plot(simulationOutput, quantreg = FALSE, rank = FALSE)

# If you want to plot summaries per group, use
simulationOutput = recalculateResiduals(simulationOutput, group = testData$group)
plot(simulationOutput, asFactor = TRUE) # we see one residual point per RE


