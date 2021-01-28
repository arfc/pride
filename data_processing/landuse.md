# Land Use Requirements

* Solar: 8.1 acres/MW(e) capacity [1] -- to m^2 = x 4046.86 --> 32779.5 m^2/MW(e)
* Wind: 60 acres/MW(e) capacity [1] --> 242811 m^2/MW(e)
* Nuclear: 0.901 acres/MW(e) capacity (for large scale power plant of 1,000 MW) [1] --> 901 acres/3000 MW(th) = 0.3 acres/MW(th) --> 1214.06 m^2/MW(th)
* Natural gas: 0.343 acres/MW(e) capacity [1]
* Coal: 0.699 acres/MW(e) capacity [1]
* ABBOTT [2]:
	- 2 dual fuel (nat gas and fuel oil) ~ 2 x 150,000 lbs/h ~ 300,000
	- 2 Heat Recovery Steam Generators ~ 40,000 - 110,000 lbs/h
	- 3 coal-fired boilers [2] ~ 350,000 lbs/h
	- Efficiencies: coal ~ 39% - 47% and natural gas ~ 39% [3]

* CHWS: 15 Ton/m^2 if size > 20,000 Ton [4] ~ 0.066 m^2/Ton

* Nuclear(SMRs) [6]:

| Footprint [m^2] | Power [MWth] | Specific [m^2/MWth] |
|-----------------|--------------|---------------------|
|      200,000    |       310    |       645           |
|       10,000    |       450    |        22           |
|      220,000    |       920    |       239           |
| 14,000 (4units) |      1000    |         3.5         |
|       90,000    |       330    |       272           |
|       10,000    |        30    |       333           |
|        9,000    |       180    | 	      50           |
|      157,000    |       575    |       273           |
|                        mean    |      229.7          |


# Temoa's model

Nuclear:
* for SMR the data varies a lot for different designs, we will use the mean value as the reference --> 229.7 m^2/MW(th)

ABBOT:
* Tot = 300,000 + 350,000 + 110,000 = 760,000
* nat gas = 300,000 + 110,000 = 410,000 ~ /Tot = 0.54
* coal = 350,000 ~ /Tot = 0.46
* Specific land-use: 0.54 * 0.343 * 0.39 + 0.46 * 0.699 * 0.43 = 0.21 acres/MW(th) --> 849.8 m^2/MW(th)

CHWS:
* 0.066 m^2 x 37,500 Ton /26.25 MWe [5] = 95.23 m^2/MW(e)


# References

[1] Stevens, L., Anderson, B., Cowan, C., Colton, K., Johnson, D. The Footprint of Energy. June 2017. Technical Report. Strata. [link](https://www.strata.org/pdf/2017/footprints-full.pdf)

[2] F&S UIUC. ABBOT POWER PLANT. [link](https://fs.illinois.edu/docs/default-source/utilities-energy/abbottbrofinal.pdf?sfvrsn=90b1f9ea_4)
 
[3] HONORIO, L., BARTAIRE, J-G., BAUERSCHMIDT, R., OHMAN, T., TIHANYI, Z., ZEINHOFER, H., SCOWCROFT, J., DE JANEIRO, V., KRUGER, H., MEIER, H-J., OFFERMANN, D., LANGNICKEL, U. EFFICIENCY IN ELECTRICITY GENERATION. Technical Report. EURELECTRIC-VGB. July 2003. [link](http://payesh.saba.org.ir/saba_content/media/image/2016/07/8412_orig.pdf)

[4] George Berbari. Distric Cooling: Sustainable Design. Presentation. Distric Cooling. 2016. Dubai, UAE. [link](https://www.districtenergy.org/HigherLogic/System/DownloadDocumentFile.ashx?DocumentFileKey=eac74754-05c9-a7cc-cede-0261984fa8e7)

[5] From [cws_power](https://github.com/arfc/pride/blob/master/data_processing/cws_power.ipynb)

[6] IAEA. Advances in Small Modular Reactor Technology Developments. Technical Report. 2016. [link](https://aris.iaea.org/Publications/SMR-Book_2016.pdf)
