import numpy as np
import pandas as pd
import data_parser as dp


def make_reactor_plots(data_paths, to_save=True):
    """
    This function produces the reactor plots and puts them in a folder
    called 'figures.'
    So far, the figures include the steam distribution from the nuclear
    reactor into the technologies NBINE and UH.

    Parameters:
    -----------
    data_paths : list of strings
        This is the list of paths to input files that contain data
        from Temoa runs.
    to_save: boolean
        True if saving the figure is desired.
    """

    file = data_paths[0]
    scenario = dp.get_scenario_name(file)
    datalines = dp.parse_datalines(file)

    years = np.arange(2021, 2051, 1)
    technology_dict = {}
    
    variable_data = dp.data_by_variable(datalines, 'V_FlowIn')
    variable_data = dp.data_by_variable(variable_data, 'NSTM')
    elec = dp.create_column(variable_data, years, 'NBINE')

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
    # print(technology_dict)
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
