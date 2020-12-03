# (P)lan for (R)ap(I)d (DE)carbonization (PRIDE)
This repository contains analysis tools, models, and publications associated with planning for rapid decarbonization.

## Publication: 2020-fairhurst-hydrogen-production
This repository holds:

- data of the fuel consumed by the MTD and UI fleet.
- analysis of the hydrogen required by those fleet to become carbon free.
- information of different methods to produce hydrogen.

## Publication: 2020-dotson-optimal-sizing
This repository holds the data analysis, figures, that will lead to quantitative recommendations for the optimal reactor size.

Multiple scenarios will be addressed:

1. The reactor itself is free (significant reduction in capital cost).
2. The reactor still has a price tag and higher capital cost.
3. Increasing penetration of variable renewable energy sources.
4. Add grid flexibility in the form of H2 and thermal storage.

## Instructions to Run TEMOA
TEMOA is an open source modeling tool available on [GitHub](https://github.com/TemoaProject/temoa). Follow the installation instructions [here](https://temoacloud.com/download/).

After creating a database in sql, navigate to the directory with your database:

``sqlite3 [filename].sqlite < [filename].sql``

if you don't have sqlite installed, run:

``sudo apt-get install sqlite`` or ``sudo apt-get install sqlite3``

TEMOA models can be run from the command line, current iterations use the online model platform at ``model.temoacloud.com``.

## Instructions to Run TEMOA scenarios
To run a single TEMOA scenario:
```bash
cd temoa-uiuc
source activate temoa-py3
# Example scenario, works if you have a research folder where temoa lives.
sqlite3 data_files/bau_uiuc.sqlite < data_files/bau_uiuc.sql
yes | python ~/research/temoa/temoa_model/ --config=data_files/run_bau.txt
```
The data processing must be done separately. Figures can be produced using 
tools in ``data_parser.py``. An example of how this is done can be found in 
``mga_analysis.ipynb``.

To run all scenarios (except for MGA, which must be run individually):

``snakemake`` must be installed.

```bash
cd temoa-uiuc
source activate temoa-py3
pip install snakemake
snakemake --cores=4
# if the build fails due to file system latency, try
# snakemake --cores=4 --latency-wait=10
```
This automatically generates figures in the ``/figures/`` folder.

## Instructions to Run the Jupyter Notebooks

Generating typical time histories was done by using ``RAVEN`` an open source tool from INL. This repository should be in a folder adjacent to ``raven``. See directory map below for an example.

To install ``RAVEN`` follow the [instructions](https://github.com/idaholab/raven/wiki) from INL.

## Instructions to Obtain the Data

Some of the data has not yet been cleared for publication so a shared link cannot yet be provided.
Shared links for data that is already publicly available have been provided below.

In order to execute the jupyter notebooks the data files should be downloaded to your computer in a folder called
``data`` such that your directories look like:

``home``<br />
|<br />
|--``2020-dotson-optimal-sizing``<br />
|<br />
|--``raven``<br />
|<br />
|--``data``<br />

#### Data:

* [Champaign County (Willard Airport)](https://uofi.box.com/s/gy6nn3vqdbdxnxv073oqyeqpmoeeowkm)
* [Logan County (Lincoln Airport)](https://uofi.box.com/s/3b4498ua7fziof4ex3fu75zfcvio0h1l)
* [UIUC Solar Farm](https://uofi.box.com/s/0tohoujy4zhx7loaxt5m5w5qcocvxmp7)
* [Solar Irradiance (At UIUC Solar Farm)](https://uofi.box.com/s/ee8zq23cfotzpfw3d0txjuazq7raotpw)
* UIUC Steam Demand : Not cleared for public access
* UIUC Electricity Demand : Not cleared for public access
