import matplotlib.pyplot as plt
import numpy as np
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
    movers: dict
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


def generation(sheet: str = f'{path}eia_generation_2008.csv'):

    '''
    This function generates a nested dictionary of the Universities
    present in the 2008 EIA spreadsheet and their generation amounts
    by each fuel/mover type combination.

    Parameters:
    -----------
    sheet: str
        This is the string for the csv spreadsheet being analyzed.
        Defaulted to the csv this code was based on.

    Returns:
    --------
    gen_dict: dict
        Nested dictionary of the Universities present in the 2008 EIA
        spreadsheet and their generation amounts in MWhr by each fuel/mover
        type combination.

    '''

    Generation = sheet

    with open(Generation, 'r') as i:

        generation = i.read().splitlines()

    lines = list()

    for line in generation:

        lines.append(line.split(','))

    for i in range(8):

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


def university_top_producers():

    """
    This function uses earlier functions to generate a dictionary in
    descending order of the highest energy producing universities
    in the USA from 2008 and the amount of energy produced in MWhr.

    Returns:
    --------
    top_producers: dict
        This is a dictionary containing the university at the key
        and the amount of energy in MWhr at the value.

    """

    global_dict = generation()

    new_dict = dict()

    for uni in global_dict:

        new_dict.update({uni: global_dict[uni]['Total Generation']})

    top_producers = sorted(new_dict.items(), key=lambda x: x[1], reverse=True)

    return dict(top_producers)


def energy_type_breakdown():

    """
    Uses previous functions to generate a dictionary of the various
    types of fuel used by the university system in the US for 2008.

    Returns:
    --------
    fuel_breakdown: dict
        This is a dictionary with keys of each fuel type used by the
        university system in the USA in 2008 and values of the amounts.

    """

    data = generation()

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


def university_top_renewables():

    """
    This function uses earlier functions to establish an
    ordered dictionary of the top universities for
    renewable energy production in the USA in 2008.

    Returns:
    --------
    top_renewables: dictionary
        A dictionary containing the university as the
        key and the value is the amount of renewable
        energy produced in MWhrs.

    """
    renewables_list = ['GEO', 'WND', 'SUN', 'WAT', 'OBG', 'OBL', 'OBS']

    global_dict = generation()

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


def usage(sort: str = 'installed'):

    """
    This function generates a dictionary detailing how many universities
    are using each fuel type.

    Parameters:
    -----------
    usage: str
        An argument that signals whether 'active' or 'installed' information
        will be gathered from the 2008 year.

    Returns:
    --------
    base_dict: dict
        A dictionary containing the fuel type as the key and the amount
        of universities using that fuel.

    """

    allowed_strings = ['installed', 'active']

    if not isinstance(sort, str):

        raise TypeError("Argument 'sort' must be of type 'str'.")

    if sort not in allowed_strings:

        raise ValueError(
            "Argument 'sort' must take value of 'installed or 'active'."
        )

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

    data = generation()

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


def split_dictionary(dictionary: dict):

    """
    This function generates a nested list containing
    plottable portions of data. This is specifically for
    segmented bar graphs in later functions.

    Parameters:
    -----------
    dictionary: dict
        This is the dictionary to be split up.

    Returns:
    split: list
        This is a nested list that can be plotted.

    """

    if not isinstance(dictionary, dict):

        raise TypeError(
            "Argument 'dictionary' must be of type 'dict'."
        )

    universities = list()

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


def plot_data(total: bool = False,
              top_producers: bool = False,
              top_renewables: bool = False,
              fuel_breakdown: bool = False,
              use: bool = False):

    """
    This function plots the data in the EIA spreadsheet
    for the universities depending on the arguments
    applied.

    Parameters:
    -----------
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

    use: bool
        This argument determines whether or not the results
        for the function 'usage' will be plotted. Default is
        false.

    """

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

    if not isinstance(use, bool):

        raise TypeError(
            "Argument 'use' must be of type 'bool'."
        )

    plt.rcParams['figure.dpi'] = 600

    if total is True:

        data = generation()

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

        split = split_dictionary(segmented_dict)

        plt.figure(figsize=(25, 10))

        plt.title('Top Electrical Production from Education Sector (2008)')

        plt.ylabel('Electicity Production (MWhr)')

        plt.xlabel('Universities', fontsize=8)

        plt.xticks(rotation='vertical')

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
            '#008080',
        ]

        bot = np.zeros(len(split[0]))

        for i in range(12):

            plt.bar(
                split[0],
                np.array(split[i+1]),
                bottom=bot,
                label=fuel_type_code()[labels[i]],
                color=colors[i]
            )

            bot = bot + np.array(split[i+1])

        plt.legend(prop={'size': 12})

    if top_producers is True:

        producers = university_top_producers()

        top_10 = dict()

        for uni in producers:

            if producers[uni] >= 147000:

                top_10.update({uni: producers[uni]})

        universities_total = list()

        energy_total = list()

        for key, value in top_10.items():

            universities_total.append(key)

            energy_total.append(value)

        plt.figure()

        plt.title('Top Electrical Production from Education Sector (2008)')

        plt.ylabel('Electicity Production (MWhr)')

        plt.xlabel('Universities')

        plt.xticks(rotation='vertical')

        plt.bar(universities_total, energy_total)

    if top_renewables is True:

        renewables = university_top_renewables()

        ren_top_10 = dict()

        for uni in renewables:

            if renewables[uni] >= 0:

                ren_top_10.update({uni: renewables[uni]})

        ren_universities_total = list()

        ren_energy_total = list()

        for key, value in ren_top_10.items():

            ren_universities_total.append(key)

            ren_energy_total.append(value)

        plt.figure()

        plt.title(
            'Top Renewable Electrical Production from Education Sector (2008)'
        )

        plt.ylabel('Renewable Electicity Production (MWhr)')

        plt.xlabel('Universities')

        plt.xticks(rotation='vertical')

        plt.bar(ren_universities_total, ren_energy_total)

    if fuel_breakdown is True:

        breakdown = energy_type_breakdown()

        pi_fuels = list()

        pi_energy = list()

        for key, value in breakdown.items():

            pi_fuels.append(key)

            pi_energy.append(value)

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

        plt.figure()

        fig1, ax1 = plt.subplots()

        plt.title('2008 Energy Breakdown in Education')

        ax1.pie(
            pi_energy,
            startangle=90,
            colors=color,
            labels=label,
            labeldistance=0.5,
        )

        ax1.axis('equal')

        ax1.legend(pi_fuels, prop={'size': 6})

    if use is True:

        inst = usage(sort='installed')

        inst = sorted(inst.items(), key=lambda x: x[1], reverse=True)

        act = usage(sort='active')

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

            plt.title(f'{title} Fuel Usage by Universities in 2008.')

            plt.ylabel('Number of Universities')

            plt.xlabel('Fuel Type')

            plt.xticks(rotation='vertical')

            plt.bar(fuels, unis)
