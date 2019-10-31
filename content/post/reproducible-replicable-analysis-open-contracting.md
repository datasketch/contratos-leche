---
title: 'Reproducible and replicable open contracting data analysis'
description: "Introducing open science and research methods in the analysis of open contracting data to fight corruption"
---

Working with public data may quickly become challenging when we try to reproduce or replicate results. As it happens, most of the time public procurement systems are constantly adapting and evolving. Those of us who constantly work with open data face many challenges, including:

- Data in closed or wrong formats
- Bad data quality
- Data availability not guaranteed
- Data is spread in multiple entities
- Data standards not implemented properly

This are big challenges and they are there all at the same time. Just this week [Colombia Compra Eficiente](https://www.colombiacompra.gov.co/) the entity in charge of publishing public procurement data in Colombia suddenly [took down 2 million public contracts](https://twitter.com/datasketch/status/1189196698943447040). After some public questioning they decided to remove the whole database and it is currently unavailable. They claim it is because they are making some adjustments to the system by adding more variables that resulted in some data integration issues. When this issue is resolved a new challenge arises for those organizations working with that data, that is the structure of the database will change and therefore we would need to adjust our analysis routines.

This is not the first time we face such incompatibilities, as open data systems adapt and evolve we need to keep our analysis neat and running, this is not an task. When we sat together with other Red Palta members we figured we had our data routines ready to go for the data of Colombia Compra Eficiente, as we previously analyzed 6 million public contracts. However, when we sat down to run our analysis with the updated data, we realized there were some changes in the database structure, so we went ahead and made some minor tweaks to our data processing scripts. The only reason it was not a big burden was because we started implementing practices of **Reproducible Research** in out data analysis workflows.


## The importante of reproducible and replicable analysis of open contracting data

When we talk about being able to re-do our data analysis we must ask ourselves if the data structure we are analyzing is the same, if not we will have to start from scratch or manipulate the data in a way that can be plugged into our pre-defined structures. This is one of the benefits of using Data Standards. From now on, we will assume that our data has the same structure, in this case if the analysis or code we are implementing is the same, we can say that we can **Reproduce** the analysis when we input the same data we used in the past, if the data contains new samples or even if it is all brand new data that keeps the same structure, when we want to do the same analysis we will day that we can **Replicate** the procedure.

This concepts arise originally in the contexts of science and specially in **open science**, but they can easily be used in the context of analyzing open contracting data.

We've seen recently some discussions around making data analysis reproducible vs replicable, a clear presentation of the difference can be found in [The Turing Way](https://the-turing-way.netlify.com/reproducibility/03/definitions.html).

![](ReproducibleMatrix.jpg)

That is:

- **Reproducible:** Same data - Same Analysis/Code.
- **Replicable:** Different data - Same Analysis/Code. 

One of the main objectives of [Red Palta](http://redpalta.org) is to come up with reproducible and replicable frameworks to ease the work of journalists working in corruption issues using open contracting data. For the members of the network this constitutes a great challenge to solve, as we face different scenarios that we have account for technically to be able to streamline data analysis and visualization for our investigations.

The challene is due to different contexts and information access levels in all participating countries. On one hand you have countries like Mexico with very good access to information laws, on the other hand you have countries like El Salvador with little public openness. In terms of information availability, in countries like Colombia you can analyze large data dumps of contracts, in others like Peru, the teams have to come up with ways to bypass the lack of open information systems to have access to data in bulk. Even in countries were OCDS data is available like Colombia and Mexico, in practice sometimes it is better to resort to tabular because it is more practical to work with. In countries were OCDS data is somewhat available, like Uruguay and Argentina, in practice it could not be used because it was not enough, as the data was either available at the Federal level only or at the Local level only. Differences in the granularity of the data was also something to take into account, as some countries have detailed tender data and even item information at the contract level, while others did not. 

Despite data discrepancies in journalistic investigations Open Contracting Data serves a great purpose at the exploration level to get different investigative leads, especially those pertaining to red flags in open contracting. It is with this approach that the network was able to search for and explore patterns in the data to offer an aggregated view in different editorial angles. 

## Scaling Open Contracting Data Investigations

Finding common grounds for the investigations and data exchange only solves part of the equation, in the quest to scale the fight for transparency and accountability we all need to push for ways to streamline the process transforming data into insights quickly enough for journalists to react. This is why, implementing reproducible and replicable frameworks in cruicial.

Here are some tips:

- **Use version controls systems:** set up repositories to track historic changes to the code being used for analysis.
- **Use literate programming when possible:** Use executable documentation on the scripts and reports, that is, scripts that not only generate charts and graphs but that are inherently accompanied by documentation.
- **Automate testing:** When doing reproducible analysis we not only need to ensure the data is the same, we also need to make sure the code is the same. The use versioned packages is desirable to replicate the exact computer environments to make sure the exact same code is running under the same conditions.
- **Publication:** Having a workflow that allows to easily re-run analysis and output intermediate reports is very valuable at the data exploration phase with the team of journalists or context experts. Once analysis are approved all we need to do is to run them with as much frequency as the data changes to be able to monitor possible research leads.

What we are doing at Red Palta:

We are using static sites generators for all our reports, this site was built with [hugo](https://gohugo.io). In the same repositories we keep the scripts to generate reproducible analysis (first version), and we are working on making the more coherent as we make more investigations. A lot of the code for the analysis and visualizations was done using the R language and reproducible reports using Rmd. Different software packages are being developed, tested and versioned, specially around data visualization and simplifying analysis of open contracting data.

Some others things we are tinkering with:

- Interconexión: A protocol for exchanging information in a decentralized way with different Civil Society and Journalism organizations in Latin America.
- A joint repository of multiples public databases in different Latin American countries curated and maintained by the members of the network.
- We are still working on finding ways to do version control not only for the code but also for the data itself. You know, public data may appear and dissappear for many reasons.






