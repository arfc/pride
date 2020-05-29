from functions import units
from functions import gge_dictionary
from functions import unit_cost_dictionary
from functions import gge_cost_dictionary
from functions import fuel_equivalent
from functions import fuel_equivalent_cost
from functions import co2_equivalent
from functions import co2_emissions
import pytest

# ============================================================================
# Tests for units()
# ============================================================================

def test_units():
    
    """
    Should not raise an error if units is correct.
    
    """
    
    test = units()
    
    assert test == {
        'Gasoline': 'gallon',
        'Diesel': 'gallon',
        'E85': 'gallon',
        'Hydrogen': 'kg',
        'Electricity': 'kWh'
    }
    
# ============================================================================
# Tests for gge_dictionary()
# ============================================================================

def test_gge_dictionary():
    
    """
    Should not raise an error if gge_dictionary is correctly formatted.
    
    """
    
    test = gge_dictionary()
    
    assert test == {
        'Gasoline': 1.0, 
        'Diesel': 1.155,
        'E85': 0.734,
        'Hydrogen': 1.019,
        'Electricity': 0.031
    }

# ============================================================================
# Tests for unit_cost_dictionary()
# ============================================================================

def test_unit_cost_dictionary():

    """
    Should not raise an error if unit_cost_dictionary is correctly formatted.
    
    """
    
    test = unit_cost_dictionary()
    
    assert test == {
        'Gasoline': 2.23,
        'Diesel': 2.41,
        'E85': 1.71,
        'Hydrogen': 13.99,
        'Electricity': 0.0426
    }
    
# ============================================================================
# Tests for gge_cost_dictionary()
# ============================================================================

def test_gge_cost_dictionary():
    
    """
    Should not raise an error if gge_cost_dictionary is correctly formatted.
    
    """
    
    test = gge_cost_dictionary()
    
    assert test == {
        'Gasoline': 2.23,
        'Diesel': 2.0865800865800868,
        'E85': 2.329700272479564,
        'Hydrogen': 13.729146221786067,
        'Electricity': 1.3741935483870968
    }
    
# ============================================================================
# Tests for fuel_equivalent()
# ============================================================================

def test_fuel_equivalent_1():
    
    """
    Should raise an IndexError if fuel_equivalent is properly set up.
    
    """
    
    fuel_test = 'Plutonium'
    
    assert fuel_equivalent(fuel_test)
    
    

def test_fuel_equivalent_2():
    
    """
    Should raise a TypeError if fuel_equivalent is properly set up.
    
    """
    Hydrogen = 4
    
    fuel_test = Hydrogen
    
    assert fuel_equivalent(fuel_test)
    
# ============================================================================
# Tests for fuel_equivalent_cost()
# ============================================================================

def test_fuel_equivalent_cost_1():
    
    """
    Should raise an IndexError if fuel_equivalent_cost is properly set up.
    
    """
    
    fuel_test = 'Plutonium'
    
    assert fuel_equivalent_cost(fuel_test)


    
def test_fuel_equivalent_cost_2():
    
    """
    Should raise a TypeError if fuel_equivalent_cost is properly set up.
    
    """
    
    Hydrogen = 4
    
    fuel_test = Hydrogen
    
    assert fuel_equivalent(fuel_test)
    
# ============================================================================
# Tests for co2_equivalent()
# ============================================================================

def test_co2_equivalent():
    
    """
    Should not raise an error if co2_equivalent is properly set up.
    
    """
    
    test = co2_equivalent()
    
    assert test == {
        'Gasoline': 8.89,
        'Diesel': 10.16,
        'E85': 6.221,
        'Hydrogen': 0,
        'Electricity': 0
    }

# ============================================================================
# Tests for co2_emissions()
# ============================================================================    

def test_co2_emissions_1():
    
    """
    Should raise an IndexError if co2_emissions is set up properly.
    
    """
    
    fuel_test = 'Plutonium'
    
    assert co2_emissions(fuel_test)
    

    
def test_co2_emissions_2():
    
    """
    Should raise a TypeError if co2_emissions is set up properly.
    
    """
    
    Hydrogen = 4
    
    fuel_test = Hydrogen
    
    assert co2_emissions(fuel_test)
