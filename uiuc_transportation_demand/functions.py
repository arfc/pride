def units():
    
    """
    This function creates a dictionary linking the fuel technology
    to its unit for clarity.
    
    Returns:
    --------
    Unit: dict
        Dictionary linking each fuel to its unit
        
    """
    Unit = {
        'Gasoline': 'gallon',
        'Diesel': 'gallon',
        'E85': 'gallon',
        'Hydrogen': 'kg',
        'Electricity': 'kWh'
    }
    
    return Unit



def gge_dictionary():

    """
    This function generates a hard coded dictionary of five of 
    the most relevant fleet fuel technologies and how many gallons
    of gasoline are equivalent to one unit of each.
    
    Returns:
    --------
    GGE: dict
        The dictionary to link fuel technoligies for their GGEs
        
    """
    
    GGE = dict()
    
    GGE = {
        'Gasoline': 1.0, 
        'Diesel': 1.155,
        'E85': 0.734,
        'Hydrogen': 1.019,
        'Electricity': 0.031
    }
    
    return GGE



def unit_cost_dictionary():
    
    """
    This function generates a hard coded dictionary of the $/unit 
    for the five most relevant fuel technologies.
    
    Returns:
    --------
    Cost: dict
        The dictionary linking fuel technologies to their cost per unit ($/unit)
        
    """
    
    Cost = {
        'Gasoline': 2.23,
        'Diesel': 2.41,
        'E85': 1.71,
        'Hydrogen': 13.99,
        'Electricity': 0.0426
    }
    
    return Cost



def gge_cost_dictionary():
    
    """
    This function generates a dictionary to link each of the five
    most relevant fuel technologies to the price of the fuel's
    equivalent value to 1.0 gallons of gasoline.
    
    Returns:
    --------
    GGECost: dict
        A dictionary linking fuel types to their corresponding
        price per equivalent to 1.0 gallons of gasoline.
    
    """
    
    GGECost = dict()
    
    GGEDictionary = gge_dictionary()
    
    CostDictionary = unit_cost_dictionary()
    
    for fuel in GGEDictionary:
        GGECost.update({fuel: CostDictionary[fuel] / GGEDictionary[fuel]})
    
    return GGECost



def fuel_equivalent(Fuel):

    """
    This function returns the total amount of desired fuel type
    required to fully manage the UIUC fleet in 2019 assuming it
    was readily available based on the fuel_data.csv
    
    Parameters:
    -----------
    Fuel: string
        Desired fuel type to analyze ('Gasoline', 'Diesel', 'E85',
        'Hydrogen', or 'Electicity')
        
    Returns:
    --------
    amount: float
        The total amount of units for desired fuel technology that would 
        have powered the UIUC fleet in 2019
        
    """
    
    if type(Fuel) != str:
        raise TypeError('Please ensure that the input parameter is of type "str".')
        
    Dictionary = gge_dictionary()
    
    if Fuel not in Dictionary:
        raise IndexError(f'{Fuel} not supported. Try "Gasoline", "Diesel", "E85", "Hydrogen", or "Electricity".')
    
    FuelData = 'fuel_data.csv'
    
    with open(FuelData,'r') as i:
        fueldata = i.readlines()
    
    lines = list()
    
    for line in fueldata:
        lines.append(line.split(','))
        
    counter = 0
        
    for line in lines:
        if line[6] == 'Asset':
            continue

        else:
            if line[16].split(' ')[2] == 'UNLEADED':
                
                counter += Dictionary['Gasoline'] * (float(line[16].split(' ')[0]))
                
            elif line[16].split(' ')[2] == 'DIESEL':
                
                counter += Dictionary['Diesel'] * (float(line[16].split(' ')[0]))
            
            elif line[16].split(' ')[2] == 'E85':
                
                counter += Dictionary['E85'] * (float(line[16].split(' ')[0]))
                
    allowed_fuels_function = {
        'Gasoline': round(counter,2),
        'Diesel': round(counter / Dictionary['Diesel'],2),
        'E85': round(counter / Dictionary['E85'],2),
        'Hydrogen': round(counter / Dictionary['Hydrogen']),
        'Electricity': round(counter / Dictionary['Electricity'])
    }
    
    amount = allowed_fuels_function[Fuel]
    
    return amount



def fuel_equivalent_cost(Fuel):
    
    """
    This function returns the total cost of operating the 2019 UIUC
    fleet on the desired fuel technology alone.
    
    Parameters:
    -----------
    Fuel: string
        Type of fuel technology to be analyzed ('Gasoline', 'Diesel',
        'E85', 'Hydrogen', or 'Electricity').
        
    Returns:
    --------
    cost: float
        The total cost in $ of using only that fuel technology type
        to replace the entire 2019 UIUC fleet fuel.
    
    """
    
    if type(Fuel) != str:
        raise TypeError('Please ensure that the input parameter is of type "str".')
    
    CostDictionary = unit_cost_dictionary()
    
    GGEDictionary = gge_dictionary()
    
    if Fuel not in GGEDictionary:
        raise IndexError(f"{Fuel} not supported in this function. Try 'Gasoline', 'Diesel', 'E85', 'Hydrogen', or 'Electricity'.")
    
    Fuel_Amount = fuel_equivalent(Fuel)
    
    cost = round(Fuel_Amount * CostDictionary[Fuel],2)
    
    return cost



def co2_equivalent():
    
    """
    This function generates a dictionary linking each fuel technology
    type with its equivalent CO2 emissions per unit
    
    Returns:
    -----------
    CO2: dict
        A dictionary linking each of the five main technology types
        to the equivalent amount of CO2 emitted per unit
    
    """
    
    CO2 = {
        'Gasoline': 8.89,
        'Diesel': 10.16,
        'E85': 5.75 * 0.85 + 8.89 * 0.15,
        'Hydrogen': 0,
        'Electricity': 0
    }
    
    return CO2



def co2_emissions(Fuel):
    
    """
    This function returns the total amount of equivalent CO2
    release in kg from running the 2019 UIUC fleet off of a
    desired fuel type alone.
    
    Parameters:
    -----------
    Fuel: string
        Type of fuel technology to be analyzed ('Gasoline', 'Diesel',
        'E85', 'Hydrogen', or 'Electricity').
        
    Returns:
    --------
    emissions: float
        The total amount of equivalent CO2 release in kg from using only
        the desired fuel technology to power the 2019 UIUC fleet.
    
    """
    
    if type(Fuel) != str:
        raise TypeError('Please ensure that the input parameter is of type "str".')
    
    GGEDictionary = gge_dictionary()
    
    CO2Dictionary = co2_equivalent()
    
    if Fuel not in GGEDictionary:
        raise IndexError(f"{Fuel} not supported in this function. Try 'Gasoline', 'Diesel', 'E85', 'Hydrogen', or 'Electricity'.")
    
    Fuel_Amount = fuel_equivalent(Fuel)
    
    emissions = round(Fuel_Amount * (CO2Dictionary[Fuel]),2)
    
    return emissions
