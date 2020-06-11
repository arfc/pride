import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
# import re

plt.rcParams['figure.figsize'] = (12, 9)
plt.rcParams['figure.edgecolor'] = 'k'
plt.rcParams['figure.facecolor'] = 'w'
plt.rcParams['savefig.dpi'] = 200
plt.rcParams['savefig.bbox'] = 'tight'

path = "./data_files/03_uiuc_test_run_model/"

variables = {'Generation': 'V_ActivityByPeriodAndProcess',
             'Capacity': 'V_Capacity',
             'Emissions': 'V_EmissionActivityByPeriodAndProcess'}
years = np.arange(2021, 2031, 1)

elc_techs = ['IMPELC', 'IMPSOL', 'IMPWIND', 'TURBINE']
ind_techs = ['NUCLEAR', 'ABBOTT']

with open(path+"test_run_OutputLog.log", "r") as file:
    lines = file.readlines()


def data_by_year(datalines, year):
    """
    This function takes in a list of datalines and returns
    a new list of datalines for a specified year.

    Parameters:
    -----------
    datalines : list
        This is a list of datalines output by Temoa.
    year : integer
        This is the year of interest.

    Returns:
    --------
    datayear : list
        This is a list of datalines that only contains
        data for a particular year.
    """
    string = f"[{year},"
    datayear = []

    for line in datalines:
        if string in line:
            datayear.append(line)
            # print(line)

    return datayear


def data_by_variable(datalines, variable):
    """
    This function takes in a list of datalines and returns
    a new list of datalines for a specified variable.

    Parameters:
    -----------
    datalines : list
        This is a list of datalines output by Temoa.
    variable : string
        This is the variable of interest. Currently only
        interested in V_ActivityByPeriodAndProcess,
        V_Capacity, and V_EmissionsByPeriodAndProcess

    Returns:
    --------
    datavariable : list
        This is a list of datalines that only contains
        data for a particular variable.
    """
    datavariable = []
    print(variable)

    for line in datalines:
        if variable in line:
            datavariable.append(line)
            # print(line)

    return datavariable


def data_by_tech(datalines, tech):
    """
    This function takes in a list of datalines and returns
    a new list of datalines for a specified tech.

    Parameters:
    -----------
    datalines : list
        This is a list of datalines output by Temoa.
    tech : string
        This is the tech of interest. Currently only
        interested in V_ActivityByPeriodAndProcess,
        V_Capacity, and V_EmissionsByPeriodAndProcess

    Returns:
    --------
    datatech : list
        This is a list of datalines that only contains
        data for a particular tech.
    """
    datatech = []

    for line in datalines:
        if tech in line:
            datatech.append(line)
            # print(line)

    return datatech


def get_total(lines):
    """
    This function takes in a list of lines and returns
    a single float value that is the total of a particular
    variable for a given year and tech.

    Parameters:
    -----------
    lines : list
        This is a list of datalines that we want to total.

    Returns:
    --------
    total : float
        This is the sum total from the data lines.
    """
    total = 0.0
    for line in lines:
        data_sep = line.split()
        # print(data_sep)
        total += float(data_sep[0])

    return total


def create_column(lines, years, tech):
    """
    This function creates a dataframe column for a
    particular technology and variable.

    Parameters:
    -----------
    lines : list
        This is a list of lines that have been grouped
        by variable of interest.
    years : list or array
        This is the list of years in the model time horizon.
    tech : string
        This is the technology of interest. Currently only
        accepts: "NUCLEAR", "ABBOTT", "TURBINE", "IMPELC",
        "IMPWIND", "IMPSOL"

    Returns:
    --------
    column : dictionary
        This is the column for a particular technology.
        The technology is the key and the value is a list
        of floats that represent annual totals.
    """
    column = {"Year": years, tech: []}
    tech_data = data_by_tech(lines, tech)

    for year in years:
        year_data = data_by_year(tech_data, year)
        year_total = get_total(year_data)
        column[tech].append(year_total)
    return column


def create_dataframe(lines, years, variable, sector='elc'):
    """
    This function creates a pandas dataframe for
    a particular variable.
    """
    if sector == 'elc':
        techs = elc_techs

    elif sector == 'ind':
        techs = ind_techs

    technology_dict = {}

    variable_data = data_by_variable(lines, variable)

    for tech in techs:
        col = create_column(variable_data, years, tech)
        technology_dict.update(col)

    dataframe = pd.DataFrame(technology_dict)
    dataframe.set_index('Year', inplace=True)

    return dataframe


def bar_plot(dataframe, variable, scenario):
    """
    This function creates a bar chart for
    a given dataframe and returns nothing.

    Parameters:
    -----------
    dataframe : Pandas Dataframe
        This is the dataframe to be plotted.
        Must have a column labeled "Year."
    variable : string
        The type of variable you are analyzing.
    scenario : string
        The name of model run you are conducting.
    """
    units = {'Generation': '[GWh]', 'Capacity': '[MW]', 'Emissions': '[ktons CO2]'}

    years = list(dataframe.index)
    idx = np.asarray([i for i in range(len(years))])
    ax = dataframe.loc[1:, ].plot.bar(stacked=True)
    bars = ax.patches
    hatches = ''.join(h*len(dataframe) for h in 'x/O.')
    for bar, hatch in zip(bars, hatches):
        bar.set_hatch(hatch)

    ax.set_xticks(idx)
    ax.set_xticklabels(years, rotation=0, fontsize=18)
    plt.yticks(fontsize=18)
    ax.legend(loc=(1.02, 0.5), fancybox=True, shadow=True, fontsize=12, prop={'size': 21})
    plt.title(f"Total Annual {variable} in {units[variable]}", fontsize=21)
    plt.ylabel(f"{variable} {units[variable]}", fontsize=18)
    plt.xlabel("Year", fontsize=18)
    # plt.show()
    plt.savefig(f"{scenario}-{variable.lower()}.png")

    return


if __name__ == "__main__":

    df = create_dataframe(lines, years, variables['Generation'])
    print(df)
    bar_plot(df, 'Generation', 'test')
