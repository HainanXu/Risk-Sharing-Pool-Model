# RSP-model

*Identified bad rated risks that needed to be put into the risk sharing pool based on the given data;*

The original dataset has 50000 observations and 22 variables.

Prepared the dataset by transforming target variables and filling up missing values (denoted by 1);

Built 2 GLM models: Pure premium model and Frequency/Severity Model and compared the two methods‘ results (denoted by 2); One advantage of Frequency and Severity model is that, it can provide more information about the client.

Ranked the predicted premium in descending order and selected top 5% bad rated risks.
