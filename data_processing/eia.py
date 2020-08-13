import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


def fuel_type_code():
    """
    This function creates a dictionary to correlate the
    reported fuel type code to the actual meaning.
    Returns:
    --------
    rosetta_stone: dict
        Dictionary to correlate the reported fuel type code
        to the actual meaning.
    """

    rosetta_stone = {
        'AB': 'Agricultural By-Products',
        'ANT': 'Anthracite Coal',
        'BFG': 'Blast Furnace Gas',
        'BIT': 'Bituminous Coal',
        'BLQ': 'Black Liquor',
        'DFO': 'Distillate Fuel Oil',
        'GEO': 'Geothermal',
        'JF': 'Jet Fuel',
        'KER': 'Kerosene',
        'LFG': 'Landfill Gas',
        'LIG': 'Lignite Coal',
        'MSB': 'Biogenic Municiple Solid Waste',
        'MSN': 'Non-biogenic Municiple Solid Waste',
        'MWH': 'Electricity Energy Storage',
        'NG': 'Natural Gas',
        'NUC': 'Nuclear',
        'OBG': 'Other Biomass Gas',
        'OBL': 'Other Biomass Liquids',
        'OBS': 'Other Biomass Solids',
        'OG': 'Other Gas',
        'OTH': 'Other Fuel',
        'PC': 'Petroleum Coke',
        'PG': 'Gaseous Propane',
        'PUR': 'Purchased Steam',
        'RC': 'Refined Coal',
        'RFO': 'Residual Fuel Oil',
        'SC': 'Coal-based Synfuel',
        'SGC': 'Coal-Derived Synthesis Gas',
        'SGP': 'Synthesis Gas from Petroleum Coke',
        'SLW': 'Sludge Waste',
        'SUB': 'Subbituminous Coal',
        'SUN': 'Solar',
        'TDF': 'Tire-Derived Fuels',
        'WAT': 'Water',
        'WC': 'Waste Coal',
        'WDL': 'Wood Waste Liquids',
        'WDS': 'Wood Waste Solids',
        'WH': 'Waste Heat',
        'WND': 'Wind',
        'WO': 'Waste Oil'
    }

    return rosetta_stone


def mover_database():
    """
    This function generates a hard-coded dictionary that
    translates the "Reported Prime Mover" code.
    Returns:
    --------
    mover: dict
        A dictionary containing the mover code as the key
        and the translation as the value.
    """

    mover = {
        'BA': 'Battery',
        'BT': 'Binary Cycle Turbine',
        'CA': 'Combined-Cycle Steam',
        'CE': 'Compressed Air',
        'CP': 'Concentrated Solar Power',
        'CS': 'Combined-Cycle Steam and Combustion',
        'CT': 'Combined-Cycle Combustion',
        'ES': 'Energy Storage',
        'FC': 'Fuel Cell',
        'FW': 'Flywheel',
        'GT': 'Gas Turbine',
        'HA': 'Hydrokinetic Axial Flow Turbine',
        'HB': 'Hydrokinetic Wave Buoy',
        'HK': 'Hydrokinetic Other',
        'HY': 'Hydraulic Turbine',
        'IC': 'Internal Combustion Engine',
        'PS': 'Pumped Storage',
        'OT': 'Other',
        'ST': 'Steam Turbine',
        'PV': 'Photovoltaic',
        'WT': 'Wind Turbine Onshore',
        'WT': 'Wind Turbine Offshore'
    }

    return mover


def generation(year: str,
               facility: str = 'University',
               path: str = '../../data/',
               prefix: str = 'eia_generation_'):
    '''
    This function generates a nested dictionary of the operators
    present in the EIA spreadsheet and their generation amounts
    by each fuel/mover type combination.
    Parameters:
    -----------
    year: str
        This is the string for the year being analyzed.
    facility: str
        This is the type of generation facility to be analyzed.
        Default is 'University'.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    Returns:
    --------
    final: dict
        Nested dictionary of the operators present in the EIA
        spreadsheet and their generation amounts in MWhr by each fuel/mover
        type combination.
    '''

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    naics = {
        'University': 611,
        'Hospital': 622,
        'Newsprint': 322122,
        'Food': 311
    }

    if int(year) < 2011:

        headers = 7

    elif int(year) >= 2011:

        headers = 5

    generation = pd.read_csv((path + prefix + year + '.csv'),
                             usecols=[4, 8, 10, 13, 14, 95],
                             header=headers,
                             encoding='unicode_escape'
                             )

    facilities = generation[generation.columns[2]] == naics[facility]

    generation = generation.loc[facilities]

    generation[facility] = generation[
        generation.columns[0]
    ] + ' ' + generation[generation.columns[1]]

    generation = generation.drop(
        generation.columns[[0, 1]],
        axis=1
    )

    operator_keys = generation[facility].values.tolist()

    final = dict()

    fuel_type_list = list()

    for op in operator_keys:

        totalgen = 0

        fuel_dict = dict()

        iterable_dataframe = generation.loc[
            generation[facility] == op
        ]

        fuel_type_list = iterable_dataframe[
            generation.columns[2]
        ].unique().tolist()

        for fuel in fuel_type_list:

            mover_dict = dict()

            fuel_dataframe = iterable_dataframe.loc[
                generation[facility] == op
            ].loc[
                iterable_dataframe[generation.columns[2]] == fuel
            ]

            mover_list = fuel_dataframe[
                generation.columns[1]
            ].values.tolist()

            netgen_list = fuel_dataframe[
                generation.columns[3]
            ].values.tolist()

            for i in range(len(mover_list)):

                totalgen += netgen_list[i]

                if mover_list[i] in mover_dict:

                    mover_dict[mover_list[i]] += netgen_list[i]

                else:

                    mover_dict.update({mover_list[i]: netgen_list[i]})

            fuel_dict.update({fuel: mover_dict})

        fuel_dict.update({'Total Generation': totalgen})

        final.update({op: fuel_dict})

    return final


def operator_top_producers(year: str,
                           facility: str = 'University',
                           path: str = '../../data/',
                           prefix: str = 'eia_generation_'):
    """
    This function uses earlier functions to generate a dictionary in
    descending order of the highest energy producing operators
    in the USA from 20XX and the amount of energy produced in MWhr.
    Parameters:
    -----------
    year: str
        The year that is being analyzed.
    facility: str
        This is the type of generation facility to be analyzed.
        Default is 'University'.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    Returns:
    --------
    top_producers: dict
        This is a dictionary containing the operator at the key
        and the amount of energy in MWhr at the value.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    global_dict = generation(year=inp,
                             facility=facility_arg,
                             path=path_arg,
                             prefix=prefix_arg)

    new_dict = dict()

    for op in global_dict:

        new_dict.update({op: global_dict[op]['Total Generation']})

    top_producers = sorted(new_dict.items(), key=lambda x: x[1], reverse=True)

    return dict(top_producers)


def energy_type_breakdown(year: str,
                          facility: str = 'University',
                          path: str = '../../data/',
                          prefix: str = 'eia_generation_'):
    """
    Uses previous functions to generate a dictionary of the various
    types of fuel used by the university system in the US for 20XX.
    Parameters:
    -----------
    year: str
        This is the year to be analyzed.
    facility: str
        This is the type of generation facility to be analyzed.
        Default is 'University'.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    Returns:
    --------
    fuel_breakdown: dict
        This is a dictionary with keys of each fuel type used by the
        university system in the USA in 20XX and values of the amounts.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    data = generation(year=inp,
                      facility=facility_arg,
                      path=path_arg,
                      prefix=prefix_arg)

    rosetta_stone = fuel_type_code()

    fuel_breakdown = dict()

    for operator in data:

        del data[operator]['Total Generation']

        for fuel_type in data[operator]:

            if fuel_type not in fuel_breakdown:

                counter = 0

                for mover in data[operator][fuel_type]:

                    counter += data[operator][fuel_type][mover]

                fuel_breakdown.update({fuel_type: counter})

            elif fuel_type in fuel_breakdown:

                counter = 0

                for mover in data[operator][fuel_type]:

                    counter += data[operator][fuel_type][mover]

                fuel_breakdown[fuel_type] += counter

    fuel_breakdown_decoded = dict()

    for fuel_type in fuel_breakdown:

        fuel_breakdown_decoded.update(
            {rosetta_stone[fuel_type]: fuel_breakdown[fuel_type]}
        )

    fuel_breakdown = fuel_breakdown_decoded

    return fuel_breakdown


def operator_top_renewables(year: str,
                            facility: str = 'University',
                            path: str = '../../data/',
                            prefix: str = 'eia_generation_'):
    """
    This function uses earlier functions to establish an
    ordered dictionary of the top operators for
    renewable energy production in the USA in 20XX.
    Parameters:
    -----------
    year: str
        This is the year being analyzed.
    facility: str
        This is the type of generation facility to be analyzed.
        Default is 'University'.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    Returns:
    --------
    top_renewables: dictionary
        A dictionary containing the operator as the
        key and the value is the amount of renewable
        energy produced in MWhrs.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    renewables_list = ['GEO', 'WND', 'SUN', 'WAT', 'OBG', 'OBL', 'OBS']

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    global_dict = generation(year=inp,
                             facility=facility_arg,
                             path=path_arg,
                             prefix=prefix_arg)

    renewables_dict = dict()

    counter = 0

    for op in global_dict:

        del global_dict[op]['Total Generation']

        for fuel in global_dict[op]:

            if fuel in renewables_list:

                for mover in global_dict[op][fuel]:

                    counter += global_dict[op][fuel][mover]

        renewables_dict.update({op: counter})

        counter = 0

    top_renewables = sorted(
        renewables_dict.items(), key=lambda x: x[1], reverse=True
    )

    new_top_renewables = list()

    for index in range(len(top_renewables)):

        if int(top_renewables[index][1]) != 0:

            new_top_renewables.append(top_renewables[index])

    top_renewables = new_top_renewables

    return dict(top_renewables)


def usage(year: str,
          facility: str = 'University',
          path: str = '../../data/',
          prefix: str = 'eia_generation_',
          sort: str = 'installed'):
    """
    This function generates a dictionary detailing how many operators
    are using each fuel type.
    Parameters:
    -----------
    sort: str
        An argument that signals whether 'active' or 'installed' information
        will be gathered from the 20XX year.
    facility: str
        This is the type of generation facility to be analyzed.
        Default is 'University'.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    year: str
        This is the year being analyzed.
    Returns:
    --------
    base_dict: dict
        A dictionary containing the fuel type as the key and the amount
        of operators using that fuel.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    allowed_strings = ['installed', 'active']

    if not isinstance(sort, str):

        raise TypeError("Argument 'sort' must be of type 'str'.")

    if sort not in allowed_strings:

        raise ValueError(
            "Argument 'sort' must take value of 'installed or 'active'."
        )

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    naics = {
        'University': 611,
        'Hospital': 622,
        'Newsprint': 322122,
        'Food': 311
    }

    if int(year) < 2011:

        headers = 7

    elif int(year) >= 2011:

        headers = 5

    label_generation = pd.read_csv((path + prefix + year + '.csv'),
                                   usecols=[4, 8, 10, 13, 14, 95],
                                   header=headers,
                                   encoding='unicode_escape'
                                   )

    facilities = label_generation[
        label_generation.columns[2]
    ] == naics[facility]

    label_generation = label_generation.loc[facilities]

    labels = label_generation[
        label_generation.columns[4]
    ].unique().tolist()

    base_dict = dict()

    for fuel in labels:

        base_dict.update({fuel: 0})

    data = generation(year=inp,
                      facility=facility_arg,
                      path=path_arg,
                      prefix=prefix_arg)

    for operator in data:

        del data[operator]['Total Generation']

        for fuel_type in data[operator]:

            if sort == 'installed':

                base_dict[fuel_type] += 1

            elif sort == 'active':

                summ = 0

                for mover in data[operator][fuel_type]:

                    if data[operator][fuel_type][mover] != 0:

                        summ += 1

                if summ != 0:

                    base_dict[fuel_type] += 1

    return base_dict


def capacity_factors():
    """
    This function generates a hard-coded dictionary
    containing the capacity factors for different fuels
    and movers. The values are defaulted to 1.0 if no
    capacity factor information can be found. The
    numbers are specific to the 2018 year and may lead
    to innacurate results or KeyErrors if applied to
    other years.
    Returns:
    --------
    cf: dict
        A dictionary containing the capacity factors for
        different fuels and movers.
    """

    cf = {
        'DFO': {
            'IC': 0.019,
            'GT': 0.013,
            'ST': 0.142,
            'CA': 0.142,
            'CT': 0.019
        },
        'NG': {
            'IC': 0.13,
            'GT': 0.119,
            'CA': 0.55,
            'CT': 0.55,
            'ST': 0.126,
            'CS': 0.55,
            'FC': 0.729
        },
        'WAT': {'HY': 0.428},
        'BIT': {
            'ST': 0.536,
            'CT': 0.536,
            'GT': 0.536,
            'IC': 0.536
        },
        'WDS': {'ST': 0.493},
        'RFO': {
            'IC': 0.019,
            'ST': 0.142,
            'CT': 0.019,
            'GT': 0.013
        },
        'SUN': {'PV': 26.1},
        'KER': {'GT': 1.0},
        'PC': {'ST': 0.142},
        'PG': {'ST': 1.0},
        'SUB': {'ST': 0.436},
        'LFG': {
            'CA': 0.733,
            'CT': 0.733,
            'IC': 0.733,
            'GT': 0.733
        },
        'MWH': {'BA': 1.0},
        'OBS': {'ST': 0.493},
        'WND': {'WT': 0.374},
        'OBL': {'IC': 0.493}
    }

    return cf


def operator_capacity(year: str = '2018',
                      facility: str = 'University',
                      path: str = '../../data/',
                      prefix: str = 'eia_generation_'):
    """
    This function uses previous functions to generate
    a dictionary containing an estimate for the total
    capacity of each operator in 2018.
    Parameters:
    -----------
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    facility: str
        This is the type of generation facility to be analyzed.
        Default is 'University'.
    year: str
        This is the year being analyzed.
    Returns:
    --------
    capacity: dict
        A dictionary with each university as a key and
        an estimate of the total capacity at the value in
        MW.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    data = generation(year=inp,
                      facility=facility_arg,
                      path=path_arg,
                      prefix=prefix_arg)

    cf = capacity_factors()

    hours = 8760

    capacity = dict()

    for operator in data:

        del data[operator]['Total Generation']

        cap = 0

        for fuel in data[operator]:

            for mover in data[operator][fuel]:

                try:

                    cap += data[operator][fuel][mover] / \
                        hours / cf[fuel][mover]

                except KeyError:

                    cap += data[operator][fuel][mover] / hours

        capacity.update({operator: cap})

    capacity = dict(sorted(capacity.items(), key=lambda x: x[1], reverse=True))

    return capacity


def sources(capacity_factor: bool = True):
    """
    This function provides the links to the sources used
    for obtaining certain information. The arguments
    can either be set to the appropriate boolean based
    on the sources required.
    Parameters:
    -----------
    capacity_factor: bool
        This argument determines whether the sources for the
        capacity factor data will be returned. Default is True.
    """

    if not isinstance(capacity_factor, bool):

        raise TypeError(
            "Argument 'capacity_factor' must be of type 'bool'."
        )

    if capacity_factor is True:

        print(
            'Capacity Factor Sources:'
        )

        print(
            'https://www.statista.com/statistics/183680/us-aver' +
            'age-capacity-factors-by-selected-energy-source-since-1998/'
        )

        print(
            'https://www.eia.gov/electricity/monthly/epm_table_grapher.ph' +
            'p?t=epmt_6_07_a'
        )

        print(
            'https://www.hydrogen.energy.gov/pdfs/review16/tv016_saur_2016' +
            '_p.pdf'
        )

        return None


def split_dictionary(dictionary: dict,
                     year: str,
                     facility: str = 'University',
                     path: str = '../../data/',
                     prefix: str = 'eia_generation_'):
    """
    This function generates a nested list containing
    plottable portions of data. This is specifically for
    segmented bar graphs in later functions.
    Parameters:
    -----------
    dictionary: dict
        This is the dictionary to be split up.
    year: str
        This is the year the dictionary is based on.
    facility: str
        This is the type of generation facility to be analyzed.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    Returns:
    --------
    split: list
        This is a nested list that can be plotted.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    if not isinstance(dictionary, dict):

        raise TypeError(
            "Argument 'dictionary' must be of type 'dict'."
        )

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    operators = list()

    label_dictionary = dict()

    naics = {
        'University': 611,
        'Hospital': 622,
        'Newsprint': 322122,
        'Food': 311
    }

    if int(year) < 2011:

        headers = 7

    elif int(year) >= 2011:

        headers = 5

    label_generation = pd.read_csv((path + prefix + year + '.csv'),
                                   usecols=[4, 8, 10, 13, 14, 95],
                                   header=headers,
                                   encoding='unicode_escape'
                                   )

    oper = label_generation[
        label_generation.columns[2]
    ] == naics[facility]

    label_generation = label_generation.loc[oper]

    labels = label_generation[
        label_generation.columns[4]
    ].unique().tolist()

    for label in labels:

        label_dictionary.update({label: list()})

    for operator, value in dictionary.items():

        operators.append(operator)

        for fuel in label_dictionary:

            try:

                label_dictionary[fuel].append(value[fuel])

            except KeyError:

                label_dictionary[fuel].append(0)

    split = [operators]

    for fuel in label_dictionary:

        split.append(label_dictionary[fuel])

    return split


def plot_data(year: str,
              facility: str = 'University',
              path: str = '../../data/',
              prefix: str = 'eia_generation_',
              total: bool = False,
              top_producers: bool = False,
              top_renewables: bool = False,
              fuel_breakdown: bool = False,
              capacity: bool = False,
              use: bool = False):
    """
    This function plots the data in the EIA spreadsheet
    for the operators depending on the arguments
    applied.
    Parameters:
    -----------
    year: str
        This is the year to be analyzed.
    facility: str
        This is the type of generation facility to be analyzed.
    total: bool
        This argument determines whether or not the results
        for the function 'generation' will be plotted.
        Default is False.
    top_producers: bool
        This argument determines whether or not the results
        for the function 'operator_top_producers' will be
        plotted. Default is False.
    top_renewables: bool
        This argument determines whether or not the results
        for the function 'operator_top_renewables' will be
        plotted. Default is False.
    fuel_breakdown: bool
        This argument determines whether or not the results
        for the function 'energy_type_breakdown' will be
        plotted. Default is false.
    capacity: bool
        This argument determines whether or not the results
        for the function 'operator_capacity' will be
        plotted. Default is false
    use: bool
        This argument determines whether or not the results
        for the function 'usage' will be plotted. Default is
        false.
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    allowed_years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    if not isinstance(total, bool):

        raise TypeError(
            "Argument 'total' must be of type 'bool'."
        )

    if not isinstance(top_producers, bool):

        raise TypeError(
            "Argument 'top_producers' must be of type 'bool'."
        )

    if not isinstance(top_renewables, bool):

        raise TypeError(
            "Argument 'top_renewables' must be of type 'bool'."
        )

    if not isinstance(fuel_breakdown, bool):

        raise TypeError(
            "Argument 'fuel_breakdown' must be of type 'bool'."
        )

    if not isinstance(capacity, bool):

        raise TypeError(
            "Argument 'capacity' must be of type 'bool'."
        )

    if not isinstance(use, bool):

        raise TypeError(
            "Argument 'use' must be of type 'bool'."
        )

    plt.rcParams['figure.dpi'] = 600

    inp = year
    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    graph = {
        'University': ('Education', 'Universities'),
        'Hospital': ('Medical', 'Hospitals'),
        'Newsprint': ('Newsprint', 'Companies'),
        'Food': ('Food Processing', 'Companies')
    }

    if total is True:

        data = generation(year=inp,
                          facility=facility_arg,
                          path=path_arg,
                          prefix=prefix_arg)

        data = dict(sorted(
            data.items(), key=lambda x: x[1]['Total Generation'], reverse=True
        ))

        segmented_dict = dict()

        for operator in data:

            op_dict = dict()

            del data[operator]['Total Generation']

            for fuel in data[operator]:

                counter = 0

                for mover in data[operator][fuel]:

                    counter += data[operator][fuel][mover]

                op_dict.update({fuel: counter})

            segmented_dict.update({operator: op_dict})

        split = split_dictionary(dictionary=segmented_dict,
                                 facility=facility_arg,
                                 year=inp,
                                 path=path_arg,
                                 prefix=prefix_arg)

        plt.figure(figsize=(25, 10))

        plt.title(
            f'Top Electric Production in {graph[facility][0]} Sector ({inp})'
        )

        plt.ylabel('Electicity Production (MWhr)')

        plt.xlabel(graph[facility][1], fontsize=8)

        plt.xticks(rotation='vertical')

        naics = {
            'University': 611,
            'Hospital': 622,
            'Newsprint': 322122,
            'Food': 311
        }

        if int(year) < 2011:

            headers = 7

        elif int(year) >= 2011:

            headers = 5

        label_generation = pd.read_csv((path + prefix + year + '.csv'),
                                       usecols=[4, 8, 10, 13, 14, 95],
                                       header=headers,
                                       encoding='unicode_escape'
                                       )

        oper = label_generation[
            label_generation.columns[2]
        ] == naics[facility]

        label_generation = label_generation.loc[oper]

        labels = label_generation[
            label_generation.columns[4]
        ].unique().tolist()

        colors = [
            '#FFFF00',
            '#008B8B',
            '#800080',
            '#FF0000',
            '#FF00FF',
            '#008000',
            '#DC7633',
            '#00FF00',
            '#00FFFF',
            '#000080',
            '#F08080',
            '#008080',
            '#0000FF',
            '#000000',
            '#999999',
            '#FFA500',
            '#D2691E',
            '#ff69b4',
            '#C0C0C0',
            '#A9A9A9',
            '#FFA500',
            '#A5F2F3',
            '#fffdd0',
            '#FFC200'
        ]

        bot = np.zeros(len(split[0]))

        for i in range(len(labels)):

            plt.bar(
                split[0],
                np.array(split[i + 1]),
                bottom=bot,
                label=fuel_type_code()[labels[i]],
                color=colors[i]
            )

            bot = bot + np.array(split[i + 1])

        plt.legend(prop={'size': 12})

    if top_producers is True:

        producers = operator_top_producers(year=inp,
                                           facility=facility_arg,
                                           path=path_arg,
                                           prefix=prefix_arg)

        top_10 = dict()

        top_dic = {
            'University': {
                '2018': 150000,
                '2017': 170000,
                '2016': 172000,
                '2015': 160000,
                '2014': 161000,
                '2013': 150000,
                '2012': 183610,
                '2011': 145000,
                '2010': 130000,
                '2009': 125000,
                '2008': 147000
            },
            'Hospital': {
                '2018': 35000,
                '2017': 46000,
                '2016': 32000,
                '2015': 31000,
                '2014': 35000,
                '2013': 32000,
                '2012': 34000,
                '2011': 24200,
                '2010': 22000,
                '2009': 20000,
                '2008': 21000
            },
            'Newsprint': {
                '2018': 500000,
                '2017': 500000,
                '2016': 500000,
                '2015': 500000,
                '2014': 535000,
                '2013': 535000,
                '2012': 555000,
                '2011': 560000,
                '2010': 575000,
                '2009': 570000,
                '2008': 640000
            },
            'Food': {
                '2018': 78000,
                '2017': 82000,
                '2016': 93000,
                '2015': 116000,
                '2014': 124000,
                '2013': 144000,
                '2012': 135000,
                '2011': 121000,
                '2010': 90000,
                '2009': 87000,
                '2008': 92000
            }
        }

        for op in producers:

            if producers[op] >= top_dic[facility][inp]:

                top_10.update({op: producers[op]})

        operators_total = list()

        energy_total = list()

        for key, value in top_10.items():

            operators_total.append(key)

            energy_total.append(value)

        plt.figure()

        plt.title(
            f'Top Electric Production in {graph[facility][0]} Sector ({inp})'
        )

        plt.ylabel('Electicity Production (MWhr)')

        plt.xlabel(graph[facility][1])

        plt.xticks(rotation='vertical')

        plt.bar(operators_total, energy_total)

    if top_renewables is True:

        renewables = operator_top_renewables(year=inp,
                                             facility=facility_arg,
                                             path=path_arg,
                                             prefix=prefix_arg)

        ren_top_10 = dict()

        top_dic = {
            'University': {
                '2018': 5800,
                '2017': 5600,
                '2016': 5000,
                '2015': 5000,
                '2014': 5000,
                '2013': 4500,
                '2012': 3519,
                '2011': 2900,
                '2010': 0,
                '2009': 0,
                '2008': 0
            },
            'Hospital': {
                '2018': 0,
                '2017': 0,
                '2016': 0,
                '2015': 0,
                '2014': 0,
                '2013': 0,
                '2012': 0,
                '2011': 0,
                '2010': 0,
                '2009': 0,
                '2008': 0
            },
            'Newsprint': {
                '2018': 11000,
                '2017': 25000,
                '2016': 23000,
                '2015': 18900,
                '2014': 19000,
                '2013': 17000,
                '2012': 13000,
                '2011': 25000,
                '2010': 26000,
                '2009': 24998,
                '2008': 23000
            },
            'Food': {
                '2018': 0,
                '2017': 0,
                '2016': 0,
                '2015': 0,
                '2014': 0,
                '2013': 0,
                '2012': 0,
                '2011': 0,
                '2010': 0,
                '2009': 0,
                '2008': 0
            }
        }

        for op in renewables:

            if renewables[op] >= top_dic[facility][inp]:

                ren_top_10.update({op: renewables[op]})

        ren_operators_total = list()

        ren_energy_total = list()

        for key, value in ren_top_10.items():

            ren_operators_total.append(key)

            ren_energy_total.append(value)

        plt.figure()

        plt.title(
            f'Top Renewable Production in {graph[facility][0]} Sector ({inp})'
        )

        plt.ylabel('Renewable Electicity Production (MWhr)')

        plt.xlabel(graph[facility][1])

        plt.xticks(rotation='vertical')

        plt.bar(ren_operators_total, ren_energy_total)

    if fuel_breakdown is True:

        breakdown = energy_type_breakdown(year=inp,
                                          facility=facility_arg,
                                          path=path_arg,
                                          prefix=prefix_arg)

        pi_fuels = list()

        pi_energy = list()

        percentages = {
            'University': {
                '2018': ('90.3%', '', ''),
                '2017': ('89.9%', '', ''),
                '2016': ('89.3%', '', ''),
                '2015': ('86.9%', '', ''),
                '2014': ('85.2%', '', ''),
                '2013': ('84.1%', '', ''),
                '2012': ('83.2%', '', ''),
                '2011': ('76.9%', '', '18.6%'),
                '2010': ('74.9%', '', '21.3%'),
                '2009': ('69.7%', '', '23.6%'),
                '2008': ('69.9%', '', '26.2%')
            },
            'Hospital': {
                '2018': ('98.3%', '', ''),
                '2017': ('97.8%', '', ''),
                '2016': ('97.4%', '', ''),
                '2015': ('96.5%', '', ''),
                '2014': ('95.8%', '', ''),
                '2013': ('96.8%', '', ''),
                '2012': ('95.7%', '', ''),
                '2011': ('97.2%', '', ''),
                '2010': ('95.8%', '', ''),
                '2009': ('94.2%', '', ''),
                '2008': ('97.8%', '', '')
            },
            'Newsprint': {
                '2018': ('', '', ''),
                '2017': ('', '', ''),
                '2016': ('', '', ''),
                '2015': ('', '', ''),
                '2014': ('', '', ''),
                '2013': ('', '', ''),
                '2012': ('', '', ''),
                '2011': ('', '', ''),
                '2010': ('', '', ''),
                '2009': ('', '', ''),
                '2008': ('', '', '')
            },
            'Food': {
                '2018': ('', '', ''),
                '2017': ('', '', ''),
                '2016': ('', '', ''),
                '2015': ('', '', ''),
                '2014': ('', '', ''),
                '2013': ('', '', ''),
                '2012': ('', '', ''),
                '2011': ('', '', ''),
                '2010': ('', '', ''),
                '2009': ('', '', ''),
                '2008': ('', '', '')
            }
        }

        label = list()

        for key, value in breakdown.items():

            pi_fuels.append(key)

            pi_energy.append(value)

        for i in range(len(pi_fuels)):

            label.append('')

        label[1] = percentages[facility][inp][0]
        label[2] = percentages[facility][inp][1]
        label[3] = percentages[facility][inp][2]

        color_base = [
            '#FFFF00',
            '#FFA500',
            '#800080',
            '#FF0000',
            '#FF00FF',
            '#008000',
            '#DC7633',
            '#00FF00',
            '#00FFFF',
            '#000080',
            '#F08080',
            '#008080',
            '#0000FF',
            '#000000',
            '#999999',
            '#b5651d',
            '#FFA500',
            '#D2691E',
            '#ff69b4',
            '#C0C0C0',
            '#A9A9A9',
            '#FFA500',
            '#A5F2F3',
            '#fffdd0',
            '#FFC200'
        ]

        color = list()

        for i in range(len(pi_fuels)):

            color.append(color_base[i])

        plt.figure()

        fig1, ax1 = plt.subplots()

        plt.title(f'{inp} Energy Breakdown in {graph[facility][0]}')

        ax1.pie(
            pi_energy,
            colors=color,
            startangle=90,
            labels=label,
            labeldistance=0.5
        )

        ax1.axis('equal')

        ax1.legend(pi_fuels, prop={'size': 6})

    if capacity is True:

        cap = operator_capacity(year=inp,
                                facility=facility_arg,
                                path=path_arg,
                                prefix=prefix_arg)

        new_cap = dict()

        for op in cap:

            if cap[op] >= 2:

                new_cap.update({op: cap[op]})

        cap = new_cap

        ops = list()

        capac = list()

        for key, value in cap.items():

            ops.append(key)

            capac.append(value)

        plt.figure(figsize=(15, 6))

        plt.title(
            f'Electric Capacity in {graph[facility][0]} Sector ({inp})'
        )

        plt.ylabel('Capacity (MW)')

        plt.xlabel(graph[facility][1], fontsize=8)

        plt.xticks(rotation='vertical')

        plt.bar(ops, capac)

    if use is True:

        inst = usage(year=inp,
                     facility=facility_arg,
                     path=path_arg,
                     prefix=prefix_arg,
                     sort='installed')

        inst = sorted(inst.items(), key=lambda x: x[1], reverse=True)

        act = usage(year=inp,
                    facility=facility_arg,
                    path=path_arg,
                    prefix=prefix_arg,
                    sort='active')

        act = sorted(act.items(), key=lambda x: x[1], reverse=True)

        plotting = [inst, act]

        for method in plotting:

            if method == inst:

                title = 'Installed'

            else:

                title = 'Active'

            fuels = list()

            ops = list()

            for key, value in method:

                fuels.append(key)

                ops.append(value)

            plt.figure()

            plt.title(f'{title} Fuel Usage by {graph[facility][1]} in {inp}.')

            plt.ylabel(f'Number of {graph[facility][1]}')

            plt.xlabel('Fuel Type')

            plt.xticks(rotation='vertical')

            plt.bar(fuels, ops)

    return None


def plot_energy_change(energy: str,
                       facility: str = 'University',
                       path: str = '../../data/',
                       prefix: str = 'eia_generation_',
                       operator: str = 'all'):
    """
    This function plots how the a specific energy generation type
    has changed since 2008 for a desired facility.
    Parameters:
    -----------
    energy: str
        This is the type of energy to be analyzed. Must be entered
        by fuel type code. For instance, natural gas is 'NG'.
    facility: str
        This is the type of generation facility to be analyzed.
    operator: str
        This is the operator whose data is to be examined.
        Default is 'all'
    path: str
        This is the path to the location of the file to be analyzed.
    prefix: str
        This is the prefix to the year in the title of the csv file.
    """

    if not isinstance(energy, str):

        raise TypeError(
            "All arguments for this function must be of type 'str'."
        )

    if not isinstance(facility, str):

        raise TypeError(
            "Argument 'facility' must be of type 'str'."
        )

    allowed_facilities = [
        'University',
        'Hospital',
        'Newsprint',
        'Food'
    ]

    if facility not in allowed_facilities:

        raise ValueError(
            f"Not a valid facilty. Options: {*allowed_facilities,}."
        )

    if not isinstance(operator, str):

        raise TypeError(
            "All arguments for this function must be of type 'str'."
        )

    if not isinstance(path, str):

        raise TypeError(
            "Argument 'path' must be of type 'str'."
        )

    if not isinstance(prefix, str):

        raise TypeError(
            "Argument 'prefix' must be of type 'str'."
        )

    path_arg = path
    prefix_arg = prefix
    facility_arg = facility

    data08 = generation(
        year='2008',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data09 = generation(
        year='2009',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data10 = generation(
        year='2010',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data11 = generation(
        year='2011',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data12 = generation(
        year='2012',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data13 = generation(
        year='2013',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data14 = generation(
        year='2014',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data15 = generation(
        year='2015',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data16 = generation(
        year='2016',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data17 = generation(
        year='2017',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )
    data18 = generation(
        year='2018',
        facility=facility_arg,
        path=path_arg,
        prefix=prefix_arg
    )

    dic_list = [
        data08,
        data09,
        data10,
        data11,
        data12,
        data13,
        data14,
        data15,
        data16,
        data17,
        data18
    ]

    if (
            operator not in data08.keys()) and (
            operator not in data09.keys()) and (
            operator not in data10.keys()) and (
            operator not in data11.keys()) and (
            operator not in data12.keys()) and (
            operator not in data13.keys()) and (
            operator not in data14.keys()) and (
            operator not in data15.keys()) and (
            operator not in data16.keys()) and (
            operator not in data17.keys()) and (
            operator not in data18.keys()):

        if operator != 'all':

            raise ValueError(
                f"{facility} '{operator}' not supported."
            )

    try:

        energy_1 = fuel_type_code()[energy]

    except KeyError:

        raise ValueError(
            f"Energy type '{energy}' not supported."
        )

    if (
            energy_1 not in energy_type_breakdown(year='2008',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2009',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2010',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2011',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2012',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2013',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2014',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2015',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2016',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2017',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)) and (
            energy_1 not in energy_type_breakdown(year='2018',
                                                  facility=facility_arg,
                                                  path=path_arg,
                                                  prefix=prefix_arg)):

        raise ValueError(
            f"Energy type '{energy}' not present in this sector."
        )

    years = [
        '2008',
        '2009',
        '2010',
        '2011',
        '2012',
        '2013',
        '2014',
        '2015',
        '2016',
        '2017',
        '2018'
    ]

    amounts = list()

    if operator == 'all':

        for inp in years:

            try:

                amounts.append(
                    energy_type_breakdown(
                        year=inp,
                        facility=facility_arg,
                        path=path_arg,
                        prefix=prefix_arg
                    )[energy_1]
                )

            except KeyError:

                amounts.append(0)

    else:

        for dic in dic_list:

            summ = 0

            try:

                for key in dic[operator][energy]:

                    summ += dic[operator][energy][key]

                amounts.append(summ)

            except KeyError:

                amounts.append(0)

    plt.rcParams['figure.dpi'] = 600

    plt.figure()

    graph = {
        'University': 'Education',
        'Hospital': 'Medical',
        'Newsprint': 'Newsprint',
        'Food': 'Food Processing'
    }

    if operator == 'all':

        plt.title(
            f'{energy_1} Change in {graph[facility]} Electricity Generation'
        )

    else:

        plt.title(
            f'{energy_1} Change in {operator} Electricity Generation'
        )

    plt.ylabel('Generation (MWhr)')

    plt.xticks(rotation='vertical')

    plt.bar(years, amounts)

    return None
