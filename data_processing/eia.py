import numpy as np
import matplotlib.pyplot as plt
path = 'C:\\Users\\Atwater\\research\\data\\'


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


def generation(year: str):
    '''
    This function generates a nested dictionary of the Universities
    present in the EIA spreadsheet and their generation amounts
    by each fuel/mover type combination.

    Parameters:
    -----------
    year: str
        This is the string for the year being analyzed.

    Returns:
    --------
    gen_dict: dict
        Nested dictionary of the Universities present in the EIA
        spreadsheet and their generation amounts in MWhr by each fuel/mover
        type combination.

    '''

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    allowed_years = [
        '2008',
        '2012',
        '2016',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    sheet = path + 'eia_generation_' + year + '.csv'

    Generation = sheet

    with open(Generation, 'r') as i:

        generation = i.read().splitlines()

    lines = list()

    for line in generation:

        lines.append(line.split(','))

    for i in range(0, 90):

        del lines[0]

    global_dict = dict()

    name_dict = dict()

    name_old = ''

    region_old = ''

    names_checked = list()

    for line in range(0, len(lines)):

        operator = lines[line]

        if int(operator[10]) == 611:

            name = operator[4]

            region = operator[8]

            fuel_type = operator[14]

            mover = operator[13]

            amount = float(operator[95])

            if name_old == name:

                if fuel_type in name_dict:

                    if mover in name_dict[fuel_type]:

                        name_dict[fuel_type][mover] += amount

                    elif mover not in name_dict[fuel_type]:

                        name_dict[fuel_type].update({mover: amount})

                elif fuel_type not in name_dict:

                    name_dict.update({fuel_type: {mover: amount}})

            elif name_old != name:

                if name_old not in global_dict:

                    counter = 0

                    for fuel in name_dict:

                        for prime in name_dict[fuel]:

                            counter += name_dict[fuel][prime]

                    name_dict.update({'Total Generation': counter})

                    global_dict.update({name_old: name_dict})

                    if (name_old, region_old) not in names_checked:

                        names_checked.append((name_old, region_old))

                elif name_old in global_dict:

                    if (name_old, region_old) in names_checked:

                        counter = 0

                        for fuel in name_dict:

                            for prime in name_dict[fuel]:

                                counter += name_dict[fuel][prime]

                                if fuel in global_dict[name_old]:

                                    if prime in global_dict[name_old][fuel]:

                                        global_dict[name_old][fuel][prime] += (
                                            name_dict[fuel][prime]
                                        )

                                    else:

                                        global_dict[name_old][fuel].update(
                                            {prime: name_dict[fuel][prime]}
                                        )

                                elif fuel not in global_dict[name_old]:

                                    global_dict[name_old].update(
                                        {fuel: name_dict[fuel]}
                                    )

                                new_total = (
                                    counter + (
                                        global_dict[name_old][
                                            'Total Generation'
                                        ]
                                    )
                                )

                                global_dict[name_old].update(
                                    {'Total Generation': new_total}
                                )

                    elif (name_old, region_old) not in names_checked:

                        name_old = name_old + ' ' + region_old

                        counter = 0

                        for fuel in name_dict:

                            for prime in name_dict[fuel]:

                                counter += name_dict[fuel][prime]

                        name_dict.update({'Total Generation': counter})

                        global_dict.update({name_old: name_dict})

                name_dict = dict()

                if fuel_type in name_dict:

                    if mover in name_dict[fuel_type]:

                        name_dict[fuel_type][mover] += amount

                    elif mover not in name_dict[fuel_type]:

                        name_dict[fuel_type].update({mover: amount})

                elif fuel_type not in name_dict:

                    name_dict.update({fuel_type: {mover: amount}})

            name_old = name

            region_old = region

    del global_dict['']

    return global_dict


def university_top_producers(year: str):
    """
    This function uses earlier functions to generate a dictionary in
    descending order of the highest energy producing universities
    in the USA from 20XX and the amount of energy produced in MWhr.

    Parameters:
    -----------
    year: str
        The year that is being analyzed.

    Returns:
    --------
    top_producers: dict
        This is a dictionary containing the university at the key
        and the amount of energy in MWhr at the value.
    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    allowed_years = [
        '2008',
        '2012',
        '2016',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    inp = year

    global_dict = generation(inp)

    new_dict = dict()

    for uni in global_dict:

        new_dict.update({uni: global_dict[uni]['Total Generation']})

    top_producers = sorted(new_dict.items(), key=lambda x: x[1], reverse=True)

    return dict(top_producers)


def energy_type_breakdown(year: str):
    """
    Uses previous functions to generate a dictionary of the various
    types of fuel used by the university system in the US for 20XX.

    Parameters:
    -----------
    year: str
        This is the year to be analyzed.

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

    allowed_years = [
        '2008',
        '2012',
        '2016',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    inp = year

    data = generation(inp)

    rosetta_stone = fuel_type_code()

    fuel_breakdown = dict()

    for university in data:

        del data[university]['Total Generation']

        for fuel_type in data[university]:

            if fuel_type not in fuel_breakdown:

                counter = 0

                for mover in data[university][fuel_type]:

                    counter += data[university][fuel_type][mover]

                fuel_breakdown.update({fuel_type: counter})

            elif fuel_type in fuel_breakdown:

                counter = 0

                for mover in data[university][fuel_type]:

                    counter += data[university][fuel_type][mover]

                fuel_breakdown[fuel_type] += counter

    fuel_breakdown_decoded = dict()

    for fuel_type in fuel_breakdown:

        fuel_breakdown_decoded.update(
            {rosetta_stone[fuel_type]: fuel_breakdown[fuel_type]}
        )

    fuel_breakdown = fuel_breakdown_decoded

    return fuel_breakdown


def university_top_renewables(year: str):
    """
    This function uses earlier functions to establish an
    ordered dictionary of the top universities for
    renewable energy production in the USA in 20XX.

    Parameters:
    -----------
    year: str
        This is the year being analyzed.

    Returns:
    --------
    top_renewables: dictionary
        A dictionary containing the university as the
        key and the value is the amount of renewable
        energy produced in MWhrs.

    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    allowed_years = [
        '2008',
        '2012',
        '2016',
        '2018'
    ]

    if year not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
        )

    renewables_list = ['GEO', 'WND', 'SUN', 'WAT', 'OBG', 'OBL', 'OBS']

    inp = year

    global_dict = generation(inp)

    renewables_dict = dict()

    counter = 0

    for uni in global_dict:

        del global_dict[uni]['Total Generation']

        for fuel in global_dict[uni]:

            if fuel in renewables_list:

                for mover in global_dict[uni][fuel]:

                    counter += global_dict[uni][fuel][mover]

        renewables_dict.update({uni: counter})

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


def usage(year: str, sort: str = 'installed'):
    """
    This function generates a dictionary detailing how many universities
    are using each fuel type.

    Parameters:
    -----------
    usage: str
        An argument that signals whether 'active' or 'installed' information
        will be gathered from the 20XX year.
    year: str
        This is the year being analyzed.

    Returns:
    --------
    base_dict: dict
        A dictionary containing the fuel type as the key and the amount
        of universities using that fuel.

    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    allowed_years = [
        '2008',
        '2012',
        '2016',
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

    if year == '2018':

        labels = [
            'NG',
            'DFO',
            'RFO',
            'BIT',
            'SUB',
            'WAT',
            'WDS',
            'WND',
            'LFG',
            'SUN',
            'PC',
            'OBS',
            'MWH'
        ]

        if sort == 'installed':

            labels.append('KER')

            labels.append('PG')

            labels.append('OBL')

    elif year == '2016':

        labels = [
            'NG',
            'DFO',
            'RFO',
            'BIT',
            'SUB',
            'WAT',
            'WDS',
            'WND',
            'LFG',
            'SUN',
            'PC',
            'OBS',
            'OBL',
            'KER',
            'PG',
            'MWH'
        ]

    elif year == '2012':

        labels = [
            'NG',
            'DFO',
            'RFO',
            'BIT',
            'SUB',
            'WAT',
            'WDS',
            'WND',
            'LFG',
            'SUN',
            'PC',
            'OBS',
            'KER',
            'TDF',
            'OTH'
        ]

    elif year == '2008':

        labels = [
            'NG',
            'DFO',
            'RFO',
            'BIT',
            'SUB',
            'WAT',
            'WDS',
            'LFG',
            'PC',
            'OBS',
            'KER',
            'TDF'
        ]

    base_dict = dict()

    for fuel in labels:

        base_dict.update({fuel: 0})

    data = generation(inp)

    for university in data:

        del data[university]['Total Generation']

        for fuel_type in data[university]:

            if sort == 'installed':

                base_dict[fuel_type] += 1

            elif sort == 'active':

                summ = 0

                for mover in data[university][fuel_type]:

                    if data[university][fuel_type][mover] != 0:

                        summ += 1

                if summ != 0:

                    base_dict[fuel_type] += 1

    return base_dict


def capacity_factors():
    """
    This function generates a hard-coded dictionary
    containing the capacity factors for different fuels
    and movers. The values are defaulted to 1.0 if no
    capacity factor information can be found.

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
            'CT': 0.019
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


def university_capacity():
    """

    This function uses previous functions to generate
    a dictionary containing an estimate for the total
    capacity of each university in 2018.

    Returns:
    --------
    capacity: dict
        A dictionary with each university as a key and
        an estimate of the total capacity at the value in
        MW.

    """

    data = generation('2018')

    cf = capacity_factors()

    hours = 8760

    capacity = dict()

    for university in data:

        del data[university]['Total Generation']

        cap = 0

        for fuel in data[university]:

            for mover in data[university][fuel]:

                cap += data[university][fuel][mover] / hours / cf[fuel][mover]

        capacity.update({university: cap})

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


def split_dictionary(dictionary: dict, year: str):
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

    Returns:
    --------
    split: list
        This is a nested list that can be plotted.

    """

    if not isinstance(year, str):

        raise TypeError(
            "Argument 'year' must be of type 'str'."
        )

    allowed_years = [
        '2008',
        '2012',
        '2016',
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

    universities = list()

    if year == '2018':

        NG = list()
        DFO = list()
        RFO = list()
        BIT = list()
        SUB = list()
        WAT = list()
        WDS = list()
        WND = list()
        LFG = list()
        SUN = list()
        PC = list()
        OBS = list()
        OBL = list()
        MWH = list()

        for university, value in dictionary.items():

            universities.append(university)

            try:
                NG.append(value['NG'])
            except KeyError:
                NG.append(0)
            try:
                DFO.append(value['DFO'])
            except KeyError:
                DFO.append(0)
            try:
                RFO.append(value['RFO'])
            except KeyError:
                RFO.append(0)
            try:
                BIT.append(value['BIT'])
            except KeyError:
                BIT.append(0)
            try:
                SUB.append(value['SUB'])
            except KeyError:
                SUB.append(0)
            try:
                WAT.append(value['WAT'])
            except KeyError:
                WAT.append(0)
            try:
                WDS.append(value['WDS'])
            except KeyError:
                WDS.append(0)
            try:
                WND.append(value['WND'])
            except KeyError:
                WND.append(0)
            try:
                LFG.append(value['LFG'])
            except KeyError:
                LFG.append(0)
            try:
                SUN.append(value['SUN'])
            except KeyError:
                SUN.append(0)
            try:
                PC.append(value['PC'])
            except KeyError:
                PC.append(0)
            try:
                OBS.append(value['OBS'])
            except KeyError:
                OBS.append(0)
            try:
                OBL.append(value['OBL'])
            except KeyError:
                OBL.append(0)
            try:
                MWH.append(value['MWH'])
            except KeyError:
                MWH.append(0)

        split = [
            universities,
            NG,
            DFO,
            RFO,
            BIT,
            SUB,
            WAT,
            WDS,
            WND,
            LFG,
            SUN,
            PC,
            OBS,
            OBL,
            MWH
        ]

    elif year == '2016':

        NG = list()
        DFO = list()
        RFO = list()
        BIT = list()
        SUB = list()
        WAT = list()
        WDS = list()
        WND = list()
        LFG = list()
        SUN = list()
        PC = list()
        OBS = list()
        OBL = list()
        KER = list()
        PG = list()
        MWH = list()

        for university, value in dictionary.items():

            universities.append(university)

            try:
                NG.append(value['NG'])
            except KeyError:
                NG.append(0)
            try:
                DFO.append(value['DFO'])
            except KeyError:
                DFO.append(0)
            try:
                RFO.append(value['RFO'])
            except KeyError:
                RFO.append(0)
            try:
                BIT.append(value['BIT'])
            except KeyError:
                BIT.append(0)
            try:
                SUB.append(value['SUB'])
            except KeyError:
                SUB.append(0)
            try:
                WAT.append(value['WAT'])
            except KeyError:
                WAT.append(0)
            try:
                WDS.append(value['WDS'])
            except KeyError:
                WDS.append(0)
            try:
                WND.append(value['WND'])
            except KeyError:
                WND.append(0)
            try:
                LFG.append(value['LFG'])
            except KeyError:
                LFG.append(0)
            try:
                SUN.append(value['SUN'])
            except KeyError:
                SUN.append(0)
            try:
                PC.append(value['PC'])
            except KeyError:
                PC.append(0)
            try:
                OBS.append(value['OBS'])
            except KeyError:
                OBS.append(0)
            try:
                OBL.append(value['OBL'])
            except KeyError:
                OBL.append(0)
            try:
                KER.append(value['KER'])
            except KeyError:
                KER.append(0)
            try:
                PG.append(value['PG'])
            except KeyError:
                PG.append(0)
            try:
                MWH.append(value['MWH'])
            except KeyError:
                MWH.append(0)

        split = [
            universities,
            NG,
            DFO,
            RFO,
            BIT,
            SUB,
            WAT,
            WDS,
            WND,
            LFG,
            SUN,
            PC,
            OBS,
            OBL,
            KER,
            PG,
            MWH
        ]

    elif year == '2012':

        NG = list()
        DFO = list()
        RFO = list()
        BIT = list()
        SUB = list()
        WAT = list()
        WDS = list()
        WND = list()
        LFG = list()
        SUN = list()
        PC = list()
        OBS = list()
        KER = list()
        TDF = list()
        OTH = list()

        for university, value in dictionary.items():

            universities.append(university)

            try:
                NG.append(value['NG'])
            except KeyError:
                NG.append(0)
            try:
                DFO.append(value['DFO'])
            except KeyError:
                DFO.append(0)
            try:
                RFO.append(value['RFO'])
            except KeyError:
                RFO.append(0)
            try:
                BIT.append(value['BIT'])
            except KeyError:
                BIT.append(0)
            try:
                SUB.append(value['SUB'])
            except KeyError:
                SUB.append(0)
            try:
                WAT.append(value['WAT'])
            except KeyError:
                WAT.append(0)
            try:
                WDS.append(value['WDS'])
            except KeyError:
                WDS.append(0)
            try:
                WND.append(value['WND'])
            except KeyError:
                WND.append(0)
            try:
                LFG.append(value['LFG'])
            except KeyError:
                LFG.append(0)
            try:
                SUN.append(value['SUN'])
            except KeyError:
                SUN.append(0)
            try:
                PC.append(value['PC'])
            except KeyError:
                PC.append(0)
            try:
                OBS.append(value['OBS'])
            except KeyError:
                OBS.append(0)
            try:
                KER.append(value['KER'])
            except KeyError:
                KER.append(0)
            try:
                TDF.append(value['TDF'])
            except KeyError:
                TDF.append(0)
            try:
                OTH.append(value['OTH'])
            except KeyError:
                OTH.append(0)

        split = [
            universities,
            NG,
            DFO,
            RFO,
            BIT,
            SUB,
            WAT,
            WDS,
            WND,
            LFG,
            SUN,
            PC,
            OBS,
            KER,
            TDF,
            OTH
        ]

    elif year == '2008':

        NG = list()
        DFO = list()
        RFO = list()
        BIT = list()
        SUB = list()
        WAT = list()
        WDS = list()
        LFG = list()
        PC = list()
        OBS = list()
        KER = list()
        TDF = list()

        for university, value in dictionary.items():

            universities.append(university)

            try:
                NG.append(value['NG'])
            except KeyError:
                NG.append(0)
            try:
                DFO.append(value['DFO'])
            except KeyError:
                DFO.append(0)
            try:
                RFO.append(value['RFO'])
            except KeyError:
                RFO.append(0)
            try:
                BIT.append(value['BIT'])
            except KeyError:
                BIT.append(0)
            try:
                SUB.append(value['SUB'])
            except KeyError:
                SUB.append(0)
            try:
                WAT.append(value['WAT'])
            except KeyError:
                WAT.append(0)
            try:
                WDS.append(value['WDS'])
            except KeyError:
                WDS.append(0)
            try:
                LFG.append(value['LFG'])
            except KeyError:
                LFG.append(0)
            try:
                PC.append(value['PC'])
            except KeyError:
                PC.append(0)
            try:
                OBS.append(value['OBS'])
            except KeyError:
                OBS.append(0)
            try:
                KER.append(value['MWH'])
            except KeyError:
                KER.append(0)
            try:
                TDF.append(value['TDF'])
            except KeyError:
                TDF.append(0)

        split = [
            universities,
            NG,
            DFO,
            RFO,
            BIT,
            SUB,
            WAT,
            WDS,
            LFG,
            PC,
            OBS,
            KER,
            TDF
        ]

    return split


def plot_data(year_: str,
              total: bool = False,
              top_producers: bool = False,
              top_renewables: bool = False,
              fuel_breakdown: bool = False,
              capacity: bool = False,
              use: bool = False):
    """
    This function plots the data in the EIA spreadsheet
    for the universities depending on the arguments
    applied.

    Parameters:
    -----------
    year_: str
        This is the year to be analyzed.

    total: bool
        This argument determines whether or not the results
        for the function 'generation' will be plotted.
        Default is False.

    top_producers: bool
        This argument determines whether or not the results
        for the function 'university_top_producers' will be
        plotted. Default is False.

    top_renewables: bool
        This argument determines whether or not the results
        for the function 'university_top_renewables' will be
        plotted. Default is False.

    fuel_breakdown: bool
        This argument determines whether or not the results
        for the function 'energy_type_breakdown' will be
        plotted. Default is false.

    capacity: bool
        This argument determines whether or not the results
        for the function 'university_capacity' will be
        plotted. Default is false

    use: bool
        This argument determines whether or not the results
        for the function 'usage' will be plotted. Default is
        false.

    """

    if not isinstance(year_, str):

        raise TypeError(
            "Argument 'year_' must be of type 'str'."
        )

    allowed_years = [
        '2008',
        '2012',
        '2016',
        '2018'
    ]

    if year_ not in allowed_years:

        raise ValueError(
            f"Not a valid year. Possibilities include: {*allowed_years,}."
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

    inp = year_

    if total is True:

        data = generation(inp)

        data = dict(sorted(
            data.items(), key=lambda x: x[1]['Total Generation'], reverse=True
        ))

        segmented_dict = dict()

        for university in data:

            uni_dict = dict()

            del data[university]['Total Generation']

            for fuel in data[university]:

                counter = 0

                for mover in data[university][fuel]:

                    counter += data[university][fuel][mover]

                uni_dict.update({fuel: counter})

            segmented_dict.update({university: uni_dict})

        split = split_dictionary(dictionary=segmented_dict, year=inp)

        plt.figure(figsize=(25, 10))

        plt.title(f'Top Electrical Production from Education Sector ({year_})')

        plt.ylabel('Electicity Production (MWhr)')

        plt.xlabel('Universities', fontsize=8)

        plt.xticks(rotation='vertical')

        if year_ == '2018':

            labels = [
                'NG',
                'DFO',
                'RFO',
                'BIT',
                'SUB',
                'WAT',
                'WDS',
                'WND',
                'LFG',
                'SUN',
                'PC',
                'OBS',
                'OBL',
                'MWH'
            ]

            colors = [
                '#008b8b',
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
                '#FFFF00',
                '#0000FF',
                '#000000',
            ]

        elif year_ == '2016':

            labels = [
                'NG',
                'DFO',
                'RFO',
                'BIT',
                'SUB',
                'WAT',
                'WDS',
                'WND',
                'LFG',
                'SUN',
                'PC',
                'OBS',
                'OBL',
                'KER',
                'PG',
                'MWH'
            ]

            colors = [
                '#008B8B',
                '#FFFF00',
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
                '#FFA500'
            ]

        elif year_ == '2012':

            labels = [
                'NG',
                'DFO',
                'RFO',
                'BIT',
                'SUB',
                'WAT',
                'WDS',
                'WND',
                'LFG',
                'SUN',
                'PC',
                'OBS',
                'KER',
                'TDF',
                'OTH'
            ]

            colors = [
                '#008B8B',
                '#FFFF00',
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
            ]

        elif year_ == '2008':

            labels = [
                'NG',
                'DFO',
                'RFO',
                'BIT',
                'SUB',
                'WAT',
                'WDS',
                'LFG',
                'PC',
                'OBS',
                'KER',
                'TDF'
            ]

            colors = [
                '#008B8B',
                '#FFFF00',
                '#800080',
                '#FF0000',
                '#FF00FF',
                '#008000',
                '#DC7633',
                '#00FF00',
                '#00FFFF',
                '#000080',
                '#F08080',
                '#0000FF',
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

        producers = university_top_producers(year=year_)

        top_10 = dict()

        top_10_criteria = {
            '2018': 150000,
            '2016': 172000,
            '2012': 183610,
            '2008': 147000
        }

        for uni in producers:

            if producers[uni] >= top_10_criteria[year_]:

                top_10.update({uni: producers[uni]})

        universities_total = list()

        energy_total = list()

        for key, value in top_10.items():

            universities_total.append(key)

            energy_total.append(value)

        plt.figure()

        plt.title(f'Top Electrical Production from Education Sector ({year_})')

        plt.ylabel('Electicity Production (MWhr)')

        plt.xlabel('Universities')

        plt.xticks(rotation='vertical')

        plt.bar(universities_total, energy_total)

    if top_renewables is True:

        renewables = university_top_renewables(year=year_)

        ren_top_10 = dict()

        ren_top_10_criteria = {
            '2018': 5800,
            '2016': 5000,
            '2012': 3519,
            '2008': 0
        }

        for uni in renewables:

            if renewables[uni] >= ren_top_10_criteria[year_]:

                ren_top_10.update({uni: renewables[uni]})

        ren_universities_total = list()

        ren_energy_total = list()

        for key, value in ren_top_10.items():

            ren_universities_total.append(key)

            ren_energy_total.append(value)

        plt.figure()

        plt.title(
            f'Top Renewable Electric Production in Education Sector ({year_})'
        )

        plt.ylabel('Renewable Electicity Production (MWhr)')

        plt.xlabel('Universities')

        plt.xticks(rotation='vertical')

        plt.bar(ren_universities_total, ren_energy_total)

    if fuel_breakdown is True:

        breakdown = energy_type_breakdown(year=year_)

        pi_fuels = list()

        pi_energy = list()

        if year_ == '2018':

            label = [
                '',
                '90.3%',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                ''
            ]

            color = [
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
                '#e1ad01',
                '#b19cd9'
            ]

        elif year_ == '2016':

            label = [
                '',
                '89.3%',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                ''
            ]
            color = [
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
                '#FFA500'
            ]

        elif year_ == '2012':

            label = [
                '',
                '83.2%',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
            ]
            color = [
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
            ]

        elif year_ == '2008':

            color = [
                '#008B8B',
                '#FFFF00',
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
            ]

            label = [
                '',
                '69.9%',
                '',
                '26.2%',
                '',
                '',
                '',
                '',
                '',
                '',
                '',
                ''
            ]

        for key, value in breakdown.items():

            pi_fuels.append(key)

            pi_energy.append(value)

#         pi_fuels_new = list()

#         for i in pi_fuels:

#             pi_fuels_new.append(fuel_type_code()[i])

        plt.figure()

        fig1, ax1 = plt.subplots()

        plt.title(f'{year_} Energy Breakdown in Education')

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

        if year_ == '2018':

            cap = university_capacity()

            new_cap = dict()

            for uni in cap:

                if cap[uni] >= 2:

                    new_cap.update({uni: cap[uni]})

            cap = new_cap

            unis = list()

            capac = list()

            for key, value in cap.items():

                unis.append(key)

                capac.append(value)

            plt.figure(figsize=(15, 6))

            plt.title(
                f'Electric Production Capacity from Education Sector ({year_})'
            )

            plt.ylabel('Capacity (MW)')

            plt.xlabel('Universities', fontsize=8)

            plt.xticks(rotation='vertical')

            plt.bar(unis, capac)

        else:

            raise IndexError('Only allowed for 2018.')

    if use is True:

        inst = usage(year=year_, sort='installed')

        inst = sorted(inst.items(), key=lambda x: x[1], reverse=True)

        act = usage(year=year_, sort='active')

        act = sorted(act.items(), key=lambda x: x[1], reverse=True)

        plotting = [inst, act]

        for method in plotting:

            if method == inst:

                title = 'Installed'

            else:

                title = 'Active'

            fuels = list()

            unis = list()

            for key, value in method:

                fuels.append(key)

                unis.append(value)

            plt.figure()

            plt.title(f'{title} Fuel Usage by Universities in {year_}.')

            plt.ylabel('Number of Universities')

            plt.xlabel('Fuel Type')

            plt.xticks(rotation='vertical')

            plt.bar(fuels, unis)


def plot_energy_change(energy: str, university: str = 'all'):
    """
    This function plots how the a specific energy generation type
    has changed since 2008 for a desired university.

    Parameters:
    -----------
    energy: str
        This is the type of energy to be analyzed. Must be entered
        by fuel type code. For instance, natural gas is 'NG'.

    university: str
        This is the university whose data is to be examined.
        Default is 'all'

    """

    if not isinstance(energy, str):

        raise TypeError(
            "All arguments for this function must be of type 'str'."
        )

    if not isinstance(university, str):

        raise TypeError(
            "All arguments for this function must be of type 'str'."
        )

    data08 = generation('2008')
    data12 = generation('2012')
    data16 = generation('2016')
    data18 = generation('2018')

    dic_list = [
        data08,
        data12,
        data16,
        data18
    ]

    if (
            university not in data08.keys()) and (
            university not in data12.keys()) and (
            university not in data16.keys()) and (
            university not in data18.keys()):

        if university != 'all':

            raise ValueError(
                f"University '{university}' not supported."
            )

    try:

        energy_1 = fuel_type_code()[energy]

    except KeyError:

        raise ValueError(
            f"Energy type '{energy}' not supported."
        )

    if (
            energy_1 not in energy_type_breakdown('2008')) and (
            energy_1 not in energy_type_breakdown('2012')) and (
            energy_1 not in energy_type_breakdown('2016')) and (
            energy_1 not in energy_type_breakdown('2018')):

        raise ValueError(
            f"Energy type '{energy}' not present in education sector."
        )

    years = [
        '2008',
        '2012',
        '2016',
        '2018'
    ]

    amounts = list()

    if university == 'all':

        for year in years:

            try:

                amounts.append(energy_type_breakdown(year)[energy_1])

            except KeyError:

                amounts.append(0)

    else:

        for dic in dic_list:

            summ = 0

            try:

                for key in dic[university][energy]:

                    summ += dic[university][energy][key]

                amounts.append(summ)

            except KeyError:

                amounts.append(0)

    plt.figure()

    if university == 'all':

        plt.title(
            f'{energy_1} Change in Education Electricity Generation'
        )

    else:

        plt.title(
            f'{energy_1} Change in {university} Electricity Generation'
        )

    plt.ylabel('Generation (MWhr)')

    plt.bar(years, amounts)
