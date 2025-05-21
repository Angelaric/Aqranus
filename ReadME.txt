# Finding Mediaeval Aqranus

*ANALYSIS*

## Purpose

This repository stores the scripts modelling the possible locations of the medieval site of Aqranus via spatial buffers, isochrones, network- and least cost paths distance from the cities mentioned by al-Idrisi. The paper was presented at CAA 2025 in Athens and will be submitted to CHR 2025. 

The rationale for the spatial analysis is simple: many historically-attested places no longer have a physical referent in the modern landscape, yet we need them to make maps with and to use as jumping boards for archaological, historical, geopolitical and other analyses. Placenames may be mentioned in historical sources, travelogues or literature, but these verbal references are difficult to geocode due to both their removal from the present, the change in the historical landscape and their textual and spatial ambiguity. In this paper, we aim to triage multiple possible locations by testing current interpretations of the position of mediaeval Aqranus by operationalizing its locations on the basis of Al-Idrisi's accounts within the modern terrain of central Bulgaria.   


"Aqranus is a magnificent city located on a high mountain", states the Muslim geographer al-Idrisi (4, 4), who worked as the court cartographer for the king Roger II of Palermo and lived in Sicily during the 12th century. In his book, “A Diversion for the Man Longing to Travel to Far-Off Places”, al-Idrisi describes all the regions of the known world. When discussing the territory of modern-day Bulgaria, he mentions Aqranus. Other historical sources, including works by Niketas Choniates (Hist., 3, 3), George Pachymeres (Hist., 3, 26), Manuel Philes (Poem., 234-239), and the charter of Bulgarian Tsar Ivan Asen II (Chart. Ivan Asen II) mention the city of Kran. Modern-day historians connect the ancient Aqranus of al-Idrisi with the medieval Bulgarian city of Kran. Yet, nobody knows where exactly Kran is located.
Somewhere in the heart of medieval Bulgaria, Kran served as an administrative center and, for a brief period, even became the capital of a breakaway state. Most researchers place Kran in the Kazanlak Valley in Central Bulgaria, associating it with the fortress near the modern-day town of Kran, close to Kazanlak in Stara Zagora Province. Others propose that Kran could be identified with fortresses near the village of Tazha, located west of Kazanlak. Recently, two other suggestions have pinpointed the modern-day town of Kazanlak as well as a settlement south of the Kazanlak Valley. All these proposals are based on historical records, primarily the text of al-Idrisi, which states that Aqranus is six days' march from Istibuni (modern-day Ihtiman), 40 miles from Farui (modern-day Stara Zagora), and four days' march from Lufisa (modern-day Lovech). One mile according to al-Idrisi is approximately one and a half kilometers, and a day’s march is around 23–25 miles. Using those equations we can translate into modern distance units: 217.7 km from Istibuni, 62.2 km from Farui, and 144.9 km from Lufisa. 
To find the location of the city, we translate these measurements into GIS using three increasingly sophisticated methods and explore their intersections. First, we create buffers representing distances from the respective cities. Second, we create walking isochrones. Third, we explore the full length of these distances within a mediaeval road network. Finally we validate options with one additional line of evidence.
This project consists of the codes we used to reach our goal. 


## Authors
* Angel Bogdanov Grigorov, (https://orcid.org/0009-0007-4625-3555), The National Archaeological Institute with Museum at the Bulgarian Academy of Sciences (NAIM-BAS), angelbogdanovgrigorov@gmail.com
* Adela Sobotkova [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)]([(https://orcid.org/0000-0002-4541-3963)]), adela@cas.au.dk

## License
CC-BY-SA 4.0, see attached License.md

## DOI
[Here will be DOI or some other identifier once we have it]

### References
[Here will go related articles or other sources we will publish/create]

# How to use this repository

## Sources and prerequisites
[Describe the provenance of data used in the scripts contained and clarify how it is harvested and what other prerequisites are required to get the scripts working. In case of pure tool attribute any reused scripts to source, etc., license and specify any prerequisites or technical requirements.]

### Data
Anything else on data metadata and data used. Link to data repository or explanatory article. 

### Software
1. R, version 4.4.5+

Rough order of running the scripts:
Load > Buffers > isochrones > network > LCP
