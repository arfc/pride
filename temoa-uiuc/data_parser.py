import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os
import glob

plt.rcParams['figure.figsize'] = (12, 9)
plt.rcParams['figure.edgecolor'] = 'k'
plt.rcParams['figure.facecolor'] = 'w'
plt.rcParams['savefig.dpi'] = 300
plt.rcParams['savefig.bbox'] = 'tight'
# plt.rcParams['font.family'] = 'sans-serif'
# plt.rcParams['font.sans-serif'] = 'cm'
# plt.rcParams['text.usetex'] = True

# plt.rcParams['font.color'] = 'darkred'  # just to check the files
plt.rcParams['text.usetex'] = True
plt.rcParams['text.latex.preamble'] = [r'\usepackage[cm]{sfmath}']
plt.rcParams['font.family'] = 'serif'
plt.rcParams['font.sans-serif'] = 'cm'

variables = {'Generation': 'V_ActivityByPeriodAndProcess',
             'Capacity': 'V_Capacity',
             'Emissions': 'V_EmissionActivityByPeriodAndProcess'}
time_horizon = np.arange(2021, 2031, 1)

elc_techs = ['IMPELC', 'IMPSOL', 'IMPWIND', 'TURBINE']
ind_techs = ['NUCLEAR', 'ABBOTT']


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

    for line in datalines:
        if variable in line:
            datavariable.append(line)

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


def create_dataframe(lines, variable, sector='elc', years=time_horizon):
    """
    This function creates a pandas dataframe for
    a particular variable.

    Parameters:
    -----------
    lines : list
        This is a list of lines that have been grouped
        by variable of interest.
    years : list or array
        This is the list of years in the model time horizon.

    variable : string
        The variable of interest. Accepts "Emissions", "Generation",
        or "Capacity."

    sector :
    """
    if sector == 'elc':
        techs = elc_techs

    elif sector == 'ind':
        techs = ind_techs

    elif sector == 'all':
        techs = elc_techs + ind_techs

    technology_dict = {}

    var_of_interest = variables[variable]
    variable_data = data_by_variable(lines, var_of_interest)

    for tech in techs:
        col = create_column(variable_data, years, tech)
        technology_dict.update(col)

    dataframe = pd.DataFrame(technology_dict)
    dataframe.set_index('Year', inplace=True)
    if variable == 'Emissions':
        dataframe['total'] = dataframe.sum(axis=1)

    return dataframe


def bar_plot(dataframe, variable, scenario, sector):
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
        Accepts "Generation", "Capacity", "Emissions".
    scenario : string
        The name of model run you are conducting.
    """
    target_folder = "./figures/"
    if not os.path.isdir(target_folder):
        os.mkdir(target_folder)

    units = {'Generation': '[GWh]', 'Capacity': '[MW]'}

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
    ax.legend(loc=(1.02, 0.5), fancybox=True, shadow=True,
              fontsize=12, prop={'size': 21})
    plt.suptitle(f"Scenario {scenario.upper()}: Total Annual {variable} in {units[variable]}", fontsize=21)
    plt.title(f"Sector: {sector.upper()}", fontsize=16)
    plt.ylabel(f"{variable} {units[variable]}", fontsize=18)
    plt.xlabel("Year", fontsize=18)

    plt.savefig(f"{target_folder}{scenario}_{sector}_{variable.lower()}.png")
    plt.close()
    return


def emissions_plot(dataframe, variable, scenario, sector):
    """
    This function creates an emissions plot for
    a given dataframe and returns nothing.

    Parameters:
    -----------
    dataframe : Pandas Dataframe
        This is the dataframe to be plotted.
        Must have a column labeled "Year."
    variable : string
        The type of variable you are analyzing.
        Accepts "Generation", "Capacity", "Emissions".
    scenario : string
        The name of model run you are conducting.
    """
    target_folder = "./figures/"
    if not os.path.isdir(target_folder):
        os.mkdir(target_folder)

    units = {'Emissions': '[ktons CO2 equivalent]'}

    fig, ax = plt.subplots()

    ax.plot(dataframe.index,
            dataframe.total,
            lw=3, linestyle='--',
            marker='o',
            markersize=10,
            color='tab:purple',
            label='CO$_2$ Emissions')

    plt.suptitle(f"Scenario {scenario.upper()}: Total Annual {variable}",
                 fontsize=21)
    plt.title(f"Sector: {sector.upper()}", fontsize=16)
    plt.ylabel(f"{variable} {units[variable]}", fontsize=18)
    plt.xlabel("Year", fontsize=18)
    ax.legend(loc=(1.02, 0.5), fancybox=True,
              shadow=True, fontsize=12, prop={'size': 21})
    plt.grid()
    plt.yticks(fontsize=18)
    ax.set_xticks(dataframe.index)
    plt.xticks(fontsize=18)

    plt.savefig(f"{target_folder}{scenario}_{sector}_{variable.lower()}.png")
    plt.close()
    return


def get_output_files():
    """
    This function returns a list of paths to the Temoa output files.

    Returns:
    --------
    path_list : list of strings
        The list of paths to output files.
    """

    path = "./data_files/**/*.log"

    path_list = glob.glob(path, recursive=True)
    return path_list


def get_scenario_name(file):
    """
    This function takes in a file path and returns the
    scenario name for the model run.

    Parameters:
    -----------
    file : string
        This is the filename or file path for the model run.

    Returns:
    --------
    scenario_name : string
        The name of the scenario run
    """

    filename = file.split('/')
    fname_split = filename[-1].split('_')
    scenario_name = '_'.join(fname_split[:-1])

    return scenario_name


def parse_datalines(filepath):
    """
    This function opens a file and returns the
    contents in a line by line list.

    Parameters:
    -----------
    filepath : string
        The path to the file of interest.

    Returns:
    lines : list of strings
        The line by line contents of the file.
    """

    with open(filepath, "r") as file:
        lines = file.readlines()

    return lines


def make_plots(data_paths):
    """
    This function produces all plots and puts them in a folder
    called 'figure.'

    Parameters:
    -----------
    data_paths : list of strings
        This is the list of paths to input files that contain data
        from Temoa runs.
    """

    plots_dict = {'Emissions': emissions_plot,
                  'Generation': bar_plot,
                  'Capacity': bar_plot}

    # for each outputfile
    for file in data_paths:
        # get the name of the scenario run
        scenario = get_scenario_name(file)
        datalines = parse_datalines(file)
        # for each variable of interest
        for var in variables:
            # create dataframes
            df_elc = create_dataframe(datalines, var, sector='elc')
            df_ind = create_dataframe(datalines, var, sector='ind')
            df_all = create_dataframe(datalines, var, sector='all')
            plot = plots_dict[var]
            plot(dataframe=df_elc,
                 variable=var,
                 scenario=scenario,
                 sector='elc')
            plot(dataframe=df_ind,
                 variable=var,
                 scenario=scenario,
                 sector='ind')
            plot(dataframe=df_all,
                 variable=var,
                 scenario=scenario,
                 sector='all')

    return


if __name__ == "__main__":

    output = get_output_files()
    make_plots(output)
