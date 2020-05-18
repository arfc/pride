from offsets import to_kwh
from offsets import solar_ppa
from offsets import wind_ppa
from offsets import abbott_elec
from offsets import abbott_steam
from offsets import dollars_offset
import pytest

# ===================================================================
# Tests for abbott_elec()
# ===================================================================
def test_abbott_elec():
	p = abbott_elec()
	assert p == 0.08

# ===================================================================
# Tests for abbott_steam()
# ===================================================================
def test_abbott_elec():
	p = abbott_elec()
	assert p == 0.08

# ===================================================================
# Tests for solar_ppa()
# ===================================================================
def test_solar_ppa():
	p = solar_ppa()
	assert p == 0.196

# ===================================================================
# Tests for wind_ppa()
# ===================================================================
def test_wind_ppa():
	p = wind_ppa()
	assert p == 0.0384

# ===================================================================
# Tests for to_kwh()
# ===================================================================
mass = 1
def test_to_kwh():
	kwh = to_kwh(mass)
	pass


# ===================================================================
# Tests for to_kwh()
# ===================================================================
test_reactor1 = [100, 0.9, 25, 'steam', 'abbott_e']
test_reactor2 = [100, 0.9, 25, 'steam', 'abbott_th']
test_reactor3 = [100, 0.9, 25, 'electricity', 'abbott_th']
test_reactor4 = [100, 0.9, 25, 'electricity', 'solar']
test_reactor5 = [100, 0.9, 25, 'electricity', 'wind']
test_reactor6 = [100, 0.9, 25, 'electricity', 'abbott_e']

def test_dollars_offset_case1():
	"""
	dollars_offset case1 
	Test that exception is raised for invalid use and replacement
	combination.
	"""

	cap = test_reactor1[0]
	cf = test_reactor1[1]
	life = test_reactor1[2]
	end_use = test_reactor1[3]
	replacement = test_reactor1[4]

	with pytest.raises(IndexError) as error:
		assert dollars_offset(cap, cf, life, end_use, replacement)
	assert str(error.value) == f'{replacement} for {end_use} is not an allowed case.'



