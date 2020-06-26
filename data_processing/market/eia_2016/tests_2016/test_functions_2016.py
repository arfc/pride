import pytest
from functions_2016 import fuel_type_code
from functions_2016 import mover_database
from functions_2016 import generation
from functions_2016 import university_top_producers
from functions_2016 import energy_type_breakdown
from functions_2016 import university_top_renewables
from functions_2016 import usage
from functions_2016 import split_dictionary
from functions_2016 import plot_data


def test_fuel_type_code():

    """
    This function should pass if fuel_type_code
    outputs the correct dictionary.

    """

    correct_dictionary = {
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

    assert correct_dictionary == fuel_type_code()


def test_mover_database():

    """
    This function will pass if mover_database
    outputs the correct hard-coded dictionary
    for the translation of each mover code.

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

    assert mover == mover_database()


def test_generation_1():

    """
    This function will pass if generation correctly
    handles the situation in which a university is
    listed twice but under a different sub-institution
    with a different region. A specific instance is
    University of Illinois is listed twice, but one is
    Urbana-Champaign while the other is Chicago.

    """

    data = generation()

    assert 'University of Illinois SERC' in data


def test_generation_2():

    """
    This function will pass if generation correctly
    calculates the total amount produced for a
    university on the spreadsheet selected at random.

    """

    data = generation()

    random_school = 'New Mexico State University'

    manual_total_gen = 37689.00

    assert data[random_school]['Total Generation'] == manual_total_gen


def test_university_top_producers():

    """
    This function will pass if university_top_producers
    correctly orders the results of generation from largest
    to smallest.

    """

    top_list = list(university_top_producers())

    top_dict = university_top_producers()

    for i in range(len(top_list)-1):

        assert top_dict[top_list[i]] >= top_dict[top_list[i+1]]


def test_university_top_renewables():

    """
    This function will pass if university_top_renewables
    correctly orders the results of generation from largest
    to smallest.

    """

    top_list = list(university_top_renewables())

    top_dict = university_top_renewables()

    for i in range(len(top_list)-1):

        assert top_dict[top_list[i]] >= top_dict[top_list[i+1]]


def test_usage_1():

    """
    This function will pass if usage is correctly designed to
    raise a TypeError if argument 'sort' is not of type 'str'.

    """

    arg = 0

    with pytest.raises(TypeError, match="Argument 'sort' must be"):

        usage(sort=arg)


def test_usage_2():

    """
    This function will pass if usage is correctly designed to
    raise a ValueError if argument 'sort' is not of value
    'installed' or 'active'.

    """

    arg = 'instaled'

    with pytest.raises(ValueError, match="Argument 'sort' must take value"):

        usage(sort=arg)


def test_split_dictionary():

    """
    This function will pass if split_dictionary is
    designed to correctly raise a TypeError if
    argument 'dictionary' is not of type 'dict'.

    """

    arg = list()

    with pytest.raises(TypeError, match="Argument 'dictionary' "):

        split_dictionary(dictionary=arg)


def test_plot_data():

    """
    This function will pass if plot_data is designed
    to correctly raise a TypeError if each argument is
    not of type 'bool'.

    """

    arg = 'True'

    with pytest.raises(TypeError,
                       match="Argument 'total' must be"):

        plot_data(total=arg)

    with pytest.raises(TypeError,
                       match="Argument 'top_producers' must be"):

        plot_data(top_producers=arg)

    with pytest.raises(TypeError,
                       match="Argument 'top_renewables' must be"):

        plot_data(top_renewables=arg)

    with pytest.raises(TypeError,
                       match="Argument 'fuel_breakdown' must be"):

        plot_data(fuel_breakdown=arg)

    with pytest.raises(TypeError,
                       match="Argument 'use' must be"):

        plot_data(use=arg)
