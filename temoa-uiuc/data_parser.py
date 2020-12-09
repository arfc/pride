import numpy as np
import pandas as pd
import re
import matplotlib.pyplot as plt
import os
import glob

plt.rcParams['figure.figsize'] = (12, 9)
plt.rcParams['figure.edgecolor'] = 'k'
plt.rcParams['figure.facecolor'] = 'w'
plt.rcParams['savefig.dpi'] = 400
plt.rcParams['savefig.bbox'] = 'tight'
plt.rcParams['text.usetex'] = True
plt.rcParams['font.family'] = "serif"


variables = {'generation': 'V_FlowOut',
             'capacity': 'V_Capacity',
             'emissions': 'V_EmissionActivityByPeriodAndProcess'}


# Pre-update... looks like V_ActivityByPeriodAndProcess is deprecated.
# variables = {'generation': 'V_ActivityByPeriodAndProcess',
#              'capacity': 'V_Capacity',
#              'emissions': 'V_EmissionActivityByPeriodAndProcess'}
time_horizon = np.arange(2021, 2031, 1)

elc_techs = ['IMPELC', 'IMPSOL', 'IMPWIND', 'TURBINE', 'NTURBINE']
ind_techs = ['NUCLEAR', 'ABBOTT', 'GSLVCL', 'DSLVCL', 'E85VCL']
emissions = ['co2eq', 'ewaste', 'spent-fuel']


def data_by_year(datalines, year):
    """
    This function takes in a list of datalines and returns
    a new list of datalines for a specified year.

    NOTE: This function picks out the year based on a
    specific index of the year in a string. If Temoa changes
    in the future (adds more columns, etc) this function
    will probably break.

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
    datayear = []

    for line in datalines:
        line_year = re.findall(r"[-+]?\d*\.\d+|\d+", line)[1]

        if int(line_year) == year:
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
        # print(line)
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


def create_dataframe(
        lines,
        variable,
        sector='elc',
        emission=None,
        years=time_horizon):
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
    if variable.lower() == 'emissions':
        assert(emission is not None)

    if sector == 'elc':
        techs = elc_techs

    elif sector == 'ind':
        techs = ind_techs

    elif sector == 'all':
        techs = elc_techs + ind_techs

    technology_dict = {}

    if variable == 'emissions':
        lines = data_by_tech(lines, emission)

    var_of_interest = variables[variable.lower()]
    variable_data = data_by_variable(lines, var_of_interest)

    for tech in techs:
        col = create_column(variable_data, years, tech)
        technology_dict.update(col)

    dataframe = pd.DataFrame(technology_dict)
    dataframe.set_index('Year', inplace=True)
    if variable == 'emissions':
        dataframe['total'] = dataframe.sum(axis=1)
        if emission is not 'co2eq':
            dataframe['cumulative'] = dataframe['total'].cumsum()

    return dataframe


def bar_plot(dataframe, variable, scenario, sector, emission=None, save=True):
    """
    This function creates a bar chart for
    a given dataframe and returns nothing.

    TODO: Currently, this function will plot all technologies
    in a given system. Even if those technologies do not produce
    anything (i.e. zero valued). This is evident in the spent-fuel
    and ewaste plots (which are not stacked) because space is made
    on the plot for technologies that do not produce ewaste or
    spent fuel. FIX THIS.

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
    sector : string
        The sector you are plotting.
        "ind" = Industrial/steam
        "elc" = Electricity
        "all"
    save : boolean
        If save is true, the plot will be saved rather than
        shown. Default is true.
    """
    target_folder = "./figures/"
    if not os.path.isdir(target_folder):
        os.mkdir(target_folder)

    units = {'generation': '[GWh]',
             'capacity': '[MW]',
             'emissions': '[kg]'}

    hatches = ''.join(h * len(dataframe) for h in 'x/O.*')
    years = list(dataframe.index)
    idx = np.asarray([i for i in range(len(years))])
    if (variable.lower() == 'emissions') and (emission != 'co2eq'):
        ax = dataframe.loc[1:, dataframe.columns != 'total'].plot.bar()
        plt.suptitle(
            (f"{scenario.upper()}: Total Annual {emission.upper()} in"
             f" {units[variable.lower()]}"),
            fontsize=36)
        plt.ylabel(f"{emission} {units[variable.lower()]}", fontsize=24)
        bars = ax.patches
        for bar, hatch in zip(bars, hatches):
            bar.set_hatch(hatch)
    else:
        ax = dataframe.loc[1:, dataframe.columns !=
                           'total'].plot.bar(stacked=True)
        bars = ax.patches
        plt.suptitle(
            (f"{scenario.upper()}: Total Annual {variable} in"
             f"{units[variable.lower()]}"),
            fontsize=36)
        plt.ylabel(f"{variable} {units[variable.lower()]}", fontsize=24)
        for bar, hatch in zip(bars, hatches):
            bar.set_hatch(hatch)

    ax.set_xticks(idx)
    if len(dataframe) > 11:
        ax.set_xticklabels(years, rotation=60, fontsize=24)
    else:
        ax.set_xticklabels(years, rotation=0, fontsize=24)

    plt.yticks(fontsize=24)
    ax.legend(loc=(1.02, 0.5), fancybox=True, shadow=True,
              fontsize=12, prop={'size': 24})
    plt.title(f"Sector: {sector.upper()}", fontsize=24)
    plt.xlabel("Year", fontsize=24)

    if save is True:
        if emission is not None:
            plt.savefig(
                (f"{target_folder}{scenario}_{sector}_{variable.lower()}_"
                 f"{emission}.png"))
            plt.close()
        else:
            plt.savefig(
                f"{target_folder}{scenario}_{sector}_{variable.lower()}.png")
            plt.close()
    else:
        plt.show()
    return


def get_icap_goals(year_start=2021, year_end=2030):
    """
    This function returns an interpolated list of annual emissions goals
    based on the Illinois Climate Action Plan (iCAP). This list is
    linearly interpolated. Returns a pandas dataframe with the desired
    number of years. Where "year" is a column and not an index.

    year_start : integer
        This is the first year in the interpolated dataframe. The default
        is 2021. The first possible year is 2015 (when iCAP was published).

    year_end : integer
        This is the last year in the interpolated dataframe. The default
        is 2030. The last possible year is 2050 (when the goal is zero
        emissions).
    """

    data = np.empty(36)
    data[:] = np.NaN
    data[0] = 459.875
    data[5] = 402.562
    data[10] = 344.906
    data[-1] = 0.0

    icap_df = pd.DataFrame({'year': np.arange(2015, 2051, 1), 'goal': data})
    icap_df['goal'] = icap_df['goal'].interpolate(method='linear')

    mask = (icap_df['year'] <= 2030) & (icap_df['year'] >= 2021)

    return icap_df[mask]


def emissions_plot(dataframe, variable, scenario, sector, save=True):
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
    sector : string
        The sector you are plotting.
        "ind" = Industrial/steam
        "elc" = Electricity
        "all"
    save : boolean
        If save is true, the plot will be saved rather than
        shown. Default is true.
    """
    target_folder = "./figures/"
    if not os.path.isdir(target_folder):
        os.mkdir(target_folder)

    units = {'emissions': '[Mtons CO2 equivalent]'}

    goals = get_icap_goals()

    fig, ax = plt.subplots()

    ax.scatter(goals['year'],
               goals['goal'],
               label='iCAP Target',
               marker='*',
               s=500, color='tab:red')

    ax.plot(dataframe.index,
            dataframe.total,
            lw=3, linestyle='--',
            marker='o',
            markersize=10,
            color='tab:purple',
            label='CO$_2$ Emissions')

    plt.suptitle(f"{scenario.upper()}: Total Annual {variable}",
                 fontsize=36)
    plt.title(f"Sector: {sector.upper()}", fontsize=24)
    plt.ylabel(f"{variable} {units[variable.lower()]}", fontsize=24)
    plt.xlabel("Year", fontsize=24)
    ax.legend(loc=(1.02, 0.5), fancybox=True,
              shadow=True, fontsize=12, prop={'size': 24})
    plt.grid()
    plt.yticks(fontsize=24)
    ax.set_xticks(dataframe.index)

    if len(dataframe) > 11:
        plt.xticks(fontsize=24, rotation=60)

    else:
        plt.xticks(fontsize=24)

    if save is True:
        plt.savefig(
            f"{target_folder}{scenario}_{sector}_{variable.lower()}_co2eq.png")
        plt.close()
    else:
        plt.show()
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
    scenario_name = ' '.join(fname_split[:-1])

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


def make_plots(data_paths, to_save):
    """
    This function produces all plots and puts them in a folder
    called 'figure.'

    Parameters:
    -----------
    data_paths : list of strings
        This is the list of paths to input files that contain data
        from Temoa runs.
    """

    plots_dict = {'emissions': emissions_plot,
                  'generation': bar_plot,
                  'capacity': bar_plot}

    # for each outputfile
    for file in data_paths:
        # get the name of the scenario run
        scenario = get_scenario_name(file)
        datalines = parse_datalines(file)
        # for each variable of interest
        for var in variables:
            # create dataframes
            if var == 'emissions':
                for byproduct in emissions:
                    df_all = create_dataframe(datalines,
                                              var,
                                              sector='all',
                                              emission=byproduct)
                    df_elc = create_dataframe(datalines,
                                              var,
                                              sector='elc',
                                              emission=byproduct)
                    df_ind = create_dataframe(datalines,
                                              var,
                                              sector='ind',
                                              emission=byproduct)
                    if byproduct is not 'co2eq':
                        bar_plot(dataframe=df_all,
                                 variable=var,
                                 scenario=scenario,
                                 sector='all',
                                 emission=byproduct,
                                 save=to_save)
                        bar_plot(dataframe=df_elc,
                                 variable=var,
                                 scenario=scenario,
                                 sector='elc',
                                 emission=byproduct,
                                 save=to_save)
                        bar_plot(dataframe=df_ind,
                                 variable=var,
                                 scenario=scenario,
                                 sector='ind',
                                 emission=byproduct,
                                 save=to_save)
                    else:
                        emissions_plot(dataframe=df_all,
                                       variable=var,
                                       scenario=scenario,
                                       sector='all',
                                       save=to_save)
                        emissions_plot(dataframe=df_elc,
                                       variable=var,
                                       scenario=scenario,
                                       sector='elc',
                                       save=to_save)
                        emissions_plot(dataframe=df_ind,
                                       variable=var,
                                       scenario=scenario,
                                       sector='ind',
                                       save=to_save)

            else:
                df_elc = create_dataframe(datalines, var, sector='elc')
                df_ind = create_dataframe(datalines, var, sector='ind')
                df_all = create_dataframe(datalines, var, sector='all')
                plot = plots_dict[var]
                plot(dataframe=df_elc,
                     variable=var,
                     scenario=scenario,
                     sector='elc',
                     save=to_save)
                plot(dataframe=df_ind,
                     variable=var,
                     scenario=scenario,
                     sector='ind',
                     save=to_save)
                plot(dataframe=df_all,
                     variable=var,
                     scenario=scenario,
                     sector='all',
                     save=to_save)

    return


if __name__ == "__main__":

    output = get_output_files()
    make_plots(output, True)
