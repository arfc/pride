import pandas as pd
import numpy as np
from data_funcs import isfloat
from data_funcs import to_float
from data_funcs import make_increasing

import pprint
import sys
pprint.pprint(sys.path)


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


# ===================================================================
# Test for make_increasing()
# ===================================================================
single_digits = np.array([i for i in range(10)])
repeat_vals = [1, 1, 1, 1, 1, 2, 3, 7, 8, 8, 24]


def test_make_increasing1():
    """
    Test case 1: A data series that is already increasing is passed.
    """
    inc_data = make_increasing(single_digits, sort=False, strict=True)
    increasing = all(i < j for i, j in zip(inc_data, inc_data[1:]))
    old_mean = single_digits.mean()
    new_mean = inc_data.mean()
    same_stats = abs(old_mean - new_mean) < 0.1
    assert increasing and same_stats


def test_make_increasing2():
    """
    Test case 2: A data series with repeated values is passed.
    """

    inc_data = make_increasing(repeat_vals, sort=False, strict=True)
    print(repeat_vals)
    increasing = all(i < j for i, j in zip(inc_data, inc_data[1:]))
    old_mean = np.array(repeat_vals).mean()
    new_mean = np.array(inc_data).mean()
    same_stats = abs(old_mean - new_mean) < 0.1
    assert increasing and same_stats
