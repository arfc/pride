import pandas as pd
from data_funcs import isfloat
from data_funcs import to_float


# ===================================================================
# Tests for isfloat()
# ===================================================================

def test_isfloat1():
    """
    Tests case 1 : A float string can be cast to float
    """
    string = "0.01"
    a_float = isfloat(string)
    assert a_float


def test_isfloat2():
    """
    Tests case 2: A string cannot be cast to float
    """
    string = "0.01x"
    a_float = isfloat(string)
    assert not a_float


def test_isfloat3():
    """
    Tests case 3: An integer string can be cast to float
    """
    string = "42"
    a_float = isfloat(string)
    assert a_float


def test_isfloat4():
    """
    Test case 4: An alphanumeric string cannot be float
    """
    string = "42a"
    a_float = isfloat(string)
    assert not a_float


# ===================================================================
# Test for to_float()
# ===================================================================

dataframe = {'integers': [11, 250, 39, 42],
             'floats': ["0.91", "0.0001", 1.0, -777.2],
             'mixed': ["x87", "0.1x", "T", "11"]}

dataframe_pd = pd.DataFrame(dataframe)


def test_to_float1():
    """
    Test case 1: A column of integers will be converted to floats
    """
    new_df = to_float(dataframe_pd, 'integers')
    assert new_df['integers'].dtype == float


def test_to_float2():
    """
    Test case 2: A column of floats and float strings will be
    converted to floats
    """
    new_df = to_float(dataframe_pd, 'floats')
    assert new_df['integers'].dtype == float


def test_to_float3():
    """
    Test case 3: A column of mixed strings will be converted to
    floats or NaN value -999.99
    """
    new_df = to_float(dataframe_pd, 'mixed')
    assert new_df['integers'].dtype == float
