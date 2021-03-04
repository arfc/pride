import numpy as np
import pandas as pd
import data_parser as dp


def make_reactor_plots(data_paths, to_save=True):
    """
    This function produces all plots and puts them in a folder
    called 'figures.'

    Parameters:
    -----------
    data_paths : list of strings
        This is the list of paths to input files that contain data
        from Temoa runs.
    to_save: boolean
        True if saving the figure is desired.
    """

    # plots_dict = {'emissions': emissions_plot,
    #               'generation': bar_plot,
    #               'capacity': bar_plot}

    variables = {'generation': 'V_FlowOut'}

    # for each outputfile
    # for file in data_paths:
        # get the name of the scenario run
    file = data_paths[0]
    scenario = dp.get_scenario_name(file)
    datalines = dp.parse_datalines(file)
        # for each variable of interest
        # for var in variables:
        #     if var == 'emissions':
        #         continue
            # create dataframes


    # I need:
    # For the Steam: V_FlowIn[uiuc,2021, - , - ,NSTM,UH,2021,USTM]
    # For the electricity: V_FlowOut[uiuc,2021, - , - ,NSTM,NBINE,2021,ELC]

    # flowin = dp.data_by_variable(datalines, 'V_FlowIn')

    years = np.arange(2021, 2051, 1)
    technology_dict = {}
    
    # for tech in techs:

    variable_data = dp.data_by_variable(datalines, 'V_FlowOut')
    tech = 'NBINE'
    elec = {"Year": years, tech: []}
    tech_data = dp.data_by_tech(variable_data, tech)
    for year in years:
        year_data = dp.data_by_year(tech_data, year)
        year_total = dp.get_total(year_data)
        elec[tech].append(year_total/0.33)
    # technology_dict.update(column)

    # This could be done with V_FlowIn[uiuc,2021, - , - ,NSTM,NBINE,2021,ELC]

    variable_data = dp.data_by_variable(datalines, 'V_FlowIn')
    variable_data = dp.data_by_variable(variable_data, 'NSTM')
    steam = dp.create_column(variable_data, years, 'UH')

    technology_dict = {}
    total = {"Year": years, "NBINE": [], "UH": []}
    for index, year in enumerate(years):
        try:
            el = elec['NBINE'][index]
        except:
            el = 0
        try:
            st = steam['UH'][index]
        except:
            st = 0
        tot = el + st
        total['NBINE'].append(el/tot)
        total['UH'].append(st/tot)

    technology_dict.update(total)
    print(technology_dict)
    dataframe = pd.DataFrame(technology_dict)
    dataframe.set_index('Year', inplace=True)
    dp.bar_plot(dataframe=dataframe,
                variable='generation',
                scenario=scenario,
                sector='reactor',
                save=to_save)

    return



if __name__ == "__main__":
    output = dp.get_output_files()
    make_reactor_plots(output, True)
