import numpy as np


def abbott_elec():
    """
    This function returns the price per kWh at APP

    Returns:
    --------
    per_kwh : float
        The price in dollars per kWh for electricity produced
        by APP
    """
    per_kwh = 0.08  # [$/kWh]
    return per_kwh


def to_kwh(m):
    """
    This function converts a mass flow rate in klbs/hr of steam
    to an energy in kWh. Known values are currently hard coded.

    Parameters:
    -----------
    m : float
        This is the mass of Abbott steam in klbs/hr

    Returns:
    --------
    kwh : float
        The energy equivalent in kWh thermal.
    """
    cp = 4243.5  # specific heat of water [J/ kg K]
    dT = 179  # change in steam temperature [deg C]
    h_in = 196  # inlet enthalpy [BTU/lb]
    h_out = 1368  # outlet enthalpy [BTU/lb]

    # times 0.29307107 to convert from BTU/hr to kilowatts
    kwh = (m * (h_out - h_in)) * 0.29307107
    return kwh


def abbott_steam():
    """
    This function returns the price per kwh thermal when that
    power is used to produce steam at APP.

    Returns:
    --------
    per_kwh : float
        The price per thermal kwh in dollars.
    """
    per_klb = 20  # dollars per klb of steam
    kwh_eq = to_kwh(1)  # kwh equivalent of steam
    per_kwh = per_klb / kwh_eq
    return per_kwh


def solar_ppa():
    """
    This function returns the price per kwh of electricity
    when it is produced by solar power at the UIUC solar farm.

    Returns:
    --------
    per_kwh : float
        The price per electric kWh in dollars.
    """
    per_kwh = 0.196  # [$/kWh]

    return per_kwh


def wind_ppa():
    """
    This function returns the price per kwh of electricity
    when it is produced by solar power at the UIUC solar farm.

    Returns:
    --------
    per_kwh : float
        The price per electric kWh in dollars.
    """
    per_kwh = 0.0384  # [$/kWh]

    return per_kwh


def dollars_offset(capacity, cf, lifetime, use, replacing, eta=0.33):
    """
    This function returns the cost of producing an amount of energy,
    equivalent to a nuclear reactor with given parameters, by some other
    method.

    Parameters:
    -----------
    capacity : float
        The thermal capacity of the nuclear reactor in [kWth]
    cf : float
        The capacity factor of the nuclear reactor. [-]
    lifetime : integer
        The energy producing lifetime of the nuclear reactor in [years]
    use : string
        The desired end use of the energy produced by the nuclear reactor.
        Accepted values: 'electricity', 'steam', 'hydrogen'
        Note: 'hydrogen' is not supported, yet.
    replacing : string
        The proposed replacement for the energy produced by a reactor.
        Accepted values: 'solar', 'wind', 'abbott_th', 'abbott_e'
        Where 'abbott_th' refers to thermal capacity from APP and
        'abbott_e' refers to electricity production.

    eta : float
        The thermal to electric conversion efficiency. Default is 0.33

    Returns:
    --------
    offset : float
        The number dollars required to produce an amount of energy
        equivalent to some reactor by some other method.
    """
    allowed_cases = { 
            'electricity': ['solar','wind', 'abbott_e'],
            'steam': ['abbott_th']
    }

    if replacing not in allowed_cases[use]:
        raise IndexError(f'{replacing} for {use} is not an allowed case.')

    hrs_per_year = 365*24
    lifetime = lifetime*hrs_per_year

    use_switcher = {
            'electricity': capacity*cf*lifetime*eta,
            'steam': capacity*cf*lifetime,
            'hydrogen': np.nan
    }

    energy_total = use_switcher[use]

    alternative_switcher = {
            'solar': solar_ppa(),
            'wind': wind_ppa(),
            'abbott_th': abbott_steam(),
            'abbott_e': abbott_elec()
    }

    alt_cost = alternative_switcher[replacing]

    offset = alt_cost*energy_total

    return offset
