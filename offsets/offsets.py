import numpy as np 


def abbott_elec(): 
	"""
	This function returns the price per kWh at APP

	Returns:
	--------
	price : float
		The price per kWh for electricity produced by APP
	"""
	pass

def to_kwh(mdot):
	"""
	This function converts a mass flow rate in klbs/hr of steam
	to an energy in kWh. Known values are currently hard coded. 
	
	Parameters:
	-----------
	mdot : float
		This is the mass flow rate of Abbott steam in klbs/hr
	
	Returns:
	--------
	kwh : float
		The energy equivalent in kWh thermal. 
	"""

	cp = 4243.5 # specific heat of water [J/ kg K]
	dT = 179 # change in steam temperature [deg C]
	h_in = 196 # inlet enthalpy [BTU/lb]
	h_out = 1368 # outlet enthalpy [BTU/lb]

	# times 0.29307107 to convert from BTU/hr to kilowatts
	kwh = (mdot*(h_out-h_in))*0.29307107
	return kwh

def abbott_steam():
	pass

def solar_farm():
	pass

def wind_ppa():
	pass
	