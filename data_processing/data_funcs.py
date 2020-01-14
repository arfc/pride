import re

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
