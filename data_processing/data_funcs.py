import re
import numba as nb 
import numpy as np
import pandas as pd

# ===================================================================
# Useful functions
# ===================================================================


def isfloat(value):
    """
    This function checks if a string can be converted to a float.

    Parameters:
    -----------
    value : string

    Returns:
    --------
    boolean
    """
    try:
        float(value)
        return True
    except ValueError:
        return False


def to_float(dataframe, column):
    """
    This function converts all values in a specified column to float.
    It is necessary to create my own function because the data has some
    errors in it that prevent it from being parsed as a single data type.

    Parameters:
    -----------
    dataframe : pandas dataframe
    column : string
        The name of the column in the dataframe that

    Returns:
    --------
    float_df : pandas dataframe
        This is the correctly formatted dataframe with the correct dtype.
    """

    float_df = dataframe

    for index, value in enumerate(float_df[column]):

        if isfloat(value):
            float_df.at[index, column] = float(value)
        elif (type(value) == str):
            value_float = re.findall(r"[-+]?\d*\.\d+|\d+", value)
            # value_float = [i for i in value.split() if i.isdigit()]
            if len(value_float) > 0:
                # If there was a value at the location
                float_df.at[index, column] = value_float[0]
            else:
                # If the value at location was NaN
                float_df.at[index, column] = -999.99

    float_df[column] = float_df[column].astype(float)
    return float_df


# @nb.jit
def make_increasing(data, sort=False, strict=True):
    """
    This function accepts a dataset or series that is not strictly
    increasing and forces it to be increasing.

    Parameters:
    -----------
    data : array or array-like
        The data you want to make monotonically increasing.
    sort : boolean, optional
        Indicates whether the data needs to be sorted. Default is False.
    strict : boolean, optional
        Indicates if the data should be strictly increasing or not. 
        Example: [1,1,2,3,4,5,5] is NOT strictly increasing because it 
        has repeated values. 

    Returns:
    --------
    data_inc : numpy array, array, or array-like
        The monotonically increasing data. 
    """
    
    
    if (strict is True) and (sort is False):
        curr_value = data[0]
        data_inc = [curr_value]
        for i in range(len(data)):
            next_value = data_inc[i]
            print("next value is {} : current value is {}".format(next_value, curr_value))
            if next_value > curr_value:
                print("inside if")
                data_inc.append(next_value)
            else:
                append_val = next_value
                while append_val <= curr_value:
                    print("inside while")
                    append_val = append_val + 0.000001
                data_inc.append(round(append_val,6))       
            curr_value = round(append_val,6)

    return data_inc

# def make_increasing(df, cols=None):
#     if cols is None:
#         cols = df.columns

#     df1 = df.copy()[cols]
#     # print(df1)
#     while True:
#         mon_inc = (df1.diff().fillna(0) >= 0).all(axis=1)
#         if mon_inc.all():
#             break
#         df1 = df1[mon_inc]
#     return df1


# single_digits = np.array([i for i in range(10)])
# repeat_vals = np.ones(10)

# # dataframe_pd = pd.DataFrame({'digits':single_digits, 'repeats':repeat_vals})
# inc = make_increasing(repeat_vals)
# print(inc)

# num = 1
# for i in range(10):
#     num = num + 0.1
#     print(num)
# # print(inc)